/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_MEM.C
 Purpose: HTML Parser. Memory handling routines
	  Initialize and close down the parser
 Written by: Oleg V. Erjomin
 Comments: 6.12.97      Add Error Handler
******************************************************************************/

#include "html.h"

#ifndef __PROLOG__
#include <string.h>
#endif

#include "html_tab.h"		/* for yylval	*/

#include "html_mem.h"
#include "../common/list.h"

/*
 * Context stack and current list stack made as array s
 */
#define STACK_MAX_DEEP	256
static unsigned long html_CntxStack [STACK_MAX_DEEP];	/* The context stack  	*/
static void *html_ListStack [STACK_MAX_DEEP];		/* The list stack	*/
static unsigned long *html_CntxSP;			/* Next place */
static void **html_ListSP;				/* Next place */

void InitHTMLParser (void)
{
	int i;

	for (i=0;i<STACK_MAX_DEEP;i++) html_CntxStack [i] = CNTX_ERROR;
	html_CntxSP = html_CntxStack;
	html_ListSP = html_ListStack;
}

void CloseHTMLParser (void)
{
}

int yywrap (void) {return 1;}

/*
 *  Extracts the literal value - the string embraced in
 *  apostrophs or quotes
 */
int ExtractLiteral (char c)
{
	char	*p1,*p2;

	p1 = &(yytext[1]);
	p2 = strchr(p1,c);
	if (p2==NULL ||p2==p1)
	{
		yylval.lit[0]='\0';
		return 0;
	}
	strncpy (yylval.lit,p1,p2-p1);
	yylval.lit[p2-p1]='\0';
	return 1;
}
	
/*
 *  Context and List stacks handlihg
 */

void html_push_Context (unsigned long Cntx)
{
	if (html_CntxSP>=&html_CntxStack[STACK_MAX_DEEP])
		yyerror ("context stack is too deep");
	*html_CntxSP++=Cntx;
}

unsigned long html_pop_Context (void)
{
	if (html_CntxSP==html_CntxStack)
		yyerror ("context stack underflow");
	return *--html_CntxSP;
}

unsigned long html_cur_Context (void)
{
	if (html_CntxSP==html_CntxStack) return CNTX_ERROR;
	return *(html_CntxSP-1);
}

void html_push_List (void *List)
{
	if (html_ListSP>=&html_ListStack[STACK_MAX_DEEP])
		yyerror ("list stack is too deep");
	*html_ListSP++=List;
}

void *html_pop_List (void)
{
	if (html_ListSP==html_ListStack)
		yyerror ("list stack underflow");
	return *--html_ListSP;
}

void *html_cur_List (void)
{
	if (html_ListSP==html_ListStack) return NULL;
	return *(html_ListSP-1);
}

/*
 *  Error handler. This routine is called from Lex/Yacc generated
 *  scanner/parser. It calls the user defined predicate "yy_parser_error"
 */

void yyerror (char *ErrMsg)
{
	yy_parser_error (ErrMsg,yylineno,yycharno);
}


