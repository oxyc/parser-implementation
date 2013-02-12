function parseExpression() {
  return parseSubExpression(0);
}

function parseSubExpression(minPrecedence) {
  var expression;
  if (isUnary(token)) expression = unaryExpression(token, parseUnaryExpression());
  else if (isPimary(token)) expression = parsePrimaryExpression();
  else expression = parsePrefixExpression();

  while (true) {
    var operator = token
      , precedence = getPrecedence(operator);
    if (precedence <= minPrecedence) break;
    var right = parseSubExpression(precedence);
    expression = binaryExpression(expression, right);
  }
  return expression;
}
