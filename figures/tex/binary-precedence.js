function parseSubExpression(minPrecedence = 0) {
  expression = parseOperand();

  while (true) {
    operator = parseToken();
    precedence = getPrecedence(operator);

    if (precedence > minPrecedene) {
      var right = parseSubExpression(precedence);
      expression = binaryExpression(operator, expression, right);
    } else {
      break;
    }
  }
  return expression;
}
