%{
#include <stdio.h>
#include <stdlib.h>

int line_number = 1;
%}

%option noyywrap

%%
"if"            { printf("IF\t\t\t%s\n", yytext); }
"then"          { printf("THEN\t\t\t%s\n", yytext); }
"else"          { printf("ELSE\t\t\t%s\n", yytext); }
"end"           { printf("END\t\t\t%s\n", yytext); }
"repeat"        { printf("REPEAT\t\t%s\n", yytext); }
"until"         { printf("UNTIL\t\t\t%s\n", yytext); }
"read"          { printf("READ\t\t\t%s\n", yytext); }
"write"         { printf("WRITE\t\t%s\n", yytext); }

":="            { printf("ASSIGN\t\t%s\n", yytext); }
"+"             { printf("PLUS\t\t\t%s\n", yytext); }
"-"             { printf("MINUS\t\t%s\n", yytext); }
"*"             { printf("TIMES\t\t%s\n", yytext); }
"/"             { printf("DIVIDE\t\t%s\n", yytext); }
"<"             { printf("LT\t\t\t%s\n", yytext); }
"="             { printf("EQ\t\t\t%s\n", yytext); }

";"             { printf("SEMICOLON\t%s\n", yytext); }
"("             { printf("LPAREN\t\t%s\n", yytext); }
")"             { printf("RPAREN\t\t%s\n", yytext); }

[a-zA-Z_][a-zA-Z0-9_]* { printf("ID\t\t\t%s\n", yytext); }

[0-9]+          { printf("NUM\t\t\t%s\n", yytext); }

\{[^}]*\}       { /* Comment: skip */ }
[ \t\n]+          { /* White Space Skip */ }

%%

int main(int argc, char **argv)
{
    // -[0-9]+         { printf("NUM\t\t\t%s\n", yytext); } APPLY THIS RULE IF NECCESSARY Becuase - num and num
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <source_file.mini>\n", argv[0]);
        exit(1);
    }

    FILE *source = fopen(argv[1], "r");
    if (!source) {
        perror("Error opening file");
        exit(1);
    }

    yyin = source;  // Set input for the scanner
    printf("Scanning MINI language source: %s\n\n", argv[1]);
    yylex();
    fclose(source);
    return 0;
}
