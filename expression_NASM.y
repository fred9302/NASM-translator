%{
#include <stdio.h>
#include <math.h>
#include <string.h>
%}

%union {
	char           *string;
}

%token TAL 
%token var 
%token add 
%token divi
%token sub
%token mult
%token assign
%token EOFI

%type <string> TAL var add divi sub mult assign operator



%left '-' '+'
%right '*' '/'
%right UMINUS


%%

statement_list: 
            EOFI {print_table();exit(0);}
          | assignm_nl {/*printf("statement_list1\n");*/}
          | assignm_nl statement_list;
	  
operator: add|divi|sub|mult;

assignm_nl: assignment '\n';

assignment:  var assign var operator var {printf("MOV A,[%s]\n",$3);printf("%s A,[%s]\n",$4,$5);printf("MOV [%s],A\n",$1);}
  |var assign var {printf("MOV A,[%s]\n",$3);printf("MOV [%s],A\n",$1);};

/*more rules for other forms below - separated by | */
           
%%

int yywrap() { return 1; }

main()
{ 
  //init_sym();
  yyparse();
}
