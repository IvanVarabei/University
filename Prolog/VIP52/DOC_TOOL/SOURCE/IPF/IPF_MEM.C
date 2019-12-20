/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_MEM.C
 Purpose: IPF Parser. Memory handling routines
	  Initialize and close down the parser
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/


#include "ipf.h"

#ifndef __PROLOG__
#include <string.h>
#endif

#include "ipf_tab.h"		/* for yylval	*/

#include "ipf_mem.h"
#include "../common/list.h"

/*
 * Context stack and current list stack made as array s
 */
#define STACK_MAX_DEEP	256
static unsigned long ipf_CntxStack [STACK_MAX_DEEP];	/* The context stack  	*/
static void *ipf_ListStack [STACK_MAX_DEEP];		/* The list stack	*/
static unsigned long *ipf_CntxSP;			/* Next place */
static void **ipf_ListSP;				/* Next place */

void InitIPFParser (void)
{
	int i;

	for (i=0;i<STACK_MAX_DEEP;i++) ipf_CntxStack [i] = CNTX_ERROR;
	ipf_CntxSP = ipf_CntxStack;
	ipf_ListSP = ipf_ListStack;
}

void CloseIPFParser (void)
{
}

int yywrap (void) {return 1;}

/*
 *  Extracts the literal value - the string embraced in
 *  apostrophs or quotes
 */
int ipf_ExtractLiteral (char c)
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

void ipf_push_Context (unsigned long Cntx)
{
	if (ipf_CntxSP>=&ipf_CntxStack[STACK_MAX_DEEP])
		yyerror ("context stack is too deep");
	*ipf_CntxSP++=Cntx;
}

unsigned long ipf_pop_Context (void)
{
	if (ipf_CntxSP==ipf_CntxStack)
		yyerror ("context stack underflow");
	return *--ipf_CntxSP;
}

unsigned long ipf_cur_Context (void)
{
	if (ipf_CntxSP==ipf_CntxStack) return CNTX_ERROR;
	return *(ipf_CntxSP-1);
}

void ipf_push_List (void *List)
{
	if (ipf_ListSP>=&ipf_ListStack[STACK_MAX_DEEP])
		yyerror ("list stack is too deep");
	*ipf_ListSP++=List;
}

void *ipf_pop_List (void)
{
	if (ipf_ListSP==ipf_ListStack)
		yyerror ("list stack underflow");
	return *--ipf_ListSP;
}

void *ipf_cur_List (void)
{
	if (ipf_ListSP==ipf_ListStack) return NULL;
	return *(ipf_ListSP-1);
}

/*
 *  Error handler. This routine is called from Lex/Yacc generated
 *  scanner/parser. It calls the user defined predicate "yy_parser_error"
 */

void yyerror (char *ErrMsg)
{
	yy_parser_error (ErrMsg,yylineno,yycharno);
}

