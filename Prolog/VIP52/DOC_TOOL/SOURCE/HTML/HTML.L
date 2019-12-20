%{
#include "html.h"
#include "html_tab.h"
//#ifdef YYLMAX
//#undef YYLMAX
//#endif
//#define YYLMAX 2100
#define YY_PROLOG_FROM_STRING 1
int prolog_Nest=0;
int PrevContext = 0;
long charno=0;
static char DecBuff[10];
%}
D       [dD]
O       [oO]
C       [cC]
T       [tT]
Y       [yY]
P       [pP]
E       [eE]
S       [sS]
R       [rR]
I       [iI]
WS      [ \t\n\r]
%start  INTAG PROLOG NEST COMMENT
%array
%option yylineno
%%
<INITIAL>\<!        {
			PrevContext = INITIAL;
			if (IsScript==0) BEGIN COMMENT;
			else return HTML_STRING;
		};
<INTAG>\<!          {
			PrevContext = INTAG;
			BEGIN COMMENT;
		};
<COMMENT>[^\>]*   ;
<COMMENT>\>     {
			BEGIN PrevContext;
		};
<INITIAL>\<!{D}{O}{C}{T}{Y}{P}{E}       {
			BEGIN PROLOG;
		};
<INITIAL>\</[a-zA-Z]     {
			if(IsScript)
				return HTML_STRING;
			else
			{
				BEGIN INTAG;
				return HTML_START_TAG_BEGIN;
			}
		};
<INITIAL>\<\/   {
			{
				BEGIN INTAG;
				return HTML_END_TAG_BEGIN;
			}
		};
<INITIAL>\<[^a-zA-Z!]+   {
			return HTML_STRING;
		};

<INTAG>\>       {
			BEGIN INITIAL;
			return HTML_TAG_END;
		};
<PROLOG>\>      {
			BEGIN INITIAL;
		};
<INITIAL>[\t\n ]+ {
	/*
         *  in <PRE> text goes as is
         */
	if (IsPreformatted||IsScript) return HTML_STRING;
	else return HTML_WHITESPACE;
		};
<INTAG>[\t\n\r ]        ;
<INTAG>=        {
			return EQ;
		};
<INTAG>"'"[^']*"'"      {
			ExtractLiteral('\'');
			return (HTML_LITERAL);
		};
<INTAG>\"[^\"]*\"       {
			ExtractLiteral ('"');
			return (HTML_LITERAL);
		};
<INTAG>[0-9]+           {
			CONV_s_i_io (yytext,&(html_yylval.num));
			return HTML_NUMERIC;
		};
<INTAG>[a-zA-Z0-9:_\/\+\-\.\%\x80-\xFF]+     {
			strcpy (html_yylval.name,yytext);
			return HTML_ATT;
		};
<INITIAL>"&#"[a-zA-z0-9]+";"	{
			unsigned C;
			int ii;
			for(ii=2;(ii<6)&&(yytext[ii]!=';');ii++)
			{
				DecBuff[ii-2]=yytext[ii];
			}
			DecBuff[++ii]='\0';
			CONV_s_i_io (DecBuff,&C);
			sprintf (yytext,"%c",C);
			return HTML_STRING;
			};
<INITIAL>[^\<\t\n\r]+   {
			return HTML_STRING;
		};
<PROLOG>\[      {
			if (prolog_Nest==0) BEGIN NEST;
			prolog_Nest++;
		};
<NEST>\[        {
			prolog_Nest++;
		};
<NEST>\]        {
			if(prolog_Nest==1) BEGIN PROLOG;
			prolog_Nest--;
		};
<PROLOG>[^\>\[\]\t\n\r]+        {
			strcpy(html_yylval.lit,yytext);
			return HTML_PROLOG;
		};
<NEST>[^\]\t\n\r]+      {
			strcpy(html_yylval.lit,yytext);
			return HTML_PROLOG;
		};

.               /* all other patterns are ignored */
%%
