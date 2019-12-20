/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: ATTS.C
 Purpose: 
 Written by: 
 Comments:
******************************************************************************/

#ifndef __RTF_KEY_H__
#define __RTF_KEY_H__

/*
 * RTF keyword definition
 */

typedef enum tagKEY_VAL {
    tag_RTF_Unbound = 0,
    tag_APOSTROF,
    tag_ASTERISK,
    tag_ANSI,
    tag_BOLD,
    tag_BIN,
    tag_BLUE,
    tag_BMC,
    tag_BML,
    tag_BMR,
    tag_BOX,
    tag_BRDRB,
    tag_BRDRBAR,
    tag_BRDRDB,
    tag_BRDRDOT,
    tag_BRDRL,
    tag_BRDRR,
    tag_BRDRS,
    tag_BRDRSH,
    tag_BRDRT,
    tag_BRDRTH,
    tag_CELL,
    tag_CELLX,
    tag_CF,
    tag_CLBRDRB,
    tag_CLBRDRL,
    tag_CLBRDRR,
    tag_CLBRDRT,
    tag_COLORTBL,
    tag_DEFF,
    tag_EMC,
    tag_EML,
    tag_EMR,
    tag_FONT,
    tag_FCHARSET,
    tag_FI,
    tag_FLDRSLT,
    tag_FONTTBL,
    tag_FOOTNOTE,
    tag_FPRQ,
    tag_FONTSIZE,
    tag_FFNIL,
    tag_FFROMAN,
    tag_FFSWISS,
    tag_FFMODERN,
    tag_FFSCRIPT,
    tag_FFDECOR,
    tag_FFTECH,
    tag_GREEN,
    tag_HIGHLIGHT,
    tag_ITALIC,
    tag_INFO,
    tag_INTBL,
    tag_KEEP,
    tag_KEEPN,
    tag_LDBLQUOTE,
    tag_LI,
    tag_LINE,
    tag_MAC,
    tag_PAGEBREAK,
    tag_PAR,
    tag_PARD,
    tag_PC,
    tag_PICH,
    tag_PICHGOAL,
    tag_PICSCALEX,
    tag_PICSCALEY,
    tag_PICT,
    tag_PICW,
    tag_PICWGOAL,
    tag_PLAINTEXT,
    tag_QC,
    tag_QJ,
    tag_QL,
    tag_QR,
    tag_RDBLQUOTE,
    tag_RED,
    tag_RI,
    tag_ROW,
    tag_RTF,
    tag_SA,
    tag_SB,
    tag_SCAPS,
    tag_SECT,
    tag_SL,
    tag_STRIKE,
    tag_STYLESHEET,
    tag_TAB,
    tag_TB,
    tag_TLDOT,
    tag_TLHYPH,
    tag_TLUL,
    tag_TQC,
    tag_TQR,
    tag_TQDEC,
    tag_TRBRDRB,
    tag_TRBRDRL,
    tag_TRBRDRR,
    tag_TRBRDRT,
    tag_TRGAPH,
    tag_TRLEFT,
    tag_TROWD,
    tag_TRQC,
    tag_TRQL,
    tag_TX,
    tag_UL,
    tag_ULDB,
    tag_V,
    tag_VERN,
    tag_VERSION,
    tag_WBITMAP,
    tag_WBMBITSPIXEL,
    tag_WBMPLANES,
    tag_WBMWIDTHBYTES,
    tag_WMETAFILE
} KEY_VALUE;

typedef struct tagKEY_TABLE_RECORD
{
	char		KeyStr [20];
        KEY_VALUE       KeyVal;
} KEY_TABLE_RECORD;


BOOL select_KeyVal (char *TokenStr,int *Key, int *Val);

#endif
