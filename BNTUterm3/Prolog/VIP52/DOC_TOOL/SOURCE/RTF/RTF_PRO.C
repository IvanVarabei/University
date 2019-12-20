/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_PRO.C
 Purpose: RTF Parser. The implementation of the Prolog predicates
	  rtf_readpage (i,i,o,o)
	  rtfpage_term (i,i,o) (i,o,i) (i,o,o) (i,i,i)
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "rtf.h"        /*  Common declarations		*/
#include "rtf_pro.h"	/*  This module declarations	*/
#include "rtf_font.h"
#include "rtf_form.h"
#include "rtf_mem.h"
#include "../common/list.h"
#include "../common/atts.h"

/*
 *  External PDC RTL predicates
 */
extern void IO_RdDev_i ();
extern void IO_RdDev_o ();

extern void dump_element (FLOW_ELEMENT *pTbl);

/*
 *  Local functions
 */
void CreateNewDocTerm (void);
void ReleaseStacks (void);
void parse_LinkContext (void);
void SetFontMark (int FontNum,int FontSz,int FC,int BC,BOOL Begin);
void format_Paragraph (void);
void format_Trow (void);
void format_Cell (void);
void my_Hex (int, char*);
/*
 *  Global variables
 */
RTF_DOCPARSER_CALLBACK	ParserCB;
DOC *p_rtf_Doc;
BODY *p_rtf_Body;
int yylineno=0;
long yycharno=0;
LINKATTR cur_Link;
static ATTLIST *ParaAttlist;
static FLOW_ELEMENT *pCurPar;		// the current text flow
static BOOL INTBL=FALSE;
static BOOL TBLROW=FALSE;
static FLOW_ELEMENT *pCurTable;		// the current table pointer
static TROW *pCurRow;			// the current row pointer
static CELL *pCurCell;
static int CellIdx;
static PLIST pDocBodyFlow;
/*
 *  Default callback function
 *  Creates an empty document term and returns TRUE
 *  for further iteration
 */
BOOL rtf_default_cb (DOC *p_rtf_Doc)
{
	ReleaseStacks ();
	CreateNewDocTerm ();
	return TRUE;
}
/*
 *  Main parser iterator
 */
void rtfpage_term_0 (RTF_DOCPARSER_CALLBACK CBFunc)
{
	InitRTFParser ();

	yylineno=1;
	yycharno=1L;


	CreateNewDocTerm ();
	ParserCB = CBFunc;

	yyparse ();

	CallPageCallback ();
	clear_Page ();
	CloseRTFParser ();
}
/*
 *  Creates new term of DOC domain
 *  Marks the GS top
 *  push the doc body at the list top
 *  Then create the text flow inside the document body,
 *  because the RTF document sould not have any body
 *  element but text flows
 */
void CreateNewDocTerm (void)
{
	FLOW_ELEMENT	*pPar;
	//HEADELEM	*pHE;

	gs_Parser = MEM_MarkGStack ();

	p_rtf_Doc = galloc (sizeof(DOC));
	p_rtf_Doc->fno = doc_doc;
	p_rtf_Doc->Doctype=galloc(sizeof(char));
	p_rtf_Doc->Doctype[0]='\0';

	p_rtf_Body = galloc (sizeof(BODY));
	p_rtf_Body->fno = body_body;
	p_rtf_Body->Attlist=(ATTLIST*)list_GCreate();
	p_rtf_Body->Flow = (FLOW*) list_GCreate();

	p_rtf_Doc->Head=(HEAD*)list_GCreate();
	
	p_rtf_Doc->Body=p_rtf_Body;
	pDocBodyFlow = (PLIST)(p_rtf_Body->Flow);
	rtf_push_List (p_rtf_Body->Flow);
	
	pPar = (FLOW_ELEMENT*) galloc (sizeof(FLOW_ELEMENT));
	pPar->fno = flow_element_par;
	pPar->u.par.Flow = (FLOW*)list_GCreate ();
	pPar->u.par.Attlist = (ATTLIST*)list_GCreate ();

	pCurPar = pPar;
	ParaAttlist = pPar->u.par.Attlist;

	rtf_push_List (pPar->u.par.Flow);
}
/*
 *  Releases global and list stacks
 */
