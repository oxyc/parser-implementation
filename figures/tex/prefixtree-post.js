function binaryPrecedence(operator) {
    var char = operator.charCodeAt(0)
      , length = operator.length;

    if (1 === length) {
      switch (char) {
        case 94: return 10; // ^
        case 42: case 47: case 37:
          return 7; // * / %
        case 43: case 45: return 6; // + -
        case 60: case 62: return 3; // < >
      }
    } else if (2 === length) {
      switch (char) {
        case 46: return 5; // ..
        case 60: case 62: case 61: case 126:
          return 3; // <= >= == ~=
        case 111: return 1; // or
      }
    } else if (97 === char
      && 'and' === operator)
      return 2;
    return 0;
  }
