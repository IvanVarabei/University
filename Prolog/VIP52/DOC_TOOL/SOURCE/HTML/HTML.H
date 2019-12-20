/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML.H
 Purpose: HTML Parser. Common declarations
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __HTML_H__
#define __HTML_H__

#include "../config.h"

#ifdef __TURBOC__
 #include "html/y_pdcdef.h"
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
#pragma map (html_term_0,"_html_term_0")
#pragma map (html_term_1,"_html_term_1")
#pragma map (html_term_2,"_html_term_2")
#pragma map (html_term_3,"_html_term_3")
#pragma map (yy_parser_error,"_yy_parser_error")
#pragma map (unify_html_doc,"_unify_html_doc")
#pragma map (make_html_doc,"_make_html_doc")
#pragma map (gen_html_doc,"_gen_html_doc")
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
 *  Nested expressions not allowed in HTML
 *  So we can extremely shrink the yylval stack
 *  to avoid DOS allocation problems
 */

#ifndef MLINEAR
  #define YYMAXDEPTH	60
#endif

/*
 *  Redefinition for Lex-Yacc names to avoid naming conflicts
 */

#define yyparse html_yyparse
#define yylex html_yylex
//#define yyerror html_yyerror
#define yylval html_yylval
#define yychar html_yychar
#define yydebug html_yydebug
#define yynerrs html_yynerrs
#define yyin html_yyin
#define yyleng html_yyleng
#define yylex html_yylex
#define yyout html_yyout
#define yyrestart html_yyrestart
#define yytext html_yytext
#define yylineno html_yylineno
#define yycharno html_yycharno
#define yywrap html_yywrap

#define yylhs html_yylhs
#define yylen html_yylen
#define yydefred html_yydefred
#define yydgoto html_yydgoto
#define yysindex html_yysindex
#define yyrindex html_yyrindex
#define yygindex html_yygindex
#define yytable html_yytable
#define yycheck html_yycheck

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
#define CNTX_DIV		(ULONG)0x00000008
#define CNTX_PARA		(ULONG)0x00000010
#define CNTX_BLOCK		(ULONG)0x00000020
#define CNTX_LIST		(ULONG)0x00000040
#define CNTX_LH			(ULONG)0x00000080
#define CNTX_LI			(ULONG)0x00000100
#define CNTX_TABLE		(ULONG)0x00000200
#define CNTX_TABLE_COLGROUP	(ULONG)0x00000400
#define CNTX_TABLE_HEAD		(ULONG)0x00000800
#define CNTX_TABLE_FOOT		(ULONG)0x00001000
#define CNTX_TABLE_BODY		(ULONG)0x00002000
#define CNTX_TABLE_ROW		(ULONG)0x00004000
#define CNTX_TABLE_CELL		(ULONG)0x00008000
#define CNTX_CAPTION		(ULONG)0x00010000
#define CNTX_FORM		(ULONG)0x00020000
#define CNTX_FORM_LBOX 		(ULONG)0x00040000
#define CNTX_FORM_TEXT		(ULONG)0x00080000
#define CNTX_FORM_OPTION	(ULONG)0x00100000
#define CNTX_SCRIPT             (ULONG)0x00200000
#define CNTX_APPLET             (ULONG)0x00400000
#define CNTX_IMGMAP		(ULONG)0x00800000
#define CNTX_FRAMESET		(ULONG)0x01000000
#define CNTX_HEAD_STYLE		(ULONG)0x40000000
#define CNTX_HEAD_TITLE		(ULONG)0x80000000
#define CNTX_ANYWHERE		(ULONG)0xFFFFFFFF

#define CHECK_CONTEXT(Mask)	( ((Mask) & html_cur_Context()) ? 1 : 0 )

/*
 *  Constants and types from SGML HTML DTD
 *  SGML ISO 8879:1986
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
	NAME	tag_Name;		/* Tag name		*/
	int	tag_AttCount;		/* Tag att list counter */
	ATT	tag_AttArray[MAXATT];	/* attributies list	*/
} TAG, *PTAG;

extern TAG	cur_Tag;		/* Current parsed tag	*/
extern DOC	*pDoc;			/* Term to be parsed in */
extern int	IsPreformatted;		/* Preformatted text	*/
extern int	IsScript;		/* Script text		*/

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

int ExtractLiteral (char);


#endif



