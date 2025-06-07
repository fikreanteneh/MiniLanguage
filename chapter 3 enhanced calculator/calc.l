%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "y.tab.h"

void yyerror(char *);
extern int yylval;
extern double yylval_double;
%}

%%
[0-9]+          { yylval = atoi(yytext); return INTEGER; }
[0-9]+\.[0-9]+  { yylval_double = atof(yytext); return DOUBLE; }
[a-z]           { yylval = *yytext; return VARIABLE; }
sin             { return SIN; }
cos             { return COS; }
tan             { return TAN; }
log             { return LOG; }
PI              { yylval_double = M_PI; return DOUBLE; }
factorial       { return FACTORIAL; }
\^              { return '^'; }
[-+*/()=\n]     { return *yytext; }
[ \t]           ; /* Skip whitespace */
.               { yyerror("Invalid character"); }
%%

int yywrap(void) {
    return 1;
} 