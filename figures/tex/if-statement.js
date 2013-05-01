function parseIfStatement() {
  clauses = [];

  do {
    condition = parseExpression();
    expect('then');
    block = parseBlock();
    clauses.push({
      condition: condition,
      block: block
    });
  } while (consume('elseif'));

  if (consume('else')) {
    clauses.push({
      block: parseBlock()
    });
  }
  expect('end');

  return {
    type: 'IfStatement',
    clauses: clauses
  };
}
