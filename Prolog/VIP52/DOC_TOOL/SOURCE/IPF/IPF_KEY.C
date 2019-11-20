/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_KEY.C
 Purpose: IPF Parser. Keyword handling
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "ipf.h"
#include "ipf_key.h"
#include "../common/misc.h"

#ifndef __PROLOG__
#include <string.h>         /* C RTL headers */
#include <ctype.h>
#include <stdlib.h>
#endif

/*
 *  Local functions
 */
int ipf_key_Compare (void *arg1,void *arg2);
/*
**
**  IPF Keyword Table
**
*/
static KEY_TABLE_RECORD ipf_Keyword_Table [] =
{
  {"acviewport",tag_ACVIEWPORT},/* Application Controlled Window */
  {"artlink",	tag_ARTLINK},	/* Art Link                      */
  {"artwork",	tag_ARTWORK},	/* Artwork                       */
  {"c",		tag_CELL},	/* Table Cell                    */
  {"caution",	tag_CAUTION},	/* Caution                       */
  {"cgraphic",	tag_CGRAPHIC},	/* Charatcter Graqphic           */
  {"color",	tag_COLOR},	/* Color                         */
  {"ctrl",	tag_CTRL},	/* Control Area                  */
  {"ctrldef",	tag_CTRLDEF}, 	/* Control Area Definition       */
  {"dd",	tag_DD},	/* Definition Description        */
  {"ddf",	tag_DDF},	/* Dinamic Data Formatting       */
  {"ddhd",	tag_DDHD},	/* Definition Description Head   */
  {"dl",	tag_DL},	/* Definition List               */
  {"docprof",	tag_DOCPROF},	/* Document Profile              */  
  {"dt",	tag_DT},	/* Definition Term               */
  {"dthd",	tag_DTHD},	/* Definition Term  Heading      */
  {"fig",	tag_FIG},	/* Figure                        */
  {"figcap",	tag_FIGCAP},	/* Figure Caption                */
  {"fn",	tag_FN},	/* Footnote                      */
  {"font",	tag_FONT},	/* Font                          */
  {"h1",	tag_H1},	/* Heading level 1               */
  {"h2",	tag_H2},	/*               2               */
  {"h3",	tag_H3},	/*               3               */
  {"h4",	tag_H4},	/*               4               */
  {"h5",	tag_H5},        /*               5               */
  {"h6",	tag_H6},	/*               6               */
  {"hide",	tag_HIDE},	/* Hide                          */
  {"hp1",	tag_HP1},	/* Highlight phrase (italic)     */
  {"hp2",	tag_HP2},	/*  (bold)                       */
  {"hp3",	tag_HP3},	/*  (bold+italic)                */
  {"hp4",	tag_HP4},	/*  (blue)                       */
  {"hp5",	tag_HP5},	/*  (underline)                  */
  {"hp6",	tag_HP6},	/*  (italic+underline)           */
  {"hp7",	tag_HP7},	/*  (bold+underline)             */
  {"hp8",	tag_HP8},	/*  (red)                        */
  {"hp9",	tag_HP9},	/*  (magenta)                    */
  {"i1",	tag_I1},	/* Index level 1                 */
  {"i2",	tag_I2},	/* Index level 2                 */
  {"icmd",	tag_ICMD}, 	/* Index Command                 */
  {"isyn",	tag_ISYN},	/* Index Synonym                 */
  {"li",	tag_LI},	/* List Item                     */
  {"lines",	tag_LINES},	/* Lines                         */
  {"link",	tag_LINK},	/* Link                          */
  {"lm",	tag_LM},	/* Left Margin                   */
  {"lp",	tag_LP},	/* List Part                     */
  {"note",	tag_NOTE},	/* Admonishments                 */
  {"nt",	tag_NT},	/* Admonishments                 */
  {"ol",	tag_OL},	/* Ordered List                  */
  {"p",		tag_P},		/* Paragraph                     */
  {"parml",     tag_PARML},     /* Parameter List                */
  {"pbutton",	tag_PBUTTON},	/* Push Button                   */
  {"pd",	tag_PD},	/* Parameter Description         */
  {"pt",	tag_PT},	/* Parameter Term                */
  {"rm",     	tag_RM},	/* Right Margin                  */
  {"row",	tag_ROW},	/* Table Row                     */
  {"sl",	tag_SL},	/* Simple List                   */
  {"table",	tag_TABLE},	/* Table                         */
  {"title",	tag_TITLE},	/* Document Title                */
  {"ul",	tag_UL},	/* Unordered List                */
  {"userdoc",	tag_USERDOC},	/* User Document                 */
  {"warning",	tag_WARNING},	/* Warning                       */
  {"xmp",	tag_XMP},	/* Example                       */
  {0,0}
};

int ipf_GetTagValue (char *Name)
{
	KEY_TABLE_RECORD *pKeyRecord;

	pKeyRecord = searchb(Name,
		ipf_Keyword_Table,
		sizeof(ipf_Keyword_Table)/sizeof(KEY_TABLE_RECORD),
		sizeof(KEY_TABLE_RECORD),
		ipf_key_Compare);

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
int ipf_key_Compare (void *arg1,void *arg2)
{
	KEY_TABLE_RECORD *rec2 = (KEY_TABLE_RECORD*)arg2;

	return strcmp ( arg1, rec2->KeyStr );
}
