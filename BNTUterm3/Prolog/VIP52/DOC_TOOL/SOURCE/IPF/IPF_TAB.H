/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: PFC_TAB.H
 Purpose: 
 Written by: 
 Comments:
******************************************************************************/
#define IPF_START_TAG_BEGIN 257
#define IPF_END_TAG_BEGIN 258
#define IPF_TAG_END 259
#define IPF_TAG_TERMINATE 260
#define IPF_STRING 261
#define IPF_ERROR 262
#define IPF_LITERAL 263
#define IPF_ATT 264
#define IPF_NUMERIC 265
#define EQ 266
typedef union  {
		int	num;
		LITERAL	lit;
		NAME	name;
	} YYSTYPE;
extern YYSTYPE yylval;
