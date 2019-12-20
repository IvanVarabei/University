/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_FORM.C
 Purpose: RTF Parser. Format Handlihg Routines Manage paragraph, font and
	  text highlighting.
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "rtf.h"
#include "rtf_form.h"
#include "rtf_pro.h"

PARAGRAPH cur_Para;
PARAGRAPH prev_Para;
FORMAT cur_Form;
FORMAT prev_Form;
TABSTOP cur_Tab;
TROWINF cur_Trow;
CELLINF cur_Cell;

int DefFont;

/*
 * Format information are stored in a stacks
 * to implement nested RTF statements
 */
#define FORM_STACK_MAX_DEEP     63

static PARAGRAPH ParaStack [FORM_STACK_MAX_DEEP]; /* Paragraph stack    */
static FORMAT FormatStack  [FORM_STACK_MAX_DEEP]; /* Format stack       */

static PARAGRAPH *ParaSP;                         /* Next stack place   */
static FORMAT *FormatSP;

int no_first_PageFont = 0;

/*
 * Local functions
 */

void tabstop_Clear (TABSTOP *Tabstops);
BOOL is_Tabs_Equal (TABSTOP *T1,TABSTOP *T2);
void default_Cell (CELLINF *pCell);

void InitFormat (void)
{
	FormatSP=FormatStack;
	ParaSP=ParaStack;
        default_Para (&cur_Para);
        default_Para (&prev_Para);
        default_Trow (&cur_Trow);
	default_Cell (&cur_Cell);
	DefFont=0;
	no_first_PageFont = 0;
	plain_Text(&cur_Form);
	plain_Text(&prev_Form);
}

/*
 * Paragraph Stack Handling
 */
void push_Paragraph (PARAGRAPH *Para)
{
        if (ParaSP >= (&ParaStack[FORM_STACK_MAX_DEEP]))
                yyerror ("paragraph stack is too deep");
        memcpy(ParaSP++,Para,sizeof(PARAGRAPH));
}

void pop_Paragraph (PARAGRAPH *Para)
{
        if (ParaSP==ParaStack)
                yyerror ("paragraph stack underflow");
        memcpy (Para,--ParaSP,sizeof(PARAGRAPH));
}

void cur_Paragraph (PARAGRAPH *Para)
{
        if (ParaSP==ParaStack)
                yyerror ("paragraph stack underflow");
        memcpy (Para,ParaSP-1,sizeof(PARAGRAPH));
}

/*
 *  Format stack handling
 */
void push_Format (FORMAT *Format)
{
        if (FormatSP>=&FormatStack[FORM_STACK_MAX_DEEP])
                yyerror ("format stack is too deep");
        memcpy(FormatSP++,Format,sizeof(FORMAT));
}

void pop_Format (FORMAT *Format)
{
        if (FormatSP==FormatStack)
                yyerror ("format stack underflow");
        memcpy (Format,--FormatSP,sizeof(FORMAT));
}

void cur_Format (FORMAT *Format)
{
        if (FormatSP==FormatStack)
                yyerror ("format stack underflow");
        memcpy (Format,FormatSP-1,sizeof(FORMAT));
}

/*
 * Default Paragraph Information (\pard)
 */
void default_Para (PARAGRAPH *Para)
{
        Para->LeftIndent      = 0;
        Para->RightIndent     = 0;
        Para->FirstLineIndent = 0;
        Para->SpaceBefore     = 0;
        Para->SpaceAfter      = 0;
        Para->SpaceBetween    = 0;
        Para->Wrap            = FALSE;
        Para->NonScrollRegion = FALSE;
        Para->BorderType      = BORDER_TYPE_NONE;
        Para->BorderStyle     = BORDER_STYLE_STD;
        Para->Alignment       = PARA_ALIGN_LEFT;
        tabstop_Clear (Para->Tabstops);
}
/*
 *  Clear tabstop array in paragraph
 */
void tabstop_Clear (TABSTOP *Tabstops)
{
        memset (Tabstops,0,sizeof(TABSTOP)*MAX_TABS);
}
/*
 *  Copy paragraph to other location
 */
void copy_Para (PARAGRAPH *Dest, PARAGRAPH *Src)
{
        memcpy (Dest,Src,sizeof(PARAGRAPH));
}

/*
 *  Compare paragraphs and tabstops
 */
BOOL is_Para_Equal (PARAGRAPH *P1,PARAGRAPH *P2)
{
        return ((P1->LeftIndent == P2->LeftIndent) &&
                (P1->RightIndent == P2->RightIndent) &&
                (P1->FirstLineIndent == P2->FirstLineIndent) &&
                (P1->SpaceBefore == P2->SpaceBefore) &&
                (P1->SpaceAfter == P2->SpaceAfter) &&
                (P1->SpaceBetween == P2->SpaceBetween) &&
                (P1->Wrap == P2->Wrap) &&
                (P1->NonScrollRegion == P2->NonScrollRegion) &&
                (P1->BorderType == P2->BorderType) &&
                (P1->BorderStyle == P2->BorderStyle) &&
                (P1->Alignment == P2->Alignment) &&
                is_Tabs_Equal (P1->Tabstops,P2->Tabstops)
               );
}

