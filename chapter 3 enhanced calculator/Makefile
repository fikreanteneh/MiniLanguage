CC = gcc
CFLAGS = -Wall -lm

calc: y.tab.c lex.yy.c
	$(CC) -o calc y.tab.c lex.yy.c $(CFLAGS)

y.tab.c: calc.y
	yacc -d calc.y

lex.yy.c: calc.l
	lex calc.l

clean:
	rm -f calc y.tab.c y.tab.h lex.yy.c 