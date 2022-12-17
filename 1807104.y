%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<math.h>
	#include<string.h>

	int sym[30];

	
	int variablenumber=0;
	int expressionnumber=0;
	int variableassignment=0;
	int printnumber=0;
	int mathexpressionnumber=0;
	int ifelsenumber=0;
	int whilenumber=0;
	int functionnumber=0;
	int switchnumber=0;
	int fornumber=0;
	int yylex();
	void yyerror(const char *s);
	void mystr(int ele,char *ss)
	{
		
	}
	

%}

%start line

%token DIGIT VARIABLE WHETHER OTHERWISE ELIF SUPREME INTEGER NONINTEGER LETTER BRACKETFIRST BRACKETLAST OPTION MATCH OUTPUT ORIGINAL WHILELOOP FORLOOP POWERFUNC VARCHAR SIN COS TAN FACTO CHECKODDEVEN SUCHTHAT KILL FLOW

%nonassoc IFX
%nonassoc ELSE


%left '<' '>'
%left '+' '-'
%left '*' '/'
%%



line: /* NULL */ 
	| line statement
	 ;
program: SUPREME ':' BRACKETFIRST line BRACKETLAST {printf("Main function END\n");}
	 ;

statement: ';'			
	| declaration ';'		{ printf("Declaration\n"); variablenumber++;}

	| expression ';' 			{   printf("\nvalue of expression: %d\n", $1); 
		$$=$1;
		printf("\n.........................................\n");
		expressionnumber++;
		}
	
	| VARIABLE '=' expression ';' { 
							printf("\nValue of the variable: %d\n",$3);
							sym[$1]=$3;
							$$=$3;
							printf("\n.........................................\n");
						variableassignment++;
						} 
	

	| WHETHER '(' expression ')' BRACKETFIRST statement BRACKETLAST OTHERWISE BRACKETFIRST statement BRACKETLAST {
								if($3){
									printf("value of expression in IF: %d\n",$6);
								}
								else{
									printf("value of expression in ELSE: %d\n",$10);
								}
								ifelsenumber++;
								printf("\n.........................................\n");
								
							}
	| WHILELOOP '(' DIGIT '<' DIGIT ')' BRACKETFIRST statement BRACKETLAST  {
	                                int i;
	                                printf("WHILE loop is started");
	                                for(i=$3 ; i<$5 ; i++) 
	                                {
	                                	printf("\nvalue: %d expression value: %d\n", i,$8);}
	                               printf("WHILE loop finished\n");								
				               whilenumber++;
				               }
	| WHILELOOP '(' DIGIT '>' DIGIT ')' BRACKETFIRST statement BRACKETLAST  {
	                                int i;
	                                printf("WHILE loop is started");
	                                for(i=$3 ; i>$5 ; i--) {printf("\nloop: %d expression value: %d\n", i,$8);}
	                                printf("WHILE loop finished\n");								
				               whilenumber++;
				               }
    | WHILELOOP '(' DIGIT '<''=' DIGIT ')' BRACKETFIRST statement BRACKETLAST  {
	                                int i;
	                                printf("WHILE loop is started");
	                                for(i=$3 ; i<=$6; i++) 
	                                {
	                                	printf("\nloop: %d expression value: %d\n", i,$9);}
	                                printf("WHILE loop finished\n");								
				               whilenumber++;
				               }
	| WHILELOOP '(' DIGIT '>''=' DIGIT ')' BRACKETFIRST statement BRACKETLAST  {
	                                int i;
	                                printf("WHILE loop is started");
	                                for(i=$3 ; i>=$6; i--) 
	                                {
	                                	printf("\nloop: %d expression value: %d\n", i,$9);}
	                                printf("WHILE loop finished\n");								
				               whilenumber++;
				               }
	| FORLOOP '(' DIGIT ',' DIGIT ',' DIGIT ')' BRACKETFIRST statement BRACKETLAST {
	                                int i;
	                                printf("FOR loop is started");
	                                for(i=$3 ; i<$5 ; i=i+$7 ) 
	                                {printf("\n i value: %d expression value : %d\n", i,$10);}
	                                printf("\n FOR loop is ended \n");

				               fornumber++;
				               }
	| FACTO '(' DIGIT ')' ';' {
		printf("\nFACTO Function is called\n");
		int i;
		int f=1;
		for(i=1;i<=$3;i++)
		{
			f=f*i;
		}
		printf("FACTORIAL of %d is : %d\n",$3,f);
		printf("\nfacto function is finished\n");

		functionnumber++;

		}

	| CHECKODDEVEN '(' DIGIT ')' ';' {
		printf("OddEven Function is called\n");

		if($3 %2 ==0){
			printf("Number : %d is Even\n",$3);
		}
		else{
			printf("Number is :%d is Odd\n",$3);
		}
		printf("\n oddeven function is finished \n");
		functionnumber++;
		}
	| POWERFUNC'(' DIGIT ',' DIGIT ')' ';' {
		printf("POWER Function is called\n");
		int p=1;
		int f,s;
		f = $3;
		s = $5;
		p=pow(f,s);
		printf("Value is :%d\n",p);
		$$ = p;
		printf("\n Power function is finished \n");
		functionnumber++;
		}
	| MATCH '(' DIGIT ')' BRACKETFIRST MATCHOPTION BRACKETLAST {
		printf("\nSWITCH CASE Declaration\n");
		printf("\nFinally Choose Case number :-> %d\n",$3);
		printf("\n.........................................\n");
		switchnumber++;
	}
     
	
	| OUTPUT '(' VARCHAR ')' ';' {
		
			int i;
			i = 0;
			char ss[]="";	
			int val = $3;
			while(val/26)
			{
				ss[i] = 'a'-1+(val%26);
				val /= 26;
				i++;
			}
			if(val)
			ss[i] = 'a'-1+val;

			char *yy = ss;
			yy[strlen(yy)-1] = 0;
			yy[strlen(yy)-1] = 0;
			yy[strlen(yy)-1] = 0;
			printf("\nThe string is : %s\n",yy);
			printf("\n.........................................\n");

		}

	| OUTPUT '(' expression ')' ';' {printf("\nPrint Expression %d\n",$3);
		printnumber++;
		$$=$3;
		printf("\n.........................................\n");
	}
	|
	VARIABLE '+''+'';'{
		printf("\nIncrement operation\n");
		sym[$1]++;
		$$ = sym[$1];
		printf("\n After increment the value is %d\n",sym[$1]);
	}
	|
	VARIABLE '-''-'';'{
		printf("\nDecrement operation\n");
		sym[$1]--;
		$$ = sym[$1];
		printf("\n After decrement the value is %d\n",sym[$1]);
	}
	;

