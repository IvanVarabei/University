/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_KEY.C
 Purpose: RTF Parser. Keyword Table and some routines to lookup keywords
	  and break tokens into key and value.
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "rtf.h"
#include "rtf_key.h"
#include "rtf_font.h"
#include "../common/misc.h"

#ifndef __PROLOG__
#include <string.h>         /* C RTL headers */
#include <ctype.h>
#include <stdlib.h>
#endif

/*
 *  Local functions
 */

int rtf_key_Compare (void *arg1,void *arg2);
/*
 *
 *  RTF Keyword Table
 */

//extern void CONV_s_i_io (const char *S, int *I);

static KEY_TABLE_RECORD rtf_Keyword_Table [] =
{
    {"'",               tag_APOSTROF},      /* Specifies the character by value                  */
    {"*",               tag_ASTERISK},      /* Specifies an annotation                           */
    {"ansi",            tag_ANSI},          /* Specifies the ANSI character set                  */
    {"b",               tag_BOLD},          /* Starts bold text                                  */
    {"bin",             tag_BIN},           /* Specifies binary picture data                     */
    {"blue",            tag_BLUE},          /* Specifies the Blue intensity                      */
    {"bmc",             tag_BMC},           /* Displays a bitmap or metafile in text             */
    {"bml",     	tag_BML},           /* Displays a bitmap or metafile at the left margin  */
    {"bmr",             tag_BMR},           /* Displays a bitmap or metafile at the right margin */
    {"box",             tag_BOX},           /* Draws a box                                       */
    {"brdrb",           tag_BRDRB},         /* Draws a bottom border                             */
    {"brdrbar",         tag_BRDRBAR},       /* Draws a vertical bar                              */
    {"brdrdb",          tag_BRDRDB},        /* Sets double-lined borders                         */
    {"brdrdot",         tag_BRDRDOT},       /* Sets dotted border                                */
    {"brdrl",           tag_BRDRL},         /* Draws a left border                               */
    {"brdrr",           tag_BRDRR},         /* Draws a right border                              */
    {"brdrs",           tag_BRDRS},         /* Sets standard borders                             */
    {"brdrsh",          tag_BRDRSH},        /* Draws shadow border                               */
    {"brdrt",           tag_BRDRT},         /* Draws a top border                                */
    {"brdrth",          tag_BRDRTH},        /* Sets thick borders                                */
    {"cell",            tag_CELL},          /* Marks end of table cell                           */
    {"cellx",           tag_CELLX},         /* Sets the position of a cell's right edge          */
    {"cf",              tag_CF},            /* Sets the foreground color                         */
    {"clbrdrb",         tag_CLBRDRB},       /* Draws a bottom border                             */
    {"clbrdrl",         tag_CLBRDRL},       /* Draws a left border                               */
    {"clbrdrr",         tag_CLBRDRR},       /* Draws a right border                              */
    {"clbrdrt",         tag_CLBRDRT},       /* Draws a top border                                */
    {"colortbl",        tag_COLORTBL},      /* Creates the color table                           */
    {"deff",            tag_DEFF},          /* Sets default font                                 */
    {"emc",             tag_EMC},           /* Allows DLL to paint window in text                */
    {"eml",             tag_EML},           /* Allows DLL to paint window at left margin         */
    {"emr",             tag_EMR},           /* Allows DLL to paint window at right margin        */
    {"f",               tag_FONT},          /* Sets the font                                     */
    {"fcharset",        tag_FCHARSET},      /* Define characters set                             */
    {"fdecor",          tag_FFDECOR},       /* Decorative fonts                                  */
    {"fi",              tag_FI},            /* Sets the first-line indent                        */
    {"fldrslt",         tag_FLDRSLT},       /* Result of a field                                 */
    {"fmodern",         tag_FFMODERN},      /* Fixed-pitch serif and sans serif fonts            */
    {"fnil",            tag_FFNIL},         /* Unknown or default fonts (default)                */
    {"fonttbl",         tag_FONTTBL},       /* Creates the font table                            */
    {"footnote",        tag_FOOTNOTE},      /* Defines topic-specific information                */
    {"fprq",            tag_FPRQ},          /*    I don't know                                   */
    {"froman",          tag_FFROMAN},       /* Roman, proportionally spaced serif fonts          */
    {"fs",              tag_FONTSIZE},      /* Sets the font size                                */
    {"fscript",         tag_FFSCRIPT},      /* Script fonts                                      */
    {"fscrpt",          tag_FFSCRIPT},      /* Script fonts                                      */
    {"fswiss",          tag_FFSWISS},       /* Swiss, proportionally spaced sans serif fonts     */
    {"ftech",           tag_FFTECH},        /* Technical, symbol, and mathematical fonts         */
    {"green",           tag_GREEN},         /* Specifies Green intensity                         */
    {"highlight",	tag_HIGHLIGHT},     /* Sets the background color                         */
    {"i",               tag_ITALIC},        /* Starts italic text                                */
    {"info",            tag_INFO},          /* Strats info tables                                */
    {"intbl",           tag_INTBL},         /* Marks paragraph as in table                       */
    {"keep",            tag_KEEP},          /* Makes text non-wrapping                           */
    {"keepn",           tag_KEEPN},         /* Creates a non-scrolling region                    */
    {"ldblquote",	tag_LDBLQUOTE},     /* Left double quote                                 */
    {"li",              tag_LI},            /* Sets the left indent                              */
    {"line",            tag_LINE},          /* Breaks the current line                           */
    {"mac",             tag_MAC},           /* Sets the Apple MacIntosh character set            */
    {"page",            tag_PAGEBREAK},     /* Ends current topic                                */
    {"par",             tag_PAR},           /* Marks the end of a paragraph                      */
    {"pard",            tag_PARD},          /* Restores default paragraph properties             */
    {"pc",              tag_PC},            /* Sets the PC character set                         */
    {"pich",            tag_PICH},          /* Specifies the picture height                      */
    {"pichgoal",        tag_PICHGOAL},      /* Specifies the desired picture height              */
    {"picscalex",       tag_PICSCALEX},     /* Specifies the horizontal scaling value            */
    {"picscaley",       tag_PICSCALEY},     /* Specifies the vertical scaling value              */
    {"pict",            tag_PICT},          /* Creates a picture                                 */
    {"picw",            tag_PICW},          /* Specifies the picture width                       */
    {"picwgoal",        tag_PICWGOAL},      /* Specifies the desired picture width               */
    {"plain",           tag_PLAINTEXT},     /* Restores default character properties             */
    {"qc",              tag_QC},            /* Centers text                                      */
    {"qj",              tag_QJ},            /* Justyfies text                                    */
    {"ql",              tag_QL},            /* Aligns text left                                  */
    {"qr",              tag_QR},            /* Aligns text right                                 */
    {"rdblquote",	tag_RDBLQUOTE},     /* Right double quote                                */
    {"red",             tag_RED},           /* Specifies Red intensity                           */
    {"ri",              tag_RI},            /* Sets the right indent                             */
    {"row",             tag_ROW},           /* Marks end of a table row                          */
    {"rtf",             tag_RTF},           /* Specifies the RTF version                         */
    {"sa",              tag_SA},            /* Sets the spacing after a paragraph                */
    {"sb",              tag_SB},            /* Sets space before                                 */
    {"scaps",           tag_SCAPS},         /* Starts small capitals                             */
    {"sect",            tag_SECT},          /* Marks the end of a section and paragraph          */
    {"sl",              tag_SL},            /* Sets the spacing between lines                    */
    {"strike",          tag_STRIKE},        /* Creates a hotspot                                 */
    {"stylesheet",      tag_STYLESHEET},    /* Starts the style sheet                            */
    {"tab",             tag_TAB},           /* Inserts a tab character                           */
    {"tb",              tag_TB},            /* Tabs bar                                          */
    {"tldot",		tag_TLDOT},	    /* Tabs leaded by dots                               */
    {"tlhyph",		tag_TLHYPH},	    /* Tabs leaded by hyphens                            */
    {"tlul",            tag_TLUL},          /* Tabs leaded by underscores                        */
    {"tqdec",		tag_TQDEC},	    /* Tabs and aligns text by decimal point             */
    {"tqc",             tag_TQC},           /* Tabs and aligns text center                       */
    {"tqr",             tag_TQR},           /* Tabs and aligns text right                        */
    {"trbrdrb",         tag_TRBRDRB},       /* Draws a bottom border                             */
    {"trbrdrl",         tag_TRBRDRL},       /* Draws a left border                               */
    {"trbrdrr",         tag_TRBRDRR},       /* Draws a right border                              */
    {"trbrdrt",         tag_TRBRDRT},       /* Draws a top border                                */
    {"trgaph",          tag_TRGAPH},        /* Sets space between text columns in a table        */
    {"trleft",          tag_TRLEFT},        /* Sets left margin for the first cell               */
    {"trowd",           tag_TROWD},         /* Sets table defaults                               */
    {"trqc",            tag_TRQC},          /* Sets relative column widths                       */
    {"trql",            tag_TRQL},          /* Left-aligns table row                             */
    {"tx",              tag_TX},            /* Tabs position                                     */
    {"ul",              tag_UL},            /* Creates a link to a pop-up topic                  */
    {"uldb",            tag_ULDB},          /* Creates a hot spot                                */
    {"v",               tag_V},             /* Creates a link to a topic                         */
    {"vern",            tag_VERN},          /* Specifies version number                          */
    {"version",         tag_VERSION},       /* Specifies version number                          */
    {"wbitmap",         tag_WBITMAP},       /* Specifies a Windows bitmap                        */
    {"wbmbitspixel",    tag_WBMBITSPIXEL},  /* Specifies the number of bits per pixel            */
    {"wbmplanes",       tag_WBMPLANES},     /* Specifies the number of planes                    */
    {"wbmwidthbytes",   tag_WBMWIDTHBYTES}, /* Specifies the bitmap width in bytes               */
    {"wmetafile",       tag_WMETAFILE},     /* Specifies a Windows metafile                      */
    {0,0}
};