void ReleaseStacks (void)
{
	MEM_ReleaseGStack (gs_Parser);
	while ( rtf_pop_List () !=NULL ) ;
}

/*
 *  The callback function must be provided by caller, and
 *  return TRUE to continue parsing (FALSE to abort)
 *
 */
BOOL CallPageCallback (void)
{
	BOOL		Ret;
	HEADELEM 	*pNew,*pHE;
	/*
	 *  Flush the last paragraph if it is not empty
	 *  Call callback function
	 */
	rtf_pop_List ();
	if ( !list_IsEmpty((PLIST)pCurPar->u.par.Flow) )
	{
		list_AddTail ((PLIST)rtf_cur_List(),pCurPar);
	}
	//
	// Apply RTF meta information
	//
	pHE = (HEADELEM*)galloc(sizeof(HEADELEM));
	pHE->fno = headelem_meta;
	pHE->u.meta = (ATTLIST*) list_GCreate();
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("NAME",attval_lit,"SOURCE",0));
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("CONTENT",attval_lit,"RTF",0));
	list_AddTail((PLIST)p_rtf_Doc->Head,pHE);
	
	pHE = (HEADELEM*)galloc(sizeof(HEADELEM));
	pHE->fno = headelem_meta;
	pHE->u.meta = (ATTLIST*) list_GCreate();
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("NAME",attval_lit,"UNITS",0));
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("CONTENT",attval_lit,"TWIP",0));
	list_AddTail((PLIST)p_rtf_Doc->Head,pHE);

	/*
	 *  Process the page attributies like <META   >
	 */

	if ( strlen(cur_Page.Title) != 0 )
	{
		pNew = (HEADELEM*)galloc(sizeof(HEADELEM));
		pNew->fno = headelem_title;
		pNew->u.title = galloc((strlen(cur_Page.Title)+1)*sizeof(char));
		strcpy (pNew->u.title,cur_Page.Title);
		list_AddTail ((PLIST)p_rtf_Doc->Head,pNew);
	}
	if ( strlen(cur_Page.Keywords) !=0 )
	{
		pNew = (HEADELEM*)galloc(sizeof(HEADELEM));
		pNew->fno = headelem_meta;
		pNew->u.meta = (ATTLIST*) list_GCreate();
		list_AddTail ((PLIST)pNew->u.meta,
			CreateAttribute ("HTTP-EQUIV",attval_lit,"KEYWORDS",0));
		list_AddTail ((PLIST)pNew->u.meta,
			CreateAttribute ("CONTENT",attval_lit,cur_Page.Keywords,0));
		list_AddTail ((PLIST)p_rtf_Doc->Head,pNew);

	}
	if ( strlen(cur_Page.Context) != 0 )
	{
		pNew = (HEADELEM*)galloc(sizeof(HEADELEM));
		pNew->fno = headelem_meta;
		pNew->u.meta = (ATTLIST*) list_GCreate();
		list_AddTail ((PLIST)pNew->u.meta,
			CreateAttribute ("NAME",attval_lit,"CONTEXT",0));
		list_AddTail ((PLIST)pNew->u.meta,
			CreateAttribute ("CONTENT",attval_lit,cur_Page.Context,0));
		list_AddTail ((PLIST)p_rtf_Doc->Head,pNew);
	}
	if ( strlen(cur_Page.Macro) !=0 )
	{
		pNew = (HEADELEM*)galloc(sizeof(HEADELEM));
		pNew->fno = headelem_meta;
		pNew->u.meta = (ATTLIST*) list_GCreate();
		list_AddTail ((PLIST)pNew->u.meta,
			CreateAttribute ("NAME",attval_lit,"MACRO",0));
		list_AddTail ((PLIST)pNew->u.meta,
			CreateAttribute ("CONTENT",attval_lit,cur_Page.Macro,0));
		list_AddTail ((PLIST)p_rtf_Doc->Head,pNew);

	}
	if ( strlen(cur_Page.BrowseSeq) !=0 )
	{
		pNew = (HEADELEM*)galloc(sizeof(HEADELEM));
		pNew->fno = headelem_meta;
		pNew->u.meta = (ATTLIST*) list_GCreate();
		list_AddTail ((PLIST)pNew->u.meta,
                        CreateAttribute ("NAME",attval_lit,"BROWSE_SEQ",0));
		list_AddTail ((PLIST)pNew->u.meta,
                        CreateAttribute ("CONTENT",attval_lit,cur_Page.BrowseSeq,0));
		list_AddTail ((PLIST)p_rtf_Doc->Head,pNew);

	}

	Ret=ParserCB (p_rtf_Doc);
	/*
	 *  Prepare for new page
	 */
	ReleaseStacks ();
	CreateNewDocTerm ();

	return Ret;
}

