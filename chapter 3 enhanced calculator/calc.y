%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double sym[26];  // Changed to double to support floating-point values
double yylval_double;

int yylex(void);
void yyerror(char *);
%}

%token INTEGER DOUBLE VARIABLE
%token SIN COS TAN LOG FACTORIAL
%left '+' '-'
%left '*' '/'
%left '^'
%left UMINUS

%%
program:
    | program statement '\n'
    ;

statement:
    expression    { printf("%g\n", $1); }
    | VARIABLE '=' expression { sym[$1] = $3; }
    ;

expression:
    INTEGER      { $$ = $1; }
    | DOUBLE     { $$ = $1; }
    | VARIABLE   { $$ = sym[$1]; }
    | expression '+' expression { $$ = $1 + $3; }
    | expression '-' expression { $$ = $1 - $3; }
    | expression '*' expression { $$ = $1 * $3; }
    | expression '/' expression { $$ = $1 / $3; }
    | expression '^' expression { $$ = pow($1, $3); }
    | '-' expression %prec UMINUS { $$ = -$2; }
    | '(' expression ')' { $$ = $2; }
    | SIN '(' expression ')' { $$ = sin($3); }
    | COS '(' expression ')' { $$ = cos($3); }
    | TAN '(' expression ')' { $$ = tan($3); }
    | LOG '(' expression ')' { $$ = log10($3); }
    | FACTORIAL '(' expression ')' {
        double result = 1;
        for(int i = 2; i <= $3; i++) {
            result *= i;
        }
        $$ = result;
    }
    ;
%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
    yyparse();
    return 0;
} 