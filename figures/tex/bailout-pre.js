function isUnary(token) {
  switch (token.type) {
    case Tokens.Punctuator:
      return ~'#-'.indexOf(token.value);
    case Tokens.Keyword:
      return token.value === 'not';
  }
  return false;
}
