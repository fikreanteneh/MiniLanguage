%{
#include <stdio.h>

int positive_integers = 0;
int negative_integers = 0;
int positive_fractions = 0;
int negative_fractions = 0;
%}

INTEGER   [0-9]+
FRACTION  ([0-9]*\.[0-9]+|[0-9]+\.)([eE][+-]?[0-9]+)?|[0-9]+[eE][+-]?[0-9]+

%%
\/\/.*                                  { /* Ignore single-line comments */ }
\/\*([^*]|\*+[^*/])*\*+\/              { /* Ignore multi-line comments */ }
\"(\\.|[^"\\])*\"                      { /* Ignore string literals */ }
\'(\\.|[^'\\])*\'                      { /* Ignore character literals */ }

\+{FRACTION}                            { positive_fractions++; }
-{FRACTION}                             { negative_fractions++; }
{FRACTION}                              { positive_fractions++; }

\+{INTEGER}                             { positive_integers++; }
-{INTEGER}                              { negative_integers++; }
{INTEGER}                               { positive_integers++; }

[a-zA-Z_][a-zA-Z0-9_]*                  { /* Ignore identifiers */ }
.|\n                                    { /* Ignore all other characters */ }
%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    yylex();

    printf("\n--- Count Results ---\n");
    printf("Positive Integers: %d\n", positive_integers);
    printf("Negative Integers: %d\n", negative_integers);
    printf("Positive Fractions: %d\n", positive_fractions);
    printf("Negative Fractions: %d\n", negative_fractions);

    fclose(file);
    return 0;
} 