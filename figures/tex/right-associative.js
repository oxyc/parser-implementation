while (true) {
  var operator = token
    , precedence = getPrecedence(operator);
  if (precedence <= minPrecedence) break;
  if (parseRightAssociative(operator)) precedence--;
  var right = parseSubExpression(precedence);
  expression = binaryExpression(expression, right);
}
