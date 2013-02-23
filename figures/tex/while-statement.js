function parseWhileStatement() {
  condition = parseExpression();
  expect('do');
  body = parseBlock();
  expect('end');

  return {
    type: 'WhileStatement',
    condition: condition,
    block: block
  };
}