/*
 *  select_KeyVal - breaks an RTF token into
 *                  key and value
 *
 *  return          1 on success
 *                  0 if keyword not found in a table
 *
 */

static char KeyStr[20];
static char ValStr[20];

BOOL select_KeyVal (char *TokenStr,int *Key, int *Val)
{
	int  i = 1;        /* skip \\ */
        int  j;
	KEY_TABLE_RECORD *pKeyRecord;

	while (TokenStr[i])
	{
		if ((TokenStr[i]>='a'&& TokenStr[i]<='z')||
		    TokenStr[i]=='*' ||
		    TokenStr[i]=='\'')
		{
			KeyStr [i-1] = TokenStr [i];
			i++;
		}
		else break;
	}
	KeyStr [i-1] = '\0';
	j = 0;
	while (TokenStr[i])
	{
		ValStr[j]=TokenStr[i];
		i++;
		j++;
	}
	ValStr[j] = 0;
	
	pKeyRecord = searchb(KeyStr,
		rtf_Keyword_Table,
		sizeof(rtf_Keyword_Table)/sizeof(KEY_TABLE_RECORD),
		sizeof(KEY_TABLE_RECORD),
		rtf_key_Compare);

	if (pKeyRecord != NULL)
	{
		*Key = pKeyRecord->KeyVal;
		if (strcmp(ValStr,"")==0) *Val=(-1);
		else CONV_s_i_io (ValStr,Val);
		return TRUE;
	}
	return FALSE;
}

/*
 *  Comparision function for qsort and bsearch
 */
int rtf_key_Compare (void *arg1,void *arg2)
{
	KEY_TABLE_RECORD *rec2 = (KEY_TABLE_RECORD*)arg2;

	return strcmp ( arg1, rec2->KeyStr );
}