/*
 *  Insert boolean markup in text flow
 *  Such markups are \b\i\ul and so on
 */
void rtf_SetBOOLMark (FLOW_ELEMENT_FNO Fno,BOOL Mark)
{
	FLOW_ELEMENT 	*pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Fno;
	pNew->u.b = Mark;
	list_AddTail(rtf_cur_List(),pNew);
}
/*
 *  Insert empty markup
 *  the typical one is \line
 */
void rtf_SetEmptyMark (FLOW_ELEMENT_FNO Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Mark;
        list_AddTail(rtf_cur_List(),pNew);
}
/*
 *  Insert empty markup with some attributies
 *  The typical one is \tab
 */
void rtf_SetEmptyAttMark (FLOW_ELEMENT_FNO Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Mark;
        pNew->u.tab = (ATTLIST*)list_GCreate();
        list_AddTail (rtf_cur_List(),pNew);
}


/*
 *  Hypertext link handling
 *  Create the a([att("HREF",lit("Context")],[txt("Hot Spot")])
 */

extern void dump_Flow ();
extern void dump_Element ();

void MakeHyperLink (void)
{

    	FLOW_ELEMENT    *pNew;
    	PLIST		pNext;
	PLIST		pCur;

	parse_LinkContext ();

        pNew = galloc (sizeof(FLOW_ELEMENT));
        pNew->fno = flow_element_a;
        pNew->u.a.Attlist = (ATTLIST*) list_GCreate ();

        list_AddTail((PLIST)pNew->u.a.Attlist,
                CreateAttribute ("HREF",attval_lit,cur_Link.LinkCntx,0));

	switch (cur_Link.LinkType)
	{
		case LINK_JUMP:
                        list_AddTail((PLIST)pNew->u.a.Attlist,
                                CreateAttribute ("TYPE",attval_lit,"JUMP",0));
                        break;
		case LINK_POPUP:
                        list_AddTail((PLIST)pNew->u.a.Attlist,
                                CreateAttribute ("TYPE",attval_lit,"POPUP",0));
                        break;
                case LINK_MACRO:
                        list_AddTail((PLIST)pNew->u.a.Attlist,
                                CreateAttribute ("TYPE",attval_lit,"MACRO",0));
                        break;
        }

        /*
         *  Link hotspot flow points to the saved position
         */
        pCur = rtf_cur_List ();
        pNext=list_SplitAfter (pCur,cur_Link.Hotspot);
        if ( list_IsEmpty(pNext) ) /* at the begining of para */
        {
                pNew->u.a.Flow = (FLOW*)pCur; /* all = hotspot */
                rtf_pop_List ();
                pCurPar->u.par.Flow = (FLOW*)pNext;
                rtf_push_List (pCurPar->u.par.Flow);
        }
        else
        {
                pNew->u.a.Flow = (FLOW*)pNext;

        }
        /*
         *  Find out this position in the current flow
         *  Make the previous as tail
         *  Add the link to the tail of new cutted list
         */
        list_AddTail (rtf_cur_List(),pNew);
}

void parse_LinkContext (void)
{
	char	*p1,*p2;
	/*
	 *  Find 'pure' Context string
	 */
	p1 = FootBuff;

	while ( *p1 && (isspace(*p1) || (*p1=='*') || (*p1=='%'))) p1++;
	if ( *p1=='!' ) /* This is a link macro */
	{
		strncpy (cur_Link.LinkCntx,p1,255);
		cur_Link.LinkType = LINK_MACRO;
		return;
	}
	p2 = p1;
	while(*p2 && !isspace(*p2)&&(*p2!='>')&&(*p2!='@')) p2++;
        strncpy (cur_Link.LinkCntx,p1,(p2-p1)+1);
}


