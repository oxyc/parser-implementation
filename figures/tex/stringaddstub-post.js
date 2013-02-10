var start = index;
while (isIdentPart(input.charCodeAt(index)))
  index++;

var value = input.slice(start, index);
