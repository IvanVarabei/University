/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_KEY.C
 Purpose: HTML Parser. Keyword handling
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "html.h"
#include "html_key.h"
#include "../common/misc.h"

#ifndef __PROLOG__
#include <string.h>         /* C RTL headers */
#include <ctype.h>
#include <stdlib.h>
#endif

/*
 *  Local functions
 */
int html_key_Compare (void *arg1,void *arg2);
/*
**
**  HTML Keyword Table
**
*/
static KEY_TABLE_RECORD html_Keyword_Table [] =
{
  {"A",		tag_A},		/* Hypertext link (anchor)	*/
  {"ABBR",	tag_ABBR},	/* Abbreviation			*/
  {"ACRONYM",	tag_ACRONYM},	/* Acronym			*/
  {"ADDRESS",	tag_ADDRESS},	/* Address element		*/
  {"APPLET",	tag_APPLET},	/* Java applet                  */
  {"AREA",	tag_AREA},	/* Image map area               */
  {"B",		tag_B},		/* Boldface			*/
  {"BASE",	tag_BASE},	/* URL itself to be recorded	*/
  {"BIG",	tag_BIG}, 	/* Big print			*/
  {"BLOCKQUOTE",tag_BQ},	/* Blockquote			*/
  {"BODY",	tag_BODY},	/* Document body		*/
  {"BQ",	tag_BQ},	/* Blockquote			*/
  {"BR",	tag_BR},	/* Line break			*/
  {"CAPTION",	tag_CAPTION},	/* Table or figure caption	*/
  {"CITE",	tag_CITE},	/* Citation			*/
  {"CODE",	tag_CODE},	/* Example of code		*/
  {"COL",	tag_COL},	/* Column atributies		*/
  {"COLGROUP",	tag_COLGROUP},	/* Column group			*/
  {"DD",	tag_DD},	/* Term definition (in DL)	*/
  {"DEL",	tag_DEL},	/* Deleted text			*/
  {"DFN",	tag_DFN},	/* Defining instance of a term	*/
  {"DIV",	tag_DIV},	/* Container (ie. chapter etc.)	*/
  {"DL",	tag_DL},	/* Definition list		*/
  {"DT",	tag_DT},	/* Term name (in DL)		*/
  {"EM",	tag_EM},	/* Emphasys (italic)		*/
  {"FN",	tag_FN},	/* Footnotes			*/
  {"FONT",	tag_FONT},	/* Set native font		*/
  {"FORM",	tag_FORM},	/* Fill-out form		*/
  {"FRAME",	tag_FRAME},	/* Frame                        */
  {"FRAMESET",	tag_FRAMESET},	/* Frame set                    */
  {"H1",	tag_H1},	/* Heading level 1		*/
  {"H2",	tag_H2},	/*               2		*/
  {"H3",	tag_H3},	/*               3		*/
  {"H4",	tag_H4},	/*               4		*/
  {"H5",	tag_H5},        /*               5		*/
  {"H6",	tag_H6},	/*               6		*/
  {"HEAD",	tag_HEAD},	/* Document header		*/
  {"HR",	tag_HR},	/* Horizontal rule		*/
  {"HTML",	tag_HTML},	/* HTML Document		*/
  {"I",		tag_I},		/* Italic			*/
  {"IMG",	tag_IMG},	/* In-line graphic		*/
  {"INPUT",	tag_INPUT},	/* Input field of a form	*/
  {"INS",	tag_INS},	/* Inserted text		*/
  {"ISINDEX",	tag_ISINDEX},	/* This is an index document	*/
  {"KBD",	tag_KBD}, 	/* Typed (keyboarded) text	*/
  {"LH",	tag_LH},	/* List header			*/
  {"LI",	tag_LI},	/* List item			*/
  {"LINK",	tag_LINK},	/* Relationship to other object	*/
  {"LISTING",	tag_CODE},	/* Obsolete example		*/
  {"MAP",	tag_MAP},	/* Image map                    */
  {"META",	tag_META},	/* Meta-information		*/
  {"NOFRAMES",	tag_NOFRAMES},	/* Mark the non-frame area      */
  {"NOTE",	tag_NOTE},	/* Admonishments		*/
  {"OL",	tag_OL},	/* Ordered list			*/
  {"OPTION",	tag_OPTION},	/* An option of SELECT element	*/
  {"P",		tag_P},		/* Paragraph			*/
  {"PARAM",     tag_PARAM},     /* Applet's parameter           */
  {"PLAINTEXT",	tag_PRE},	/* Obsolete plaintext		*/
  {"PRE",	tag_PRE},	/* Preformatted text		*/
  {"Q",		tag_Q},		/* Inline quotation		*/
  {"ROW",	tag_ROW},	/* Array row			*/
  {"S",		tag_S},		/* Strike through		*/
  {"SAMP",	tag_SAMP},	/* Sequence of literal chars	*/
  {"SCRIPT",	tag_SCRIPT},	/* Scripting language frasgment */
  {"SELECT",	tag_SELECT},	/* Menu in a form		*/
  {"SMALL",	tag_SMALL},	/* Small print			*/
  {"SPAN",	tag_SPAN},	/* Span of elements             */
  {"STRONG",	tag_STRONG},	/* Emphasys (bold)		*/
  {"STYLE",	tag_STYLE},	/* Specifies style notation	*/
  {"SUB",	tag_SUB},	/* Subscript			*/
  {"SUP",	tag_SUP},	/* Superscript			*/
  {"TAB",	tag_TAB},	/* Horizontal Tabs		*/
  {"TABLE",	tag_TABLE},	/* Table			*/
  {"TBODY",	tag_TBODY},	/* Table body			*/
  {"TD",	tag_TD},	/* Table cell			*/
  {"TEXTAREA",	tag_TEXTAREA},	/* Text area of a form		*/
  {"TFOOT",	tag_TFOOT},	/* Table footer			*/
  {"TH",	tag_TH},	/* Table cell			*/
  {"THEAD",	tag_THEAD},	/* Table header			*/
  {"TITLE",	tag_TITLE},	/* Document title		*/
  {"TR",	tag_TR},	/* Table row			*/
  {"TT",	tag_TT},	/* Teletype			*/
  {"U",		tag_U},		/* Underlined			*/
  {"UL",	tag_UL},	/* Unordered list		*/
  {"VAR",	tag_VAR},	/* Variable name		*/
  {"XMP",	tag_CODE},	/* Obsolete example		*/
  {0,0}
};

int GetTagValue (char *Name)
{
	KEY_TABLE_RECORD *pKeyRecord;

	pKeyRecord = searchb(Name,
		html_Keyword_Table,
		sizeof(html_Keyword_Table)/sizeof(KEY_TABLE_RECORD),
		sizeof(KEY_TABLE_RECORD),
		html_key_Compare);

	if (pKeyRecord != NULL)
	{
		return pKeyRecord->KeyVal;
	}
	else return tag_Common;
}

/*
 *  Comparision function for qsort and bsearch
 *  (Common for RTF & HTML)
 */
int html_key_Compare (void *arg1,void *arg2)
{
	KEY_TABLE_RECORD *rec2 = (KEY_TABLE_RECORD*)arg2;

	return strcmp ( arg1, rec2->KeyStr );
}


