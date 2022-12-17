
%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <math.h>
	#include "1807104.tab.h"

	int get_str_val(char *str)
	{
		int val,pp;
		val = 0;
		pp = 1;
		int i;	
		for(i = 0; i < strlen(str); i++)
		{
			val += (str[i]-'a'+1)*pp;
			pp *= 26;
		}
		return val;
	}

%}

VARIABLE [_][a-zA-Z]
VARCHAR [a-zA-Z]*
DIGIT [0-9]
HEADER	"import ".*

%%

"HASHINC" 		{ printf("#include "); }
"SUPREME"		{ printf("\nMain Function Started\n"); return SUPREME; }
"{" 		    { return BRACKETFIRST; }
"}"  		    { return BRACKETLAST; }

"FLOW"		    { return FLOW; }	
"KILL"          { return KILL; }
"OPTION"        { return OPTION; }
"MATCH"         { return MATCH; }
"ORIGINAL"      { return ORIGINAL; }
"WHILELOOP"     { return WHILELOOP; }
"INTEGER"	    { return INTEGER; }
"NOTINTEGER"	{ return NONINTEGER; }
"LETTER"	    { return LETTER; }
"SUCHTHAT"      { return SUCHTHAT; }
"FORLOOP"   	{ return FORLOOP; }	
"WHETHER"		{ return WHETHER; }
"ELIF"			{ return ELIF; }
"OTHERWISE"		{ return OTHERWISE; }
"OUTPUT"		{ return OUTPUT; }
"TAKE"			{ printf("scanf "); }
"POWERFUNC"		{ return POWERFUNC; }
"SIN"		    { return SIN; }
"COS"           { return COS; }
"TAN"           { return TAN; }

"POWERFUNC"		{ return POWERFUNC; }
"FACTO"		    { return FACTO; }
"CHECKODDEVEN"	{ return CHECKODDEVEN; }

{HEADER}  		     { printf("\nHeader file:\n"); ECHO; printf("\n"); }
{DIGIT}+	         { yylval = atoi(yytext); return DIGIT; }
{VARIABLE}	         { ECHO; printf("\n"); yylval = *yytext - 'a'; return VARIABLE; }
{VARCHAR}            { yylval = get_str_val(yytext); return VARCHAR; }
[-+/*<>=,():;%^]     { yylval = yytext[0];	return *yytext;	}
[ ]*	    		 {}
[\n]*				 {}
[\t]*				 {}

"//"                 {printf("SINGLE_LINE_COMMENT\n");}
"/*"[.]*"*/"         {printf("MULTIPLE_LINE_COMMENT\n"); }

.					 { printf("\nUnknown Syntax : %s\n",yytext); }

%%


int yywrap() {
    return 1;
}

void yyerror(char const *s) { 
	fprintf(stderr, "%s\n", s);
}

int main()
{
	yyin = freopen("input.txt","r",stdin);
	yyout = freopen("output.txt","w",stdout);
	yyparse();
	return 0;
}

