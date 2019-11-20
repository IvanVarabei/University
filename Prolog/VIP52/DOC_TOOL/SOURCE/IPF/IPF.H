/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF.H
 Purpose: IPF Parser. Common declarations
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __IPF_H__
#define __IPF_H__

#include "../config.h"

#ifdef __TURBOC__
 #include "ipf/y_pdcdef.h"
#else
 #include "y_pdcdef.h"
#endif

#include "../common/misc.h"

#ifndef __PROLOG__
#include <stdio.h>
extern FILE *yyin;
extern FILE *yyout;
#endif

#include "../docstr.h"	  /* Document Structure	              	   */
			  /* Genreated with PRO2C from docstr.dom  */
#ifdef __IBMC__
#define UNDESCORES
#pragma map (ipf_term_0,"_ipf_term_0")
#pragma map (ipf_term_1,"_ipf_term_1")
#pragma map (ipf_term_2,"_ipf_term_2")
#pragma map (ipf_term_3,"_ipf_term_3")
#pragma map (unify_ipf_doc,"_unify_ipf_doc")
#pragma map (make_ipf_doc,"_make_ipf_doc")
#pragma map (gen_ipf_doc,"_gen_ipf_doc")
#pragma map (yy_parser_error,"_yy_parser_error")
#pragma map (yyerror,"_yyerror")
#endif

#ifndef NULL
#define NULL 0
#endif

#ifndef BOOL
#define BOOL char
#define FALSE 0
#define TRUE  1
#endif

#ifndef ULONG
#define ULONG unsigned long
#endif

/*
 *  Nested expressions not allowed in IPF
 *  So we can extremely shrink the yylval stack
 *  to avoid DOS allocation problems
 */

#ifndef MLINEAR
  #define YYMAXDEPTH	60
#endif

/*
 *  Redefinition for Lex-Yacc names to avoid naming conflicts
 */

#define yyparse ipf_yyparse
#define yylex ipf_yylex
#define yyerror ipf_yyerror
#define yylval ipf_yylval
#define yychar ipf_yychar
#define yydebug ipf_yydebug
#define yynerrs ipf_yynerrs
#define yyin ipf_yyin
#define yyleng ipf_yyleng
#define yylex ipf_yylex
#define yyout ipf_yyout
#define yyrestart ipf_yyrestart
#define yytext ipf_yytext
#define yylineno ipf_yylineno
#define yycharno ipf_yycharno
#define yywrap ipf_yywrap

#define yylhs ipf_yylhs
#define yylen ipf_yylen
#define yydefred ipf_yydefred
#define yydgoto ipf_yydgoto
#define yysindex ipf_yysindex
#define yyrindex ipf_yyrindex
#define yygindex ipf_yygindex
#define yytable ipf_yytable
#define yycheck ipf_yycheck

#define yyssp ipf_yyssp
#define yyvsp ipf_yyvsp
#define yyval ipf_yyval
#define yyss  ipf_yyss
#define yyvs  ipf_yyvs
#define yyerrflag ipf_yyerrflag

#define yy_input_string ipf_yy_input_string

extern long YYIN_Len;
extern char yytext[];
extern int yylineno;
extern long yycharno;
/*
 *  Parser context
 */
#define CNTX_ERROR		(ULONG)0x00000000
#define CNTX_BODY		(ULONG)0x00000001
#define CNTX_TEXT		(ULONG)0x00000002
#define CNTX_HEADING		(ULONG)0x00000004
#define CNTX_PARA		(ULONG)0x00000010
#define CNTX_BLOCK		(ULONG)0x00000020
#define CNTX_LIST		(ULONG)0x00000040
#define CNTX_LH			(ULONG)0x00000080
#define CNTX_LI			(ULONG)0x00000100
#define CNTX_TABLE		(ULONG)0x00000200
#define CNTX_TABLE_ROW		(ULONG)0x00000400
#define CNTX_TABLE_CELL		(ULONG)0x00000800
#define CNTX_ARTLINK		(ULONG)0x00040000
#define CNTX_STRING		(ULONG)0x00100000
#define CNTX_HEAD_TITLE		(ULONG)0x80000000
#define CNTX_ANYWHERE		(ULONG)0xFFFFFFFF

#define CHECK_CONTEXT(Mask)	( ((Mask) & ipf_cur_Context()) ? 1 : 0 )

/*
 *  As for HTML
 */
#define TAGLEN		2100
#define LITLEN		1024
#define ATTSPLEN	2100
#define MAXATT		64
#define NAMELEN		72

typedef char NAME[NAMELEN];
typedef char LITERAL[LITLEN];

typedef struct tagTAG
{
        NAME    tag_Name;               /* Tag name                    */
        int     tag_AttCount;           /* Tag att list counter        */
        ATT     tag_AttArray[MAXATT];   /* attributies list            */
} TAG, *PTAG;

extern TAG      ipf_cur_Tag;            /* Current parsed tag          */
extern DOC      *p_ipf_Doc;             /* Term to be parsed in        */

extern BOOL     ipf_NLENDEDTAG;         /* Some IPF tags ended with NL */
extern BOOL     ipf_CGRAPHIC;           /* CGRAPHIC mode               */
/*
 *  Lex/Yacc interface
 */
int yylex (void);
int yyparse (void);
int yywrap(void);
int yyline(void);

int yyoutput();
void yyerror (char*);

void yy_parser_error (char*,int,long);

int ipf_ExtractLiteral (char);
void ipf_AddLineBreak (void);
void ipf_IncludeFile (char*);
void ipf_EndTag (char*);


#endif