declaration : TYPE ID1   {printf("\nvariable declaration\n");
		printf("\n.........................................\n");}
            ;


TYPE : INTEGER   {printf("interger declaration\n");}
     | NONINTEGER  {printf("float declaration\n");}
     | LETTER   {printf("char declaration\n");}
     ;



ID1 : ID1 ',' VARIABLE  
    |VARIABLE  
    ;
MATCHOPTION: OPTIONGRAMMAR
 			|OPTIONGRAMMAR ORIGINALGRAMMAR
 			;

 OPTIONGRAMMAR: /*empty*/
 			| OPTIONGRAMMAR OPTIONNUMBER
 			;

 OPTIONNUMBER: OPTION DIGIT ':' expression ';' {printf("Case No : %d & expression value :%d \n",$2,$4);}
 			;
 ORIGINALGRAMMAR: ORIGINAL ':' expression ';' {
 				printf("\nDefault case & expression value : %d",$3);
 			}
 		;

expression: DIGIT					{ printf("\nNumber :  %d\n",$1 ); $$ = $1;  }

	| VARIABLE						{ $$ = sym[$1]; }
	
	| expression '+' expression	{printf("\nAddition :%d+%d = %d \n",$1,$3,$1+$3 );  $$ = $1 + $3;}

	| expression '-' expression	{printf("\nSubtraction :%d - %d = %d \n ",$1,$3,$1-$3); $$ = $1 - $3; }

	| expression '*' expression	{printf("\nMultiplication :%d * %d = %d \n ",$1,$3,$1*$3); $$ = $1 * $3; }

	| expression '/' expression	{ if($3){
				     					printf("\nDivision :%d / %d = %d \n ",$1,$3,$1/$3);
				     					$$ = $1 / $3;
				     					
				  					}
				  					else{
										$$ = 0;
										printf("\ndivision by zero\n\t");
				  					} 	
				    			}
	| expression '%' expression	{ if($3){
				     					printf("\nMod :%d %% %d %d \n",$1,$3,$1 % $3);
				     					$$ = $1 % $3;
				     					
				  					}
				  					else{
										$$ = 0;
										printf("\nMOD by zero\n");
				  					} 	
				    			}
	| expression '^' expression	{printf("\nPower  :%d ^ %d = %d \n",$1,$3,$1 ^ $3);  $$ = pow($1 , $3);}
	
	| expression '<' expression	{printf("\nLess Than :%d < %d = %d\n",$1,$3,$1 < $3); $$ = $1 < $3 ; }
	
	| expression '>' expression	{printf("\nGreater than :%d > %d = %d\n ",$1,$3,$1 > $3); $$ = $1 > $3; }

	| SIN expression 			{printf("\nValue of Sin(%d) is : %lf\n",$2,sin($2*3.1416/180)); $$=sin($2*3.1416/180);}

    | COS expression 			{printf("\nValue of Cos(%d) is : %lf\n",$2,cos($2*3.1416/180)); $$=cos($2*3.1416/180);}

    | TAN expression 			{printf("Value of Tan(%d) is %lf\n",$2,tan($2*3.1416/180)); $$=tan($2*3.1416/180);}
   

	| '(' expression ')'		{	 $$ = $2; };





	
	

