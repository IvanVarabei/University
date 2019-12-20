/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_KEY.H
 Purpose: IPF Parser. Keyword handling
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __IPF_KEY_H__
#define __IPF_KEY_H__

typedef enum {
	tag_Unbound = 0,
	tag_Common,
	tag_ACVIEWPORT,
	tag_ARTLINK,
	tag_ARTWORK,
	tag_CELL,
	tag_CAUTION,
	tag_CGRAPHIC,
	tag_COLOR,
	tag_CTRL,
	tag_CTRLDEF,
	tag_DD,
	tag_DDF,
	tag_DDHD,
	tag_DL,
	tag_DOCPROF,
	tag_DT,
	tag_DTHD,
	tag_FIG,
	tag_FIGCAP,
	tag_FN,
	tag_FONT,
	tag_H1,
	tag_H2,
	tag_H3,
	tag_H4,
	tag_H5,
	tag_H6,
	tag_HIDE,
	tag_HP1,
	tag_HP2,
	tag_HP3,
	tag_HP4,
	tag_HP5,
	tag_HP6,
	tag_HP7,
	tag_HP8,
	tag_HP9,
	tag_I1,
	tag_I2,
	tag_ICMD,
	tag_ISYN,
	tag_LI,
	tag_LINES,
	tag_LINK,
	tag_LM,
	tag_LP,
	tag_NOTE,
        tag_NT,
	tag_OL,
	tag_P,
	tag_PARML,
	tag_PBUTTON,
	tag_PD,
	tag_PT,
	tag_RM,
	tag_ROW,
	tag_SL,
	tag_TABLE,
	tag_TITLE,
	tag_UL,
	tag_USERDOC,
	tag_WARNING,
	tag_XMP
} IPF_TAG_FNO;

typedef struct tagKEY_TABLE_RECORD
{
	char 	  	KeyStr [20];
	IPF_TAG_FNO	KeyVal;
} KEY_TABLE_RECORD;

int ipf_GetTagValue (char *Name);

#endif
