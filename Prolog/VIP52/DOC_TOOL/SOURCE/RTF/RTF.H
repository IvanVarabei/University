/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF.H
 Purpose: RTF Parser. Common declarations
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __RTF_H__
#define __RTF_H__

#include "../config.h"
#include "y_pdcdef.h"
#include "../docstr.h"
#include "../common/misc.h"

#ifndef __PROLOG__
#include <stdio.h>
extern FILE *yyin;
extern FILE *yyout;
#endif

#ifndef NULL
#define NULL 0
#endif

#ifndef BOOL
#define BOOL char
#define FALSE 0
#define TRUE  1
#endif

#ifdef __IBMC__
#define UNDESCORES
#pragma map(rtfpage_term_0,"_rtfpage_term_0")
#pragma map(rtf_default_cb,"_rtf_default_cb")
#pragma map(rtf_yyerror,"_rtf_yyerror")
#pragma map(yy_parser_error,"_yy_parser_error")
#endif

/*
 *  Redefinition for Lex-Yacc names to avoid naming conflicts
 */

#define yyparse rtf_yyparse
#define yylex rtf_yylex
#define yyerror rtf_yyerror
#define yylval rtf_yylval
#define yychar rtf_yychar
#define yydebug rtf_yydebug
#define yynerrs rtf_yynerrs
#define yyin rtf_yyin
#define yyleng rtf_yyleng
#define yylex rtf_yylex
#define yyout rtf_yyout
#define yyrestart rtf_yyrestart
#define yytext rtf_yytext
#define yylineno rtf_yylineno
#define yycharno rtf_yycharno
#define yywrap rtf_yywrap

#define yylhs rtf_yylhs
#define yylen rtf_yylen
#define yydefred rtf_yydefred
#define yydgoto rtf_yydgoto
#define yysindex rtf_yysindex
#define yyrindex rtf_yyrindex
#define yygindex rtf_yygindex
#define yytable rtf_yytable
#define yycheck rtf_yycheck

#define yyssp rtf_yyssp
#define yyvsp rtf_yyvsp
#define yyval rtf_yyval
#define yyss  rtf_yyss
#define yyvs  rtf_yyvs
#define yyerrflag rtf_yyerrflag

/*
 *  Parser context
 */
#define CNTX_ERROR     -1
#define CNTX_PLAIN      0
#define CNTX_FONTTBL	1
#define CNTX_FONTRECORD	2
#define CNTX_COLORTBL	3
#define CNTX_IGNORED    4
#define CNTX_FOOTNOTE	5
#define CNTX_FOOTNEST	6
#define CNTX_HOTSPOT	7
#define	CNTX_HYPERLINK	8
#define CNTX_TABLE	9

/*
 * Font Table Record
 */

#define LF_FACESIZE 	    21

#define FF_DONTCARE         0x00
#define FF_ROMAN            0x10
#define FF_SWISS            0x20
#define FF_MODERN           0x30
#define FF_SCRIPT           0x40
#define FF_DECORATIVE       0x50

typedef struct tagFONTTBL_RECORD
{
        int     ftbl_Num;
        int     ftbl_Charset;
	int 	ftbl_Prq;
        int     ftbl_Family;
	char    ftbl_FaceName[LF_FACESIZE];
} FONTTBL_RECORD;

typedef struct tagCOLORTBL_RECORD
{
	int R,G,B;
} COLORTBL_RECORD;

/*
 *  Paragraph description.
 *  All measures in twips. So the maximum
 *  value of all paragraphs measurements
 *  can be up to 22,75 inces
 *
 */

#define MAX_TABS                64
#define MAX_CELLS		64

#define TAB_ALIGN_LEFT          1
#define TAB_ALIGN_CENTER        2
#define TAB_ALIGN_RIGHT         3
#define TAB_ALIGN_DEC           4
#define TAB_ALIGN_VERT          5

#define TAB_FILL_NONE           1
#define TAB_FILL_DOTS           2
#define TAB_FILL_HYPH           3
#define TAB_FILL_UL             4

typedef struct tagTABSTOP
{
        int     Pos;
        int     Align;
        int     Fill;
} TABSTOP;


#define BULLETS_SQUARE          1
#define BULLETS_NUMBER          2

#define BORDER_TYPE_NONE	0x00
#define BORDER_TYPE_BOX		0x01
#define BORDER_TYPE_RIGHT	0x02
#define BORDER_TYPE_LEFT	0x04
#define BORDER_TYPE_TOP		0x10
#define BORDER_TYPE_BOTTOM	0x20

#define BORDER_STYLE_STD	1
#define BORDER_STYLE_THICK	2
#define BORDER_STYLE_DOUB	3
#define BORDER_STYLE_SHADE	4

