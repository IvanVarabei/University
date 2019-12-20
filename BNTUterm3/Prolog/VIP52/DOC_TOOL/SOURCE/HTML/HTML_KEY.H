/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_KEY.H
 Purpose: HTML Parser. Keyword handling
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __HTML_KEY_H__
#define __HTML_KEY_H__

typedef enum {
	tag_Unbound = 0,
	tag_Common,
	tag_A,
	tag_ABBR,
	tag_ACRONYM,
	tag_ADDRESS,
	tag_APPLET,
	tag_AREA,
	tag_B,
	tag_BASE,
	tag_BIG,
	tag_BLOCKQUOTE,
	tag_BODY,
	tag_BQ,
	tag_BR,
	tag_CAPTION,
	tag_CITE,
	tag_CODE,
	tag_COL,
	tag_COLGROUP,
	tag_DD,
	tag_DEL,
	tag_DFN,
	tag_DIV,
	tag_DL,
	tag_DT,
	tag_EM,
	tag_FN,
	tag_FONT,
	tag_FORM,
	tag_FRAME,
	tag_FRAMESET,
	tag_H1,
	tag_H2,
	tag_H3,
	tag_H4,
	tag_H5,
	tag_H6,
	tag_HEAD,
	tag_HR,
	tag_HTML,
	tag_I,
	tag_INS,
	tag_IMG,
	tag_INPUT,
	tag_ISINDEX,
	tag_ITEM,
	tag_KBD,
	tag_LH,
	tag_LI,
	tag_LINK,
        tag_LISTING,
	tag_MAP,
	tag_META,
	tag_NOFRAMES,
	tag_NOTE,
	tag_OL,
	tag_OPTION,
	tag_P,
        tag_PARAM,
        tag_PLAINTEXT,
	tag_PRE,
	tag_Q,
	tag_ROW,
	tag_S,
	tag_SAMP,
	tag_SCRIPT,
	tag_SELECT,
	tag_SMALL,
	tag_SPAN,
	tag_STRONG,
	tag_STYLE,
	tag_SUB,
	tag_SUP,
	tag_TAB,
	tag_TABLE,
	tag_TBODY,
	tag_TD,
	tag_TEXTAREA,
	tag_TFOOT,
	tag_TH,
	tag_THEAD,
	tag_TITLE,
	tag_TR,
	tag_TT,
	tag_U,
	tag_UL,
	tag_VAR,
	tag_XMP
} HTML_TAG_FNO;

typedef struct tagKEY_TABLE_RECORD
{
	char			KeyStr [20];
    HTML_TAG_FNO    KeyVal;
} KEY_TABLE_RECORD;

int GetTagValue (char *Name);

#endif