void ClearHyperLink (void)
{
	cur_Link.Hotspot=NULL;
	cur_Link.LinkCntx[0]='\0';
	cur_Link.LinkType=LINK_NONE;
}

extern int no_first_PageFont;

void WriteFontCode (void)
{
	if ( is_Font_Equal(&cur_Form,&prev_Form) )return;
	
	if (no_first_PageFont)
		SetFontMark (cur_Form.FontNum,
		             cur_Form.FontSz,
			     cur_Form.ForeColor,
			     cur_Form.BackColor,
			     FALSE);
	else	no_first_PageFont = 1;
	
	SetFontMark (cur_Form.FontNum,
		     cur_Form.FontSz,
		     cur_Form.ForeColor,
		     cur_Form.BackColor,
		     TRUE);

	prev_Form.FontNum = cur_Form.FontNum;
	prev_Form.FontSz = cur_Form.FontSz;
	prev_Form.ForeColor = cur_Form.ForeColor;
	prev_Form.BackColor = cur_Form.BackColor;
}
/*
 *  Set current font.
 *  Lookup font descriptor in font table.
 */
void SetFontMark (int FontNum,int FontSz,int FC,int BC,BOOL Begin)
{
	int		NewFontSz = FontSz/2;
	FONTTBL_RECORD	fRec;
	FLOW_ELEMENT	*pNew;
	char		ForeColor[8];
	char		BackColor[8];
	char		Hex[3];
	int		FR,FG,FB;
	int		BR,BG,BB;
	
	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_font;
	pNew->u.font.Bool = Begin;
	pNew->u.font.Attlist = (ATTLIST*)list_GCreate ();
	
	if ( Begin )
	{
	
		lookup_Font (FontNum, &fRec);
		lookup_Color (FC,BC,&FR,&FG,&FB,&BR,&BG,&BB);

		ForeColor[0]='#';BackColor[0]='#';
		my_Hex (FR,Hex); ForeColor[1]=Hex[0]; ForeColor[2]=Hex[1];
		my_Hex (FG,Hex); ForeColor[3]=Hex[0]; ForeColor[4]=Hex[1];
		my_Hex (FB,Hex); ForeColor[5]=Hex[0]; ForeColor[6]=Hex[1];
		my_Hex (BR,Hex); BackColor[1]=Hex[0]; BackColor[2]=Hex[1];
		my_Hex (BG,Hex); BackColor[3]=Hex[0]; BackColor[4]=Hex[1];
		my_Hex (BB,Hex); BackColor[5]=Hex[0]; BackColor[6]=Hex[1];
		ForeColor[7]='\0';BackColor[7]='\0';
	
		list_AddTail((PLIST)pNew->u.font.Attlist,
			CreateAttribute("FACE",attval_lit,fRec.ftbl_FaceName,0));
		list_AddTail((PLIST)pNew->u.font.Attlist,
			CreateAttribute("SIZE",attval_num,"",NewFontSz));
		list_AddTail((PLIST)pNew->u.font.Attlist,
			CreateAttribute("FAMILY",attval_num,"",fRec.ftbl_Family));
		list_AddTail((PLIST)pNew->u.font.Attlist,
			CreateAttribute("COLOR",attval_lit,ForeColor,0));
		list_AddTail((PLIST)pNew->u.font.Attlist,
			CreateAttribute("BGCOLOR",attval_lit,BackColor,0));
		list_AddTail((PLIST)pNew->u.font.Attlist,
			CreateAttribute("ABSOLUTE",attval_nill,"",0));
	}
	list_AddTail(rtf_cur_List(),pNew);
}
/*
 *  Custom hex formatting. Add leading zero
 */
void my_Hex (int I, char *Hex)
{
	IO_SPrintf (Hex,"%2x",I);
	if (Hex[0]==' ') Hex[0]='0';
}
/*
 *  Format paragraph
 */
