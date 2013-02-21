%option noyywrap
              #include <stdio.h>
%%
[ \t\n]+      ;
[a-zA-Z]+     { printf("Variable: %s\n", yytext); }
[0-9]+        { printf("Integer: %s\n", yytext); }
=             { printf("Equal sign\n"); }
%%

main() {
  yylex();
}
