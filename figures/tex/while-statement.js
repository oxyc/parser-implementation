function parseWhileStatement() {
  var condition = parseExpression();
  expect('do');
  var body = parseBlock();
  expect('end');
  return ast.whileStatement(condition, body);
}