void format_Paragraph (void)
{
	switch ( cur_Para.Alignment )
	{
		case PARA_ALIGN_LEFT: break;
		case PARA_ALIGN_CENTER:
			list_AddTail((PLIST)ParaAttlist,
				CreateAttribute("ALIGN",attval_atom,"center",0));
			break;
		case PARA_ALIGN_RIGHT:
			list_AddTail((PLIST)ParaAttlist,
				CreateAttribute("ALIGN",attval_atom,"right",0));
			break;
		case PARA_ALIGN_JUSTIFY:
			list_AddTail((PLIST)ParaAttlist,
				CreateAttribute("ALIGN",attval_atom,"justify",0));
			break;
	}
	if ( cur_Para.LeftIndent != 0 )
		list_AddTail((PLIST)ParaAttlist,
			CreateAttribute(
					"LEFT.INDENT",
					attval_num,"",
					cur_Para.LeftIndent));
        if ( cur_Para.RightIndent != 0 )
		list_AddTail((PLIST)ParaAttlist,
			CreateAttribute(
					"RIGHT.INDENT",
					attval_num,"",
					cur_Para.RightIndent));

        if ( cur_Para.FirstLineIndent != 0 )
		list_AddTail((PLIST)ParaAttlist,
			CreateAttribute(
					"FIRST.LINE.INDENT",
					attval_num,"",
					cur_Para.FirstLineIndent));

        if ( cur_Para.SpaceBefore != 0 )
		list_AddTail((PLIST)ParaAttlist,
			CreateAttribute(
					"SPACE.BEFORE",
					attval_num,"",
					cur_Para.SpaceBefore));

        if ( cur_Para.SpaceAfter != 0 )
		list_AddTail((PLIST)ParaAttlist,
			CreateAttribute(
					"SPACE.AFTER",
					attval_num,"",
					cur_Para.SpaceAfter));

        if ( cur_Para.SpaceBetween != 0)
		list_AddTail((PLIST)ParaAttlist,
			CreateAttribute(
					"SPACE.BETWEEN",
					attval_num,"",
					cur_Para.SpaceBetween));

	if ( cur_Para.Wrap )
		list_AddTail((PLIST)ParaAttlist,
			CreateAttribute("NOWRAP",attval_nill,"",0));
        if ( cur_Para.NonScrollRegion )
		list_AddTail((PLIST)ParaAttlist,
			CreateAttribute("NOSCROLL",attval_nill,"",0));

	if ( cur_Para.BorderType )
	{
		list_AddTail((PLIST)ParaAttlist,
			CreateAttribute("BORDER",attval_num,"",cur_Para.BorderType));

        	switch (cur_Para.BorderStyle)
		{
			case BORDER_STYLE_STD: break;
			case BORDER_STYLE_THICK:
				list_AddTail((PLIST)ParaAttlist,
					CreateAttribute("BORDER.STYLE",
						attval_atom,"THICK",0));
				break;
			case BORDER_STYLE_DOUB:
				list_AddTail((PLIST)ParaAttlist,
					CreateAttribute("BORDER.STYLE",
						attval_atom,"DOUB",0));
				break;
			case BORDER_STYLE_SHADE:
				list_AddTail((PLIST)ParaAttlist,
					CreateAttribute("BORDER.STYLE",
						attval_atom,"SHADE",0));
				break;
		}
	}
}
//
//  Add paragraph to the current flow and make the new one
//
void rtf_Paragraph (void)
{
	FLOW_ELEMENT	*pNew;

	if (is_Para_Equal(&cur_Para,&prev_Para));
        else
        {
		format_Paragraph ();
	}
	/*
	 *  End the paragraph
	 *  Add it to the current text flow
	 *
	 *  If the current context is table, but we are not inside row
	 *  then END TABLE and add it to the current flow
	 */
	//rtf_pop_List ();  // pop to prev flow
	if (!INTBL)		// plain paragraph
	{
		while (rtf_cur_List()!=pDocBodyFlow) rtf_pop_List();
		list_AddTail (rtf_cur_List(),pCurPar);
	}
	if (INTBL && TBLROW)	// paragraph inside table
	{
		rtf_pop_List ();
		list_AddTail ((PLIST)pCurCell->u.td.Flow,pCurPar);
	}
	if ( INTBL && !TBLROW)	// paragraph just after table
	{
		INTBL = FALSE;
		while (rtf_cur_List()!=pDocBodyFlow) rtf_pop_List();
		list_AddTail (rtf_cur_List(),pCurTable);// add table
		list_AddTail (rtf_cur_List(),pCurPar);	// add next par
	}
	// Make new paragraph
	pNew = (FLOW_ELEMENT*) galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_par;
	pNew->u.par.Flow = (FLOW*)list_GCreate ();
	pNew->u.par.Attlist = (ATTLIST*)list_GCreate ();
	pCurPar = pNew;
	ParaAttlist = pNew->u.par.Attlist;

	rtf_push_List (pNew->u.par.Flow);
	
}
/*******************************************************************
 *   RTF table handling                                            *
 *******************************************************************/
