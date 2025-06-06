%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
%}

%code requires {
// Attribute for expressions
typedef struct {
    char *place;
    char *code;
} Attr;
}

%{

void yyerror(const char *s);
int yylex(void);

// Temp variable and label generation
int temp_count = 0;
int label_count = 0;
char temp_names[100][16];
char label_names[100][16];

char* new_temp() {
    sprintf(temp_names[temp_count], "t%d", temp_count);
    return temp_names[temp_count++];
}

char* new_label() {
    sprintf(label_names[label_count], "L%d", label_count);
    return label_names[label_count++];
}
%}

%union {
    int ival;
    char *sval;
    Attr *attr;
}

%token <sval> ID
%token <ival> NUM
%token READ WRITE IF THEN ELSE END REPEAT UNTIL
%token PLUS MINUS MULTIPLY DIVIDE
%token ASSIGN EQUAL LESS
%token SEMICOLON LPAREN RPAREN

%type <sval> Program StmtList Stmt ReadStmt WriteStmt AssignStmt IfStmt ElsePart RepeatStmt
%type <attr> BoolExpr Expr Term Factor

%left PLUS MINUS
%left MULTIPLY DIVIDE

%%

Program:
    StmtList {
        if ($1) {
            printf("%s", $1);
            free($1);
        }
    }
    ;

StmtList:
    Stmt StmtList {
        size_t len = strlen($1) + strlen($2) + 1;
        char *temp = (char*)malloc(len);
        snprintf(temp, len, "%s%s", $1, $2);
        free($1);
        free($2);
        $$ = temp;
    }
    | /* empty */ {
        $$ = strdup("");
    }
    ;

Stmt:
    ReadStmt { $$ = $1; }
    | WriteStmt { $$ = $1; }
    | AssignStmt { $$ = $1; }
    | IfStmt { $$ = $1; }
    | RepeatStmt { $$ = $1; }
    ;

ReadStmt:
    READ ID SEMICOLON {
        char temp[256];
        snprintf(temp, sizeof(temp), "read %s\n", $2);
        free($2);
        $$ = strdup(temp);
    }
    ;

WriteStmt:
    WRITE Expr SEMICOLON {
        char *code = malloc(strlen($2->code) + strlen($2->place) + 16);
        sprintf(code, "%swrite %s\n", $2->code, $2->place);
        $$ = code;
        free($2->code); free($2->place); free($2);
    }
    ;

AssignStmt:
    ID ASSIGN Expr SEMICOLON {
        char *code = malloc(strlen($3->code) + strlen($1) + strlen($3->place) + 16);
        sprintf(code, "%s%s := %s\n", $3->code, $1, $3->place);
        $$ = code;
        free($1);
        free($3->code); free($3->place); free($3);
    }
    ;

IfStmt:
    IF BoolExpr THEN StmtList ElsePart END SEMICOLON {
        char *l_else = new_label();
        char *l_end = new_label();
        char *code = malloc(strlen($2->code) + strlen($2->place) + strlen($4) + strlen($5) + 128);
        sprintf(code, "%sif %s = 0 goto %s\n%s\ngoto %s\n%s:\n%s\n%s:\n",
            $2->code, $2->place, l_else, $4, l_end, l_else, $5, l_end);
        $$ = code;
        free($2->code); free($2->place); free($2);
        free($4); free($5);
    }
    ;

ElsePart:
      ELSE StmtList { $$ = $2; }
    | /* empty */ { $$ = strdup(""); }
    ;

RepeatStmt:
    REPEAT StmtList UNTIL BoolExpr SEMICOLON {
        char *l_start = new_label();
        char *code = malloc(strlen(l_start)*2 + strlen($2) + strlen($4->code) + strlen($4->place) + 128);
        sprintf(code, "%s:\n%s%sif %s = 0 goto %s\n",
            l_start, $2, $4->code, $4->place, l_start);
        $$ = code;
        free($2);
        free($4->code); free($4->place); free($4);
    }
    ;

