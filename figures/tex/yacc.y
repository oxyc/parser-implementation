%token VARIABLE EQUAL_SIGN INTEGER STRING
%%
statement:    declaration;
declaration:  VARIABLE EQUAL_SIGN primary { printf("Valid declaration"); }
primary:      INTEGER | STRING;
%%

main() {
  do {
    yyparse();
  } while(!feof(input));
}
