/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_SYM.C
 Purpose: IPF Parser.  Insert symbol by value
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "ipf.h"

#include "ipf_sym.h"
#include "ipf_tag.h"
#include "../common/misc.h"

/*
 *  Local functions
 */
int ipf_sym_Compare (void *arg1,void *arg2);

/*
 *  IPF Symbol Table
 */                  

SYM_TABLE_RECORD ipf_Symbol_Table [] =
{
 {"&AElig.",     (char)146     }, // AE ligature
 {"&Ae.",        (char)142     }, // A umlaut
 {"&Alpha.",     (char)224     }, // Alpha
 {"&Ao.",        (char)143     }, // A overcircle
 {"&BOX.",       (char)219     }, // solid box
 {"&BOXBOT.",    (char)220     }, // solid box bottom half
 {"&Beta.",      (char)225     }, // Beta
 {"&Cc.",        (char)128     }, // C cedilla
 {"&Ea.",        (char)144     }, // E acute
 {"&Lsterling.", (char)156     }, // pound sterling
 {"&Nt.",        (char)165     }, // N tidle
 {"&Oe.",        (char)153     }, // O umlaut
 {"&Ue.",        (char)154     }, // U umlaut
 {"&aa.",        (char)160     }, // a acute
 {"&ac.",        (char)131     }, // a circumflex
 {"&ae.",        (char)132     }, // a umlaut
 {"&aelig.",     (char)145     }, // ae ligature
 {"&ag.",        (char)133     }, // a grave
 {"&amp.",       (char)38      }, // Ampersand
 {"&and.",       (char)94      }, // and
 {"&angstrom.",  (char)143     }, // angstrom
 {"&ao.",        (char)134     }, // a overcircle
 {"&apos.",      (char)39      }, // Apostrophe
 {"&asterisk.",  (char)42      }, // Asterisk
 {"&atsign.",    (char)64      }, // At sign
 {"&aus.",       (char)166     }, // underscored a
 {"&box12.",     (char)177     }, // shaded box 1/2 dots
 {"&box14.",     (char)176     }, // shaded box 1/4 dots
 {"&box34.",     (char)178     }, // shaded box 3/4 dots
 {"&bsl.",       (char)92      }, // Back slash
 {"&bslash.",    (char)92      }, // Back slash
 {"&bx0022.",    (char)187     }, // ASCII code 187
 {"&bx0202.",    (char)205     }, // ASCII code 205
 {"&bx0220.",    (char)201     }, // ASCII code 201
 {"&bx0222.",    (char)203     }, // ASCII code 203
 {"&bx2002.",    (char)188     }, // ASCII code 188
 {"&bx2020.",    (char)186     }, // ASCII code 186
 {"&bx2022.",    (char)185     }, // ASCII code 185
 {"&bx2200.",    (char)200     }, // ASCII code 200
 {"&bx2202.",    (char)202     }, // ASCII code 202
 {"&bx2220.",    (char)204     }, // ASCII code 204
 {"&bx2222.",    (char)206     }, // ASCII code 206
 {"&bxas.",      (char)193     }, // box ascender
 {"&bxbj.",      (char)193     }, // box ascender (bottom junction)
 {"&bxcj.",      (char)197     }, // box cross junction
 {"&bxcr.",      (char)197     }, // box cross
 {"&bxde.",      (char)194     }, // box descender 
 {"&bxh.",       (char)196     }, // box horizontal
 {"&bxll.",      (char)192     }, // box lower-left
 {"&bxlr.",      (char)217     }, // box lower-right
 {"&bxri.",      (char)180     }, // box right intersection
 {"&bxrj.",      (char)180     }, // box right junction
 {"&bxtj.",      (char)194     }, // box descender (top junction)
 {"&bxul.",      (char)218     }, // box upper-left
 {"&bxur.",      (char)191     }, // box upper-right
 {"&bxv.",       (char)179     }, // box vertical
 {"&caret.",     (char)94      }, // Caret symbol
 {"&cc.",        (char)135     }, // c cedilla
 {"&cdq.",       (char)34      }, // Close double quote
 {"&cdqf.",      (char)175     }, // Close French double quote
 {"&colon.",     (char)58      }, // Colon
 {"&comma.",     (char)44      }, // Comma
 {"&csq.",       (char)39      }, // Close single quote
 {"&darrow.",    (char)25      }, // Down arrow
 {"&dash.",      (char)45      }, // Dash
 {"&deg.",       (char)248     }, // degree
 {"&degree.",    (char)248     }, // degree
 {"&divide.",    (char)246     }, // divide
 {"&dollar.",    (char)36      }, // Dollar sign
 {"&dot.",       (char)250     }, // dot
 {"&ea.",        (char)130     }, // e acute
 {"&ec.",        (char)136     }, // e circumflex
 {"&ee.",        (char)137     }, // e umlaut
 {"&eg.",        (char)138     }, // e grave
 {"&emdash.",    (char)45      }, // Em dash
 {"&endash.",    (char)45      }, // En dash
 {"&eq.",        (char)61      }, // Equal sign
 {"&eqsym.",     (char)61      }, // Equal sign
 {"&equals.",    (char)61      }, // Equal sign
 {"&fnof.",      (char)159     }, // function of
 {"&frac12.",    (char)171     }, // one half
 {"&frac14.",    (char)172     }, // one fourth
 {"&gesym.",     (char)242     }, // Greater or equal
 {"&gt.",        (char)62      }, // Greater than
 {"&gtsym.",     (char)62      }, // Greater than
 {"&house.",     (char)127     }, // House
 {"&hyphen.",    (char)45      }, // Hyphen
 {"&ia.",        (char)161     }, // i acute
 {"&ic.",        (char)140     }, // i circumflex
 {"&ie.",        (char)139     }, // i umlaut
 {"&ig.",        (char)141     }, // i grave
 {"&inve.",      (char)173     }, // inverted exclamation mark
 {"&invq.",      (char)168     }, // inverted question mark
 {"&larrow.",    (char)17      }, // Left arrow
 {"&lbrace.",    (char)123     }, // Left brace
 {"&lbracket.",  (char)91      }, // Left bracket
 {"&lbrc.",      (char)123     }, // Left brace
 {"&lbrk.",      (char)91      }, // Left bracket
 {"&lesym.",     (char)243     }, // Less or equal
 {"&lnot.",      (char)170     }, // logical not
 {"&lpar.",      (char)40      }, // Left parenthesis
 {"&lparen.",    (char)40      }, // Left parenthesis
 {"&lt.",        (char)60      }, // Less than
 {"&ltsym.",     (char)60      }, // Less than
 {"&mdash.",     (char)45      }, // M dash
 {"&minus.",     (char)45      }, // Minus sign
 {"&mu.",        (char)230     }, // Mu
 {"&ndash.",     (char)45      }, // N dash
 {"&notsym.",    (char)170     }, // not symbol
 {"&nt.",        (char)164     }, // n tidle
 {"&numsign.",   (char)35      }, // Number sign
 {"&oa.",        (char)162     }, // o acute
 {"&oc.",        (char)147     }, // o circumflex
 {"&odq.",       (char)34      }, // Open double quote
 {"&odqf.",      (char)174     }, // Open French double quote
 {"&oe.",        (char)148     }, // o umlaut
 {"&og.",        (char)149     }, // o grave
 {"&osq.",       (char)96      }, // Open single quote
 {"&ous.",       (char)167     }, // underscored o
 {"&per.",       (char)46      }, // Period
 {"&percent.",   (char)37      }, // Percent
 {"&plus.",      (char)43      }, // Plus sign
 {"&plusmin.",   (char)241     }, // plusminus
 {"&pm.",        (char)241     }, // plusminus
 {"&rbl.",       (char)32      }, // Required blank
 {"&rbrace.",    (char)125     }, // Right brace
 {"&rbracket.",  (char)93      }, // Right bracket
 {"&rbrc.",      (char)125     }, // Right brace
 {"&rbrk.",      (char)93      }, // Right bracket
 {"&rpar.",      (char)41      }, // Right parenthesis
 {"&rparen.",    (char)41      }, // Right parenthesis
 {"&semi.",      (char)59      }, // Semicolon
 {"&slash.",     (char)47      }, // Slash
 {"&slr.",       (char)47      }, // Slash
 {"&splitvbar.", (char)124     }, // Split vertical bar
 {"&sqbul.",     (char)254     }, // square bullet
 {"&sup2.",      (char)253     }, // superscript 2
 {"&tilde.",     (char)126     }, // Tilde
 {"&ua.",        (char)163     }, // u acute
 {"&uc.",        (char)150     }, // u circumflex
 {"&ue.",        (char)129     }, // u umlaut
 {"&ug.",        (char)151     }, // u grave
 {"&us.",        (char)95      }, // Underscore
 {"&xclam.",     (char)33      }, // Exclamation point
 {"&xclm.",      (char)33      }, // Exclamation point
 {"&ye.",        (char)152     }, // y umlaut
 {0,0}
};

void ipf_SymbolByValue (char *SymCode)
{
	SYM_TABLE_RECORD *pSymRecord;

	pSymRecord = searchb(SymCode,
		ipf_Symbol_Table,
		sizeof(ipf_Symbol_Table)/sizeof(SYM_TABLE_RECORD),
		sizeof(SYM_TABLE_RECORD),
		ipf_sym_Compare);

        if (pSymRecord != NULL)
	{
		char Sym[2];
        	Sym[0] = pSymRecord->SymVal;
        	Sym[1] = '\0';
                ipf_AddPlainText (Sym);
	}
	else ipf_AddPlainText (SymCode);
}

/*
 *  Comparision function for qsort and bsearch
 */
int ipf_sym_Compare (void *arg1,void *arg2)
{
	SYM_TABLE_RECORD *rec2 = (SYM_TABLE_RECORD*)arg2;

	return strcmp ( arg1, rec2->SymStr );
}
