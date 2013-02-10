function isUnary(token) {
  if (token.type === Tokens.Punctuator)
    return ~'#-'.indexOf(token.value);
  if (token.type === Tokens.Keyword)
    return token.value === 'not';
}