//
//  Getting \intbl  (surprise !!! \intbl may be repeated inside row)
//
//  all subsequent tags are lays into table until the \row
//
void rtf_StartTableRow (void)
{
	FLOW_ELEMENT	*pNew;
	CAPTION		*pCaption;
	TROW		*pRow;
	CELL		*pCell;
	FLOW_ELEMENT	*pPar;
	//
	//  if we are already inside row
	//
	if (INTBL && TBLROW) return;
	//
	//  If we are not already in table, than start new one
	//
	if (!INTBL)
	{
		pNew = (FLOW_ELEMENT*) galloc (sizeof(FLOW_ELEMENT));
		pNew->fno = flow_element_table;
		pNew->u.table.Attlist = (ATTLIST*)list_GCreate ();
		//
		//  RTF table has an empty caption
		//
		pCaption = (CAPTION*) galloc (sizeof(CAPTION));
		pCaption->fno = caption_caption;
		pCaption->Attlist = (ATTLIST*)list_GCreate ();
		pCaption->Flow = (FLOW*)list_GCreate ();
		pNew->u.table.Caption = pCaption;
		pNew->u.table.Trow_list = (TROW_LIST*)list_GCreate ();
		pCurTable = pNew;
		//
		//  start table mode
		//
		INTBL = TRUE;
	}
	//
	//  Create Row
	//
	TBLROW = TRUE;
	pRow = (TROW*) galloc (sizeof(TROW));
	pRow->fno=trow_trow;
	pRow->Attlist = (ATTLIST*)list_GCreate ();
	pRow->Cell_list = (CELL_LIST*)list_GCreate ();
	list_AddTail ((PLIST)pCurTable->u.table.Trow_list,pRow);
	pCurRow = pRow;
	//
	//  then create first cell
	//
	pCell = (CELL*) galloc (sizeof(CELL));
	pCell->fno=cell_td;
	pCell->u.td.Attlist = (ATTLIST*)list_GCreate ();
	pCell->u.td.Flow = (FLOW*)list_GCreate ();
	pCurCell = pCell;
	CellIdx = 0;
	//
	//  then create first cell paragraph
	//
	pPar = (FLOW_ELEMENT*) galloc (sizeof(FLOW_ELEMENT));
	pPar->fno = flow_element_par;
	pPar->u.par.Flow = (FLOW*)list_GCreate ();
	pPar->u.par.Attlist = (ATTLIST*)list_GCreate ();
	pCurPar = pPar;
	ParaAttlist = pPar->u.par.Attlist;
	//
	//  Set the cell's flow as current text flow
	//
	rtf_push_List (pPar->u.par.Flow);
}
//
//  End Table Row
//
void rtf_EndTableRow (void)
{
	TBLROW = FALSE;
	format_Trow ();       
	if (!list_IsEmpty((PLIST)pCurCell->u.td.Flow))
	{
		format_Cell ();
		list_AddTail((PLIST)pCurRow->Cell_list,pCurCell);
	}
}
//
//  End Table Cell
//
void rtf_EndTableCell (void)
{
	CELL		*pCell;
	FLOW_ELEMENT	*pPar;
	
	if (INTBL)
	{
		// Add prev cell to the current row
		if (!list_IsEmpty((PLIST)pCurPar->u.par.Flow))
			list_AddTail ((PLIST)pCurCell->u.td.Flow,pCurPar);
		format_Cell ();
		list_AddTail ((PLIST)pCurRow->Cell_list,pCurCell);
		rtf_pop_List (); // pop cell
		//
		//  make new cell
		//
		pCell = (CELL*) galloc (sizeof(CELL));
		pCell->fno=cell_td;
		pCell->u.td.Attlist = (ATTLIST*)list_GCreate ();
		pCell->u.td.Flow = (FLOW*)list_GCreate ();
		pCurCell = pCell;
		CellIdx++;
		
		pPar = (FLOW_ELEMENT*) galloc (sizeof(FLOW_ELEMENT));
		pPar->fno = flow_element_par;
		pPar->u.par.Flow = (FLOW*)list_GCreate ();
		pPar->u.par.Attlist = (ATTLIST*)list_GCreate ();
		pCurPar = pPar;
		ParaAttlist = pPar->u.par.Attlist;
		//
		//  Set the cell's flow as current text flow
		//
		rtf_push_List (pPar->u.par.Flow);
	}
}
//
//  format table row
//
void format_Trow (void)
{
	if ( cur_Trow.LeftIndent !=0 )
		list_AddTail((PLIST)pCurRow->Attlist,
			CreateAttribute("LEFT.INDENT",
					attval_num,"",
					cur_Trow.LeftIndent));

	if ( cur_Trow.Gaph != 0 )
		list_AddTail((PLIST)pCurRow->Attlist,
			CreateAttribute("GAPH",
					attval_num,"",
					cur_Trow.Gaph));
	
	if ( cur_Trow.BorderType )
	{
		list_AddTail((PLIST)pCurRow->Attlist,
			CreateAttribute("BORDER",attval_num,"",cur_Trow.BorderType));

        	switch (cur_Para.BorderStyle)
		{
			case BORDER_STYLE_STD: break;
			case BORDER_STYLE_THICK:
				list_AddTail((PLIST)pCurRow->Attlist,
					CreateAttribute("BORDER.STYLE",
						attval_atom,"THICK",0));
				break;
			case BORDER_STYLE_DOUB:
				list_AddTail((PLIST)pCurRow->Attlist,
					CreateAttribute("BORDER.STYLE",
						attval_atom,"DOUB",0));
				break;
			case BORDER_STYLE_SHADE:
				list_AddTail((PLIST)pCurRow->Attlist,
					CreateAttribute("BORDER.STYLE",
						attval_atom,"SHADE",0));
				break;
		}
	}
}
//
//  format current cell
//
void format_Cell (void)
{
	if ( cur_Trow.Cells[CellIdx].Pos !=0 )
	{
		//
		//  calculate current cell width
		//                              
		int W=0;
		if (CellIdx==0) W=cur_Trow.Cells[CellIdx].Pos-cur_Trow.LeftIndent;
		else W=cur_Trow.Cells[CellIdx].Pos-cur_Trow.Cells[CellIdx-1].Pos;
		
		list_AddTail((PLIST)pCurCell->u.td.Attlist,
			CreateAttribute("WIDTH",attval_num,"",W));
	}
	
	if ( cur_Trow.Cells[CellIdx].BorderType )
	{
		list_AddTail((PLIST)pCurCell->u.td.Attlist,
			CreateAttribute("BORDER",attval_num,"",
				cur_Trow.Cells[CellIdx].BorderType));

        	switch (cur_Para.BorderStyle)
		{
			case BORDER_STYLE_STD: break;
			case BORDER_STYLE_THICK:
				list_AddTail((PLIST)pCurCell->u.td.Attlist,
					CreateAttribute("BORDER.STYLE",
						attval_atom,"THICK",0));
				break;
			case BORDER_STYLE_DOUB:
				list_AddTail((PLIST)pCurCell->u.td.Attlist,
					CreateAttribute("BORDER.STYLE",
						attval_atom,"DOUB",0));
				break;
			case BORDER_STYLE_SHADE:
				list_AddTail((PLIST)pCurCell->u.td.Attlist,
					CreateAttribute("BORDER.STYLE",
						attval_atom,"SHADE",0));
				break;
		}
	}
}