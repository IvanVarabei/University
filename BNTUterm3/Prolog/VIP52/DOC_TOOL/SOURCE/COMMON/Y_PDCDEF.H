/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: Y_PDCDEF.H
 Purpose: Macros to keep portability across C/Prolog under UNIX/DOS/WINDOWS
	  for the program written with lex/yacc
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

/*
 *  If we need to link with modules written in PDC Prolog
 *  then include Run Time Routines Declarations
 *  and redefine some of lex/yacc macros such as
 *  input(), output (), yywrap (), ECHO
 *
 *  You need to write in Prolog:
 *  char IO_GetC()  the same as char getc(FILE*)
 */
#include "pdcrunt.h"


/*
 *  Substitute PDC RunTime routines for C RTL ones
 */

int C_DECL STR_StrToInt(char *Val);

#define malloc MEM_AllocHeap
#define galloc MEM_AllocGStack
#define free MEM_ReleaseHeap
#define realloc MEM_ReAllocHeap
#define strcat STR_StrCat
#define strlen STR_StrLen
#define sprintf IO_SPrintf
#define strcmp STR_StrCmp
#define strcpy DOC_TOOL_StrCpy
#define strncpy DOC_TOOL_StrnCpy
#define memset DOC_TOOL_MemSet
#define memcpy DOC_TOOL_MemCpy
#define strchr DOC_TOOL_StrChr
#define isspace DOC_TOOL_IsSpace
#define islower DOC_TOOL_IsLower
#define isupper DOC_TOOL_IsUpper
//#define strtol(Val,Rem,Radix) STR_StrToInt(Val)
//#define atoi(Val) STR_StrToInt(Val)
#define strtol(Val,Rem,Radix) CONV_s_i_io(Val)
#define atoi(Val) CONV_s_i_io(Val)

#define printf IO_Writef

/*
 *  Redefinitions of Lex macros
 */
# ifdef output
# undef output
# define output(c) IO_WrCh(c)
# endif

# ifdef input
# undef input
# define input() (((yytchar=yysptr>yysbuf?U(*--yysptr):IO_GetC())==10?(yylineno++,yycharno++,yytchar):(yycharno++,yytchar))==EOF?0:yytchar)
# endif

# ifdef ECHO
# undef ECHO
# define ECHO IO_Writef("%s",yytext)
# endif

