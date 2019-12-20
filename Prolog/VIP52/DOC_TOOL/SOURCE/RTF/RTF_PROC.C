/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_PROC.C
 Purpose: RTF Parser. Token Processor
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "rtf.h"
#include "rtf_mem.h"
#include "rtf_key.h"
#include "rtf_form.h"
#include "rtf_foot.h"
#include "rtf_font.h"
#include "rtf_proc.h"
#include "rtf_pro.h"
#include "../common/list.h"

/*
 * Local functions
 */
BOOL do_Token (int,int,int);

/*
 * Select token key and value from input text
 * and put them to processor
 */
BOOL need_Skip;
extern LINKATTR cur_Link;

BOOL process_Token (char *Text)
{
	int Key, Val;
	int Context = rtf_cur_Context ();
	BOOL Ret=TRUE;

	if (Context == CNTX_IGNORED) return TRUE;
	
	if (select_KeyVal(Text,&Key,&Val))
	{
		Ret = do_Token (Key,Val,Context);
		need_Skip = TRUE;
	}
	return Ret;
}

/*
 *  MAIN TOKEN PROCESSOR
 */

extern void dump_Element ();

BOOL do_Token (int Key,int Val,int Context)
{

    BOOL  Ret = TRUE; /* Continue or not */

    if (Context==CNTX_PLAIN || Context==CNTX_HOTSPOT)
    {
    switch (Key)
    {
    	case tag_PAR:
		rtf_Paragraph ();
        	// copy_Para (&prev_Para,&cur_Para);
        	break;
	case tag_INTBL:
		rtf_StartTableRow ();
		break;
	case tag_CELL:
		rtf_EndTableCell ();
		break;
	case tag_ROW:
		rtf_EndTableRow ();
		break;
        case tag_PAGEBREAK:
		Ret = CallPageCallback ();
        	clear_Page ();
		NewPageFormat ();
        	break;
    	/*
    	 *  Font handling
    	 */
    	case tag_BOLD:
		if ( Val==-1 )
		{
			cur_Form.Effects |= HL_BOLD;
			rtf_SetBOOLMark (flow_element_b,TRUE);
		}
		else
		{
			cur_Form.Effects ^= HL_BOLD;
			rtf_SetBOOLMark (flow_element_b,FALSE);
		};
		break;
	case tag_ITALIC:
		if ( Val==-1 )
		{
			cur_Form.Effects |= HL_ITALIC;
			rtf_SetBOOLMark (flow_element_i,TRUE);
		}
		else
		{
			cur_Form.Effects ^= HL_ITALIC;
			rtf_SetBOOLMark (flow_element_i,FALSE);
		};
		break;
	case tag_PLAINTEXT:
		if (cur_Form.Effects & HL_BOLD) rtf_SetBOOLMark (flow_element_b,FALSE);
		if (cur_Form.Effects & HL_ITALIC) rtf_SetBOOLMark (flow_element_i,FALSE);
		plain_Text (&cur_Form);
		break;
	case tag_FONTSIZE:
		cur_Form.FontSz = Val;
        	break;
	case tag_CF:
		cur_Form.ForeColor = Val;
		break;
	case tag_HIGHLIGHT:
		cur_Form.BackColor = Val;
		break;
	/*
	 *  Quotation
	 */
	case tag_LDBLQUOTE: rtf_SetBOOLMark(flow_element_q,TRUE);break;
	case tag_RDBLQUOTE: rtf_SetBOOLMark(flow_element_q,FALSE);break;	
	/*
         * Paragraph related tokens
         */
	case tag_PARD:      default_Para (&cur_Para); break;
        case tag_FI:        cur_Para.FirstLineIndent  = Val; break;
        case tag_LI:        cur_Para.LeftIndent       = Val; break;
        case tag_RI:        cur_Para.RightIndent      = Val; break;
        case tag_SA:        cur_Para.SpaceAfter       = Val; break;
        case tag_SB:        cur_Para.SpaceBefore      = Val; break;
        case tag_SL:        cur_Para.SpaceBetween     = Val; break;
        case tag_BOX:       cur_Para.BorderType = BORDER_TYPE_BOX; break;
        case tag_BRDRB:     cur_Para.BorderType = BORDER_TYPE_BOTTOM; break;
        case tag_BRDRL:     cur_Para.BorderType = BORDER_TYPE_LEFT; break;
        case tag_BRDRR:     cur_Para.BorderType = BORDER_TYPE_RIGHT; break;
        case tag_BRDRT:     cur_Para.BorderType = BORDER_TYPE_TOP; break;
        case tag_BRDRDB:    cur_Para.BorderStyle = BORDER_STYLE_DOUB; break;
        case tag_BRDRS:     cur_Para.BorderStyle = BORDER_STYLE_STD; break;
        case tag_BRDRSH:    cur_Para.BorderStyle = BORDER_STYLE_SHADE; break;
	case tag_BRDRTH:    cur_Para.BorderStyle = BORDER_STYLE_THICK; break;
        case tag_QL:        cur_Para.Alignment = PARA_ALIGN_LEFT; break;
        case tag_QR:        cur_Para.Alignment = PARA_ALIGN_RIGHT; break;
        case tag_QC:        cur_Para.Alignment = PARA_ALIGN_CENTER; break;
	case tag_QJ:        cur_Para.Alignment = PARA_ALIGN_JUSTIFY; break;
        case tag_KEEP:	    cur_Para.Wrap = TRUE; break;
        case tag_KEEPN:	    cur_Para.NonScrollRegion = TRUE; break;
        /*
         *  Table cell's formatting
         */                 
        case tag_TROWD:   default_Trow (&cur_Trow); break;
        case tag_TRLEFT:  cur_Trow.LeftIndent = Val; break;
	case tag_TRGAPH:  cur_Trow.Gaph = Val; break;
        case tag_CELLX:   AddCellToTrow (Val); break;
        
        case tag_CLBRDRB: cur_Cell.BorderType |= BORDER_TYPE_BOTTOM; break;
        case tag_CLBRDRL: cur_Cell.BorderType |= BORDER_TYPE_LEFT; break;
        case tag_CLBRDRR: cur_Cell.BorderType |= BORDER_TYPE_RIGHT; break;
        case tag_CLBRDRT: cur_Cell.BorderType |= BORDER_TYPE_TOP; break;
        case tag_TRBRDRB: cur_Trow.BorderType |= BORDER_TYPE_BOTTOM; break;
        case tag_TRBRDRL: cur_Trow.BorderType |= BORDER_TYPE_LEFT; break;
        case tag_TRBRDRR: cur_Trow.BorderType |= BORDER_TYPE_RIGHT; break;
        case tag_TRBRDRT: cur_Trow.BorderType |= BORDER_TYPE_TOP; break;
        /*
	 *  Tabstops handling
	 */
        case tag_TAB: rtf_SetEmptyAttMark(flow_element_tab);break;
	case tag_TQC: cur_Tab.Align = TAB_ALIGN_CENTER; break;
	case tag_TQR: cur_Tab.Align = TAB_ALIGN_RIGHT; break;
	case tag_TQDEC: cur_Tab.Align = TAB_ALIGN_DEC; break;
        case tag_TLDOT: cur_Tab.Fill = TAB_FILL_DOTS; break;
	case tag_TLHYPH: cur_Tab.Fill = TAB_FILL_HYPH; break;
	case tag_TLUL: cur_Tab.Fill = TAB_FILL_UL; break;
	case tag_TX: AddTabstopToPara (Val); break;
	case tag_TB: cur_Tab.Fill = TAB_FILL_NONE;
		cur_Tab.Align = TAB_ALIGN_VERT;
		AddTabstopToPara (Val);
		break;
    }};

    switch (Key)
    {
        /*
	 *  Font Handling :
	 *  Font Table, Default Font, Effects, Formatting
	 */
	case tag_FONTTBL:
		rtf_push_Context (CNTX_FONTTBL);
        	break;
        case tag_FONT:
                if (Context==CNTX_FONTRECORD)
        		tmp_FontRec.ftbl_Num = Val;
		if (Context==CNTX_PLAIN)
			cur_Form.FontNum = Val;
        	break;
	case tag_FCHARSET:
                if (Context==CNTX_FONTRECORD)
        		tmp_FontRec.ftbl_Charset = Val;
        	break;
        case tag_FFDECOR:
        	if (Context==CNTX_FONTRECORD)
        		tmp_FontRec.ftbl_Family = FF_DECORATIVE;
		break;
        case tag_FFMODERN:
               	if (Context==CNTX_FONTRECORD)
        		tmp_FontRec.ftbl_Family = FF_MODERN;
        	break;
        case tag_FFNIL:
        	if (Context==CNTX_FONTRECORD)
        		tmp_FontRec.ftbl_Family = FF_DONTCARE;
		break;
        case tag_FFROMAN:
        	if (Context==CNTX_FONTRECORD)
        		tmp_FontRec.ftbl_Family = FF_ROMAN;
        	break;
        case tag_FFSCRIPT:
        	if (Context==CNTX_FONTRECORD)
        		tmp_FontRec.ftbl_Family = FF_SCRIPT;
        	break;
        case tag_FFSWISS:
        	if (Context==CNTX_FONTRECORD)
        		tmp_FontRec.ftbl_Family = FF_SWISS;
        	break;
        case tag_FFTECH:
        	if (Context==CNTX_FONTRECORD)
			tmp_FontRec.ftbl_Family = FF_DECORATIVE;
        	break;
	case tag_DEFF:
		DefFont = Val;
		break;
	/*
	 *  Color Table
	 */
	case tag_COLORTBL:
		rtf_push_Context (CNTX_COLORTBL);
		CreateColorTableRecord ();
		break;
	case tag_RED:
                if (Context==CNTX_COLORTBL)
			tmp_ColorRec.R = Val;
		break;
	case tag_GREEN:
                if (Context==CNTX_COLORTBL)
			tmp_ColorRec.G = Val;
		break;
	case tag_BLUE:
                if (Context==CNTX_COLORTBL)
			tmp_ColorRec.B = Val;
		break;
        /*
         * Ignored tokens (and subsequents)
         */
        case tag_STYLESHEET:              /* Skip statements    */
        case tag_ASTERISK:                /* that are begining  */
        case tag_INFO:                    /* with tese tokens   */
                rtf_push_Context (CNTX_IGNORED);
		break;
        /*
	 *  Footnotes
	 */
	case tag_FOOTNOTE:
		if ( get_Foot_Code () )
		{
			rtf_push_Context (CNTX_FOOTNOTE);
		}
		break;
	/*
	 *  Hypertext handling
	 *  \v must follow right after \ul\uldb\strike
         *
         *  cur_Link.Hotspot points to the current text flow tail
	 */
	case tag_ULDB:
	case tag_STRIKE:
	case tag_UL:
		if ( Val==-1 )
		{
			if ( Key == tag_UL )
				cur_Link.LinkType = LINK_POPUP;
			else	cur_Link.LinkType = LINK_JUMP;
			rtf_push_Context (CNTX_HOTSPOT);
                        cur_Link.Hotspot = (FLOW_ELEMENT*)list_GetTail(rtf_cur_List());
		}
		else if ( Context==CNTX_HOTSPOT )
		     {
			rtf_pop_Context ();
		     }
                break;
        case tag_V:
                rtf_push_Context (CNTX_HYPERLINK);
                break;

    }
    return Ret;
}
