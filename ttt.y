%{
#include<stdio.h>
#include<unistd.h>
#include "gramtree_v1.h"
%}

%token DECL BEG END ENFORCE
%token VOID BOOL
%token SKIP GOTO RETURN
%token IF THEN ELSE FI
%token WHILE DO OD
%token ASSERT EQ
%token ID T F DECIDER UEQ ARROW

%%
prog  : |decl1 proc1{$$=newast("Prog",1,$1);printf("打印syntax tree:\n");eval($$,0);printf("syntax tree打印完毕!\n\n");}
      ;
decl1 :
      | decl decl1
      ;
proc1 :
      | proc proc1
      ;
decl  : DECL id2
      ;
id2   : ID
      | ID id2
      ;
proc  : type ID '(' id1 ')' BEG enforce decl1 sseq END
      ;
id1   :
      | ID id1
      ;
type  : VOID
      | BOOL
      ;
enforce : ENFORCE expr ';'
        ;
sseq  : lstmt2
      ;
lstmt2: lstmt
      | lstmt lstmt2
      ;
lstmt : stmt
      | ID ':' stmt
      ;
stmt  : SKIP ';'
      | GOTO ID ';'
      | RETURN ID ';'
      | ID EQ expr ';'
      | IF '(' DECIDER ')' THEN sseq ELSE sseq FI
      | WHILE '(' expr ')' DO sseq OD
      | ASSERT '(' expr ')' ';'
      | ID EQ ID '(' expr1 ')'
      ;
expr1 :
      | expr expr1
      ;
expr  : expr '|' expr
      | expr '&' expr
      | expr '^' expr
      | expr '=' expr
      | expr UEQ expr
      | expr ARROW expr
      | '(' expr ')'
      | '!' expr
      | ID
      | const
      | '*'
      ;
const	:	T
			|	F
			;
%%
