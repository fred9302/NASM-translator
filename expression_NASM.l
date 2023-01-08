%{
#include <stdio.h>
#include <math.h>
#include <string.h>
#include "expression_NASM.tab.h"

char symbol_table[100][20];
int symbol_table_len=-1;

char var_table[100][20];
char n = 0;

/*commented code is only for standalone lex test*/
/*union YYSTYPE
{
	char           *string;
	double          dval;
};

typedef union YYSTYPE YYSTYPE;
YYSTYPE yylval;

enum symtab{TAL,BYTE,var,add,divi,sub,mult,assign};
*/



/*example functions */
int insert_symbol(char* name)
{
}

void print_table()
{
}

void insert_var(char* str)
{
  strcpy(var_table[n], str);
}

void print_cell()
{
  printf("The variable stored in row %d of the table is: '%s'\n", n, var_table[n]);
  n++;
}


%}

letter [a-zA-Z]
digit  [0-9]
TAL    {digit}+
VAR    {letter}+
add   \+
divi  \/
sub   \-
mult  \*
operator {add}|{divi}|{sub}|{mult}
assign  \=




%%
{TAL}  {/*printf("TAL: %s\n",yytext);*/yylval.string = strdup(yytext);return(TAL);}
{VAR}    {insert_var(yytext);print_cell();printf("%s: db 0\n",yytext);yylval.string = strdup(yytext);return(var);}
{add}    {/*printf("add: %s\n",yytext);*/yylval.string = "ADD";return(add);}
{divi}  {yylval.string = "DIVIDE";return(divi);}
{sub}   {yylval.string = "SUBTRACT";return(sub);}
{mult}  {yylval.string = "MULTIPLY";return(mult);}
{assign} {return(assign);}



<<EOF>> {/*printf("EOF\n");*/ return(EOFI);}
[ \t\n] {/*printf("NL\n");*/return(yytext[0]);};
.       {printf("enkelt tegn:\t %s\n",yytext);}
%%


/*example main fct for standalone lex test*/
/*
main()
{
  int token=0;
char *yyt;
while(1){
  token=yylex();
  if(token==2)
  {
    insert_symbol(yytext);
    print_table();
  }
  
  printf("Token= %d\n",token);
  printf("yylval: %s\n",yylval.string);
  printf("yytext= %s\n",yytext);
  printf("yytext= %s\n",yyt);
  if(token==1)
    printf("val: %f\n",convertType(yytext,yyleng));
  printf("yyval= %d\n",yyval);
}

}
*/
