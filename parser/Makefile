CC = gcc
CFLAGS = -Wall

all: parser

parser: y.tab.c lex.yy.c
	$(CC) $(CFLAGS) -o parser y.tab.c lex.yy.c -ll

y.tab.c: grammar.y
	yacc -d grammar.y

lex.yy.c: lexer.l
	lex lexer.l

clean:
	rm -f parser y.tab.c y.tab.h lex.yy.c 