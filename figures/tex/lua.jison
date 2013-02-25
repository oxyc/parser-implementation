/*
   Copyright 2011 Maximilian Herkender

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
%lex

%%

\s+                     /* skip whitespace */
"--[["(.|\n|\r)*?"]]" /* skip multiline comment */
"--".*                  /* skip comment */
"0x"[0-9a-fA-f]+        return 'NUMBER';
\d+(\.\d*)?([eE]"-"?\d+)? return 'NUMBER';
\.\d+([eE]"-"?\d+)?     return 'NUMBER';
"\""("\\".|[^"])*"\""   return 'STRING';
"'"("\\".|[^'])*"'"     return 'STRING';
"[["(.|\n|\r)*?"]]"     yytext = longStringToString(yytext); return 'STRING';
":"                     return ':';
";"                     return ';';
"("                     return '(';
")"                     return ')';
"["                     return '[';
"]"                     return ']';
"{"                     return '{';
"}"                     return '}';
"+"                     return '+';
"-"                     return '-';
"*"                     return '*';
"/"                     return '/';
"%"                     return '%';
"^"                     return '^';
"=="                    return '==';
"="                     return '=';
"~="                    return '~=';
"<="                    return '<=';
">="                    return '>=';
"<"                     return '<';
">"                     return '>';
"#"                     return '#';
","                     return ',';
"..."                   return '...';
".."                    return '..';
"."                     return '.';
"not"                   return 'NOT';
"and"                   return 'AND';
"or"                    return 'OR';
"true"                  return 'TRUE';
"false"                 return 'FALSE';
"nil"                   return 'NIL';
"function"              return 'FUNCTION';
"until"                 return 'UNTIL';
"do"                    return 'DO';
"end"                   return 'END';
"while"                 return 'WHILE';
"if"                    return 'IF';
"then"                  return 'THEN';
"elseif"                return 'ELSEIF';
"else"                  return 'ELSE';
"for"                   return 'FOR';
"local"                 return 'LOCAL';
"repeat"                return 'REPEAT';
"in"                    return 'IN';
"return"                return 'RETURN';
"break"                 return 'BREAK';
[a-zA-Z_][a-zA-Z0-9_]*  return 'NAME';
<<EOF>>                 return 'EOF';

/lex

%token NUMBER STRING ":" ";" "(" ")" "[" "]" "{" "}" "." "+" "-" "*" "/" "%" "^" "=" "==" "~=" "<" "<=" ">" ">=" ".." "#" "," "..." NOT AND OR TRUE FALSE NIL FUNCTION UNTIL DO END WHILE IF THEN ELSEIF ELSE FOR LOCAL REPEAT IN RETURN BREAK NAME EOF

%left "OR"
%left "AND"
%left "<" "<=" ">" ">=" "==" "~="
%right ".."
%left "+" "-"
%left "*" "/" "%"
%right "NOT" "#"
%right "^"

%start chunk

%%

chunk: block EOF {};

semi: ";" {} | {};

block: statlist {} | statlist laststat {};

prefixexp: var {} | functioncall {} | "(" exp ")" {};

statlist: stat semi statlist {} | {};

stat
  : varlist "=" explist {}
  | LOCAL namelist "=" explist {}
  | LOCAL namelist {}
  | functioncall {}
  | DO block END {}
  | WHILE exp DO block END {}
  | REPEAT block UNTIL exp {}
  | IF conds END {}
  | FOR namelist_setlocals "=" exp "," exp DO block END {}
  | FOR namelist_setlocals "=" exp "," exp "," exp DO block END {}
  | FOR namelist_setlocals IN explist DO block END {}
  | FUNCTION funcname funcbody {}
  | FUNCTION funcname ":" NAME funcbody {}
  | LOCAL FUNCTION name_setlocals funcbody {}
  ;

laststat: RETURN explist {} | RETURN {} | BREAK {};

conds: condlist {} | condlist ELSE block {};

condlist: cond {} | condlist ELSEIF cond {};

cond: exp THEN block {};

varlist: varlist "," var {} | var {};

explist: explist "," exp {} | exp {};

namelist_setlocals: namelist_setlocals "," NAME {} | NAME {};

namelist: namelist "," NAME {} | NAME { };

name_setlocals: NAME {};

arglist: arglist "," NAME {} | NAME {};

funcname: funcname "." NAME {} | NAME {};

exp
  : NUMBER { $$ = $1; }
  | STRING { $$ = $1; }
  | TRUE { $$ = true; }
  | FALSE { $$ = false; }
  | tableconstructor {}
  | NIL { $$ = null; }
  | prefixexp {}
  | FUNCTION funcbody {}
  | exp "+" exp {}
  | exp "-" exp {}
  | exp "*" exp {}
  | exp "/" exp {}
  | exp "^" exp {}
  | exp "%" exp {}
  | exp ".." exp {}
  | exp "<" exp {}
  | exp ">" exp {}
  | exp "<=" exp {}
  | exp ">=" exp {}
  | exp "==" exp {}
  | exp "~=" exp {}
  | exp AND exp {}
  | exp OR exp {}
  | "-" exp {}
  | NOT exp {}
  | "#" exp {}
  | "..." {}
  ;

tableconstructor: "{" "}" { } | "{" fieldlist fieldsepend "}" {};

funcbody: "(" ")" block END { } | "(" arglist ")" block END {}
  | "(" "..." ")" block END {} | "(" arglist "," "..." ")" block END {};

var: NAME {} | prefixexp "[" exp "]" {} | prefixexp "." NAME {};

functioncall: prefixexp args {} | prefixexp ":" NAME args {};

args: "(" explist ")" {} | "(" ")" {} | tableconstructor {} | STRING {};

fieldlist: field {} | fieldlist fieldsep field {};

field: exp {} | NAME "=" exp {} | "[" exp "]" "=" exp {};

fieldsep: ";" {} | "," {};

fieldsepend: ";" {} | "," {} | {};

%%

module.exports = parser;
