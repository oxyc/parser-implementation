while (true) {
  operator = parseToken();
  precedence = getPrecedence(operator);

  if (precedence > minPrecedene) {
    if (parseRightAssociative(operator)) precedence -= 1;
    var right = parseSubExpression(precedence);
    expression = binaryExpression(operator, expression, right);
  } else {
    break
  }
}
