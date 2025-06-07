%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
[ \t\r\n]+     ; /* skip all whitespace, including indentation and newlines */
\{[^}]*\}      ; /* Comment: skip */
read           { return READ; }
write          { return WRITE; }
if             { return IF; }
then           { return THEN; }
else           { return ELSE; }
end            { return END; }
repeat         { return REPEAT; }
until          { return UNTIL; }
":="           { return ASSIGN; }
"="            { return EQUAL; }
"<"            { return LESS; }
"+"            { return PLUS; }
"-"            { return MINUS; }
"*"            { return MULTIPLY; }
"/"            { return DIVIDE; }
";"            { return SEMICOLON; }
"("            { return LPAREN; }
")"            { return RPAREN; }
[0-9]+         { yylval.ival = atoi(yytext); return NUM; }
[a-zA-Z][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return ID; }

.              { printf("Unexpected character: %s\n", yytext); }
%%

int yywrap(void) {
    return 1;
} 