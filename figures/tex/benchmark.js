var fs = require('fs'),
  jison = require('./lua_parser'),
  luaparse = require('luaparse'),
  Benchmark = require('benchmark'),
  suite = new Benchmark.Suite,
  source = fs.readFileSync(process.argv[2], 'utf8'),
  isEOF = false,
  jisonLexer = jison.lexer,
  parser;

var luaparseLexer = {
  setInput: function(_input) {
    luaparse.parse(_input, { wait: true });
    luaparse.rewind();
    isEOF = false;
  },
  lex: function() {
    var token = luaparse.lex();

    switch (token.type) {
      case 4: // Keyword
        return token.value.toUpperCase();
      case 2: // StringLiteral
        return 'STRING';
      case 16: // NumericLiteral
        return 'NUMBER';
      case 128: // NilLiteral
        return 'NIL';
      case 1: // EOF
        // jison expects the input to stop after EOF.
        if (!isEOF) {
          isEOF = true;
          return 'EOF';
        }
        return '';
      case 8: // Identifier
        return 'NAME';
      case 64: // BooleanLiteral
        return token.value ? 'TRUE' : 'FALSE';
      default:
        return token.value;
    }
  }
};


suite
  .add('jison-lexer', function() {
    jison.parse(source);
  }, { onStart: function() { jison.lexer = jisonLexer; } })
  .add('luaparse-lexer', function() {
    jison.parse(source);
  }, { onStart: function() { jison.lexer = luaparseLexer; } })
  .add('luaparse', function() {
    luaparse.parse(source);
  })
  .on('cycle', function(e) {
    var target = e.target,
      variance = target.stats.variance * 1000 * 1000,
      stats = [
        target.stats.mean * 1000,
        Math.sqrt(variance),
        variance
      ];
    console.log(target.name + '\t' + stats.join('\t'));
  });

suite.run();
