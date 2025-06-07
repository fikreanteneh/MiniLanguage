%{
#include <stdio.h>
#include <string.h>

/* This LEX program recognizes basic C++ tokens. */
/* It's a foundational step for building a full validator. */

int is_valid = 1; 

%}

/* C++ Keywords */
KEYWORD          "alignas"|"alignof"|"and"|"and_eq"|"asm"|"auto"|"bitand"|"bitor"|"bool"|"break"|"case"|"catch"|"char"|"char8_t"|"char16_t"|"char32_t"|"class"|"compl"|"concept"|"const"|"consteval"|"constexpr"|"constinit"|"const_cast"|"continue"|"co_await"|"co_return"|"co_yield"|"decltype"|"default"|"delete"|"do"|"double"|"dynamic_cast"|"else"|"enum"|"explicit"|"export"|"extern"|"false"|"float"|"for"|"friend"|"goto"|"if"|"inline"|"int"|"long"|"mutable"|"namespace"|"new"|"noexcept"|"not"|"not_eq"|"nullptr"|"operator"|"or"|"or_eq"|"private"|"protected"|"public"|"reflexpr"|"register"|"reinterpret_cast"|"requires"|"return"|"short"|"signed"|"sizeof"|"static"|"static_assert"|"static_cast"|"struct"|"switch"|"synchronized"|"template"|"this"|"thread_local"|"throw"|"true"|"try"|"typedef"|"typeid"|"typename"|"union"|"unsigned"|"using"|"virtual"|"void"|"volatile"|"wchar_t"|"while"|"xor"|"xor_eq"

/* Identifiers */
IDENTIFIER       [a-zA-Z_][a-zA-Z0-9_]*

/* Constants */
INTEGER_CONST    [0-9]+
FLOATING_CONST   ([0-9]*\.[0-9]+|[0-9]+\.)([eE][+-]?[0-9]+)?|[0-9]+[eE][+-]?[0-9]+
CHAR_CONST       '[^']'
STRING_LITERAL   \"(\\.|[^"\\])*\"

/* Operators */
OPERATOR         "{"|"}"|"["|"]"|"#"|"##"|"("|")"|"<:"|":>"|"<%","%>"|"%:"|"%:%:"|";"|":"| "..."| "?"|"alignas"|"alignof"|"and"|"and_eq"|"asm"|"auto"|"bitand"|"bitor"|"bool"|"break"|"case"|"catch"|"char"|"char8_t"|"char16_t"|"char32_t"|"class"|"compl"|"concept"|"const"|"consteval"|"constexpr"|"constinit"|"const_cast"|"continue"|"co_await"|"co_return"|"co_yield"|"decltype"|"default"|"delete"|"do"|"double"|"dynamic_cast"|"else"|"enum"|"explicit"|"export"|"extern"|"false"|"float"|"for"|"friend"|"goto"|"if"|"inline"|"int"|"long"|"mutable"|"namespace"|"new"|"noexcept"|"not"|"not_eq"|"nullptr"|"operator"|"or"|"or_eq"|"private"|"protected"|"public"|"reflexpr"|"register"|"reinterpret_cast"|"requires"|"return"|"short"|"signed"|"sizeof"|"static"|"static_assert"|"static_cast"|"struct"|"switch"|"synchronized"|"template"|"this"|"thread_local"|"throw"|"true"|"try"|"typedef"|"typeid"|"typename"|"union"|"unsigned"|"using"|"virtual"|"void"|"volatile"|"wchar_t"|"while"|"xor"|"xor_eq"

/* Preprocessor Directives */
PREPROCESSOR     ^#[a-zA-Z]+

/* Comments */
SINGLE_COMMENT   \/\/.*
MULTI_COMMENT    \/\*([^*]|\*+[^*/])*\*+\/

/* Whitespace */
WHITESPACE       [ \t\n]+

%%

{KEYWORD}        { printf("TOKEN: KEYWORD, VALUE: %s\n", yytext); }
{IDENTIFIER}     { printf("TOKEN: IDENTIFIER, VALUE: %s\n", yytext); }
{INTEGER_CONST}  { printf("TOKEN: INTEGER_CONSTANT, VALUE: %s\n", yytext); }
{FLOATING_CONST} { printf("TOKEN: FLOATING_CONSTANT, VALUE: %s\n", yytext); }
{CHAR_CONST}     { printf("TOKEN: CHARACTER_CONSTANT, VALUE: %s\n", yytext); }
{STRING_LITERAL} { printf("TOKEN: STRING_LITERAL, VALUE: %s\n", yytext); }
{OPERATOR}       { printf("TOKEN: OPERATOR, VALUE: %s\n", yytext); }
{PREPROCESSOR}   { printf("TOKEN: PREPROCESSOR, VALUE: %s\n", yytext); }
{SINGLE_COMMENT} { /* Ignore single-line comments */ }
{MULTI_COMMENT}  { /* Ignore multi-line comments */ }
{WHITESPACE}     { /* Ignore whitespace */ }
.                { printf("ERROR: Invalid token '%s'\n", yytext); is_valid = 0; }

%%

int yywrap(void) {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <filename.cpp>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;
    yylex();

    printf("\n--- Recognition Result ---\n");
    if (is_valid) {
        printf("The C++ program appears to be valid.\n");
    } else {
        printf("The C++ program contains invalid tokens.\n");
    }

    fclose(file);
    return 0;
} 