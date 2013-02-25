function binaryPrecedence(operator) {
  switch (operator) {
    case '^':
      return 10;
    case '*': case '/': case '%':
      return 7;
    case '+': case '-':
      return 6;
    case '..':
      return 5;
    case '<': case '<=': case '>':
    case '>=': case '==': case '~=':
      return 3;
    case 'and':
      return 2;
    case 'or':
      return 1;
  }
  return 0;
}