BoolExpr:
    Expr LESS Expr {
        char* t = new_temp();
        size_t len = strlen($1->code) + strlen($3->code) + strlen(t) + strlen($1->place) + strlen($3->place) + 17;
        char* code = malloc(len);
        sprintf(code, "%s%s%s := %s < %s\n", $1->code, $3->code, t, $1->place, $3->place);
        $$ = (Attr*)malloc(sizeof(Attr));
        $$->place = strdup(t);
        $$->code = code;
        free($1->code); free($1->place); free($1);
        free($3->code); free($3->place); free($3);
    }
    | Expr EQUAL Expr {
        char* t = new_temp();
        size_t len = strlen($1->code) + strlen($3->code) + strlen(t) + strlen($1->place) + strlen($3->place) + 17;
        char* code = malloc(len);
        sprintf(code, "%s%s%s := %s = %s\n", $1->code, $3->code, t, $1->place, $3->place);
        $$ = (Attr*)malloc(sizeof(Attr));
        $$->place = strdup(t);
        $$->code = code;
        free($1->code); free($1->place); free($1);
        free($3->code); free($3->place); free($3);
    }
    ;

Expr:
    Expr PLUS Term {
        char* t = new_temp();
        size_t len = strlen($1->code) + strlen($3->code) + strlen(t) + strlen($1->place) + strlen($3->place) + 17;
        char* code = malloc(len);
        sprintf(code, "%s%s%s := %s + %s\n", $1->code, $3->code, t, $1->place, $3->place);
        $$ = (Attr*)malloc(sizeof(Attr));
        $$->place = strdup(t);
        $$->code = code;
        free($1->code); free($1->place); free($1);
        free($3->code); free($3->place); free($3);
    }
    | Expr MINUS Term {
        char* t = new_temp();
        size_t len = strlen($1->code) + strlen($3->code) + strlen(t) + strlen($1->place) + strlen($3->place) + 17;
        char* code = malloc(len);
        sprintf(code, "%s%s%s := %s - %s\n", $1->code, $3->code, t, $1->place, $3->place);
        $$ = (Attr*)malloc(sizeof(Attr));
        $$->place = strdup(t);
        $$->code = code;
        free($1->code); free($1->place); free($1);
        free($3->code); free($3->place); free($3);
    }
    | Term { $$ = $1; }
    ;

Term:
    Term MULTIPLY Factor {
        char* t = new_temp();
        size_t len = strlen($1->code) + strlen($3->code) + strlen(t) + strlen($1->place) + strlen($3->place) + 17;
        char* code = malloc(len);
        sprintf(code, "%s%s%s := %s * %s\n", $1->code, $3->code, t, $1->place, $3->place);
        $$ = (Attr*)malloc(sizeof(Attr));
        $$->place = strdup(t);
        $$->code = code;
        free($1->code); free($1->place); free($1);
        free($3->code); free($3->place); free($3);
    }
    | Term DIVIDE Factor {
        char* t = new_temp();
        size_t len = strlen($1->code) + strlen($3->code) + strlen(t) + strlen($1->place) + strlen($3->place) + 17;
        char* code = malloc(len);
        sprintf(code, "%s%s%s := %s / %s\n", $1->code, $3->code, t, $1->place, $3->place);
        $$ = (Attr*)malloc(sizeof(Attr));
        $$->place = strdup(t);
        $$->code = code;
        free($1->code); free($1->place); free($1);
        free($3->code); free($3->place); free($3);
    }
    | Factor { $$ = $1; }
    ;

Factor:
      LPAREN Expr RPAREN { $$ = $2; }
    | ID { 
        $$ = (Attr*)malloc(sizeof(Attr));
        $$->place = $1;
        $$->code = strdup("");
    }
    | NUM {
        char* t = new_temp();
        char* code = malloc(64);
        sprintf(code, "%s := %d\n", t, $1);
        $$ = (Attr*)malloc(sizeof(Attr));
        $$->place = strdup(t);
        $$->code = code;
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    yyparse();
    return 0;
}