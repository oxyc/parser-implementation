function parseStatement() {
  if (Keyword === token.type) {
    switch (token.value) {
      case 'local':    next(); return parseLocalStatement();
      case 'if':       next(); return parseIfStatement();
      case 'return':   next(); return parseReturnStatement();
      case 'function': next();
        var name = parseFunctionName();
        return parseFunctionDeclaration(name);
      case 'while':    next(); return parseWhileStatement();
      case 'for':      next(); return parseForStatement();
      case 'repeat':   next(); return parseRepeatStatement();
      case 'break':    next(); return parseBreakStatement();
      case 'do':       next(); return parseDoStatement();
      case 'goto':     next(); return parseGotoStatement();
    }
  }
  if (Punctuator === token.type) {
    if (consume('::')) return parseLabelStatement();
  }
  if (consume(';')) return;
  return parseAssignmentOrCallStatement();
}