BOOL is_Tabs_Equal (TABSTOP *T1,TABSTOP *T2)
{
        int i;

        for (i=0;i<MAX_TABS;i++)
        {
                if ((T1[i].Pos != T2[i].Pos) ||
                    (T1[i].Fill != T2[i].Fill) ||
                    (T1[i].Align != T2[i].Align)) return FALSE;
        }
        return TRUE;
}

/*
 *  Setup Plain Text (reflect \plain)
 */
void plain_Text (FORMAT *Form)
{
	Form->FontNum=DefFont;
	Form->FontSz=24;
	Form->Effects=HL_NONE;
	Form->ForeColor=0;
	Form->BackColor=0;
}

/*
 *  Restore Format information if the current and
 *  previous formats are different
 */
void rev_Format (FORMAT *to_Form,FORMAT *from_Form)
{
	char Diffs;

	if (!is_Font_Equal(to_Form,from_Form))
	{
		WriteFontCode ();
	}
	Diffs = to_Form->Effects ^ from_Form->Effects;

	if ( Diffs & HL_BOLD )
		rtf_SetBOOLMark (flow_element_b,(BOOL)(from_Form->Effects & HL_BOLD));
	if ( Diffs & HL_ITALIC )
		rtf_SetBOOLMark (flow_element_i,(BOOL)(from_Form->Effects & HL_ITALIC));
	if ( Diffs & HL_UNDERLINE )
		rtf_SetBOOLMark (flow_element_u,(BOOL)(from_Form->Effects & HL_UNDERLINE));
	copy_Format (to_Form, from_Form);
}

/*
 *  Copy format information
 */
void copy_Format (FORMAT *Dest,FORMAT *Src)
{
	memcpy(Dest,Src,sizeof(FORMAT));
}

BOOL is_Font_Equal (FORMAT *F1,FORMAT *F2)
{
	return ((F1->FontNum==F2->FontNum) &&
		(F1->FontSz==F2->FontSz) &&
		(F1->ForeColor==F2->ForeColor) &&
		(F1->BackColor==F2->BackColor));
}
/*
 *  Tabstops handling
 *  Add current tabstop to current paragraph
 *  tabstops array.
 */
void AddTabstopToPara (int Val)
{
	int i;

	for ( i=0;i<MAX_TABS;i++ )
	{
		if ( cur_Para.Tabstops[i].Pos==0 )
		{
			cur_Para.Tabstops[i].Align=cur_Tab.Align;
			cur_Para.Tabstops[i].Fill=cur_Tab.Fill;
			cur_Para.Tabstops[i].Pos=Val;
			cur_Tab.Align=TAB_ALIGN_LEFT;
			cur_Tab.Fill=TAB_FILL_NONE;
			return;
		}
	}
}

/*
 *  Start formatting of a new page
 */
void NewPageFormat (void)
{
	/*
	PARAGRAPH 	tmp_Para;

	default_Para (&tmp_Para);

	if (!is_Para_Equal(&tmp_Para,&cur_Para))
	{
		default_Para (&prev_Para);
	}
	*/
	if (cur_Form.Effects & HL_BOLD) rtf_SetBOOLMark (flow_element_b,TRUE);
	if (cur_Form.Effects & HL_ITALIC) rtf_SetBOOLMark (flow_element_i,TRUE);
	no_first_PageFont = 0;	
}
/*
 *  Table Row and Cell format handling
 *
 *   default_Trow : \trowd
 */
void default_Trow (TROWINF *Trow)
{
	Trow->LeftIndent = 0;
	Trow->BorderType = BORDER_TYPE_NONE;
	Trow->BorderStyle = BORDER_STYLE_STD;
	memset (Trow->Cells,0,sizeof(CELL)*MAX_CELLS);
}

void default_Cell (CELLINF *pCell)
{
	pCell->BorderType=BORDER_TYPE_NONE;
	pCell->BorderStyle=BORDER_STYLE_STD;
}

void AddCellToTrow (int Val)
{
	int i;

	for ( i=0;i<MAX_CELLS;i++ )
	{
		if ( cur_Trow.Cells[i].Pos==0 )
		{
			cur_Trow.Cells[i].Pos=Val;
			cur_Trow.Cells[i].BorderType=cur_Cell.BorderType;
			cur_Trow.Cells[i].BorderStyle=cur_Cell.BorderStyle;
			default_Cell (&cur_Cell);
			return;
		}
	}
}