#define PARA_ALIGN_LEFT		1
#define PARA_ALIGN_CENTER	2
#define PARA_ALIGN_RIGHT	3
#define PARA_ALIGN_JUSTIFY	4

#define HL_NONE			0x00
#define HL_BOLD         	0x01
#define HL_ITALIC		0x02
#define HL_UNDERLINE		0x04

typedef struct tagPARAGRAPH
{
        int     LeftIndent;		/* Indents: left         */
        int     RightIndent;            /*          right        */
        int     FirstLineIndent;        /*          "red line"   */
        int     SpaceBefore;            /* Spaces: before para   */
        int     SpaceAfter;             /*         after para    */
        int     SpaceBetween;           /*         between lines */
	BOOL    Wrap;			/* Wrap up paragraph     */
        BOOL    NonScrollRegion;	/* Non scrolling region  */
        int     BorderType;		/* Border type           */
        int     BorderStyle;		/* Border style          */
        int     Alignment;		/* Paragraph alignment   */
        TABSTOP Tabstops [MAX_TABS];	/* Tabstop list          */
} PARAGRAPH;

typedef struct tagCELL
{
        int	Pos;			/* Cell position         */
        int     BorderType;		/* Border type           */
        int     BorderStyle;		/* Border style          */
} CELLINF;

typedef struct tagTROW
{
        int	LeftIndent;		/* Row left indent       */
	int	Gaph;			/* Row gaph              */
        int     BorderType;		/* Border type           */
        int     BorderStyle;		/* Border style          */
        CELLINF	Cells [MAX_CELLS];	/* Cell list             */
} TROWINF;
/*
 *  Format Descriptor
 */
typedef struct tagFORMAT
{
	int	FontNum;	/* Font number          */
	int	FontSz;		/* Font size            */
	char	Effects;	/* Effects BOLD/ITALIC  */
	int	ForeColor;	/* Foreground color     */
	int	BackColor;	/* Background color     */
} FORMAT;

/*
 *  Page Descriptor
 */
typedef struct tagPAGEATTR
{
	char	Context[255];		/* Context string        */
	char	Title[255];		/* Topic title           */
	char	Keywords[255];		/* Associated keywords   */
	char	Macro[2048];		/* Topic macro           */
        char    BrowseSeq[255];         /* Browse sequence major */
} PAGEATTR;
/*
 *  Hypertext link descriptor
 */
#define LINK_NONE	0
#define LINK_JUMP	1
#define LINK_POPUP	2
#define LINK_MACRO	3

typedef struct tagLINKATTR
{
        FLOW_ELEMENT*   Hotspot;        /* Hotspot begins here   */
        char            LinkCntx[255];  /* Context to link to    */
        char            LinkType;       /* Jump/Popup            */
} LINKATTR;

typedef BOOL (*RTF_DOCPARSER_CALLBACK)(DOC*);
/*
 *  Global variables
 */

extern int stmt_nest;                   /* Statement nesting      */
extern char *ParaBuff;                  /* Paragraph text buffer  */
extern char *PageBuff;                  /* Page text buffer       */
extern char *FootBuff;			/* Footnote text buffer   */
extern FONTTBL_RECORD *FontTable;       /* Font Table             */
extern FONTTBL_RECORD tmp_FontRec;      /* Temporary font record  */
extern int FontTableIdx;                /* Font Table Index       */
extern COLORTBL_RECORD *ColorTable;     /* Color Table            */
extern COLORTBL_RECORD tmp_ColorRec;    /* Temporary color record */
extern int ColorTableIdx;               /* Color Table Index      */
extern PARAGRAPH cur_Para;              /* Current paragraph      */
extern PARAGRAPH prev_Para;             /* Previous paragraph     */
extern PAGEATTR cur_Page;		/* Current page attribs   */
extern FORMAT cur_Form;			/* Current Format         */
extern FORMAT prev_Form;		/* Previous Format        */
extern TROWINF cur_Trow;		/* Current Table Row      */
extern CELLINF cur_Cell;		/* Current Cell Pointer   */
extern int DefFont;			/* Default font           */
extern LINKATTR cur_Link;		/* Current Link attribs   */
extern TABSTOP cur_Tab;			/* Current Tabstop        */
extern BOOL need_Skip;			/* Need skip blanks       */

extern STACKMARK gs_Parser;		/* Parser global stack top*/

extern int yylineno;
extern long yycharno;
extern char yytext[];

int yylex (void);
int yyparse(void);
int yywrap(void);
int yyline(void);
int yylook(void);
int yyback(int *p, int m);

/*
 *  The following functions need to be defined
 *  in caller program (C or PROLOG)
 */

void yyerror (char*);
void yy_parser_error (char*, int, long);

#endif
