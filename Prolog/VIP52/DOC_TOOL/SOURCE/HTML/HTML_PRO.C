/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_PRO.C
 Purpose: HTML Parser. This module is a "code generator" and produces the
	  Prolog term of the domain, that last is a representation of HTML DTD
	  See: DOCSTR.DOM
 Written by: 
 Comments:
******************************************************************************/

#include "html.h"
#include "../common/list.h"
#include "../common/misc.h"
#include "../common/atts.h"
#include "html_key.h"
#include "html_tag.h"
#include "html_pro.h"
#include "html_mem.h"

DOC *pDoc;              /* Pointer to document term to be parsed in        */
BODY *pBody;            /* Pointer to document's body   */
static FLOW_ELEMENT *pCurFlow;  /* Pointer to the currently parsed element */
int IsPreformatted;
int IsScript;
char *yy_input_string;   /* Points to the input string   */
//int yylineno=0;
long yycharno=0L;
/*
 *  Local functions
 */
static void OnBodyAtt (void);
static void OnNewBlock (FLOW_ELEMENT_FNO Mark,unsigned long NewCntx);
static void OnNewInline (FLOW_ELEMENT_FNO Mark,unsigned long NewCntx);
static void OnNewScript (void);
static void OnNewApplet (void);
static void OnNewAppletParam (void);
static void OnNewFrameSet (void);
static void OnNewFrame (void);
static void OnEndTag_1 (unsigned long);
static void OnEndTag_2 (void);
static void OnEndTag_3 (unsigned long);
static void EndParagraph (void);
static void SetBOOLMark (FLOW_ELEMENT_FNO Fno,BOOL Mark);
static void SetBOOLAttMark (FLOW_ELEMENT_FNO Fno,BOOL Mark);
static void SetEmptyMark (FLOW_ELEMENT_FNO Mark);
static void SetEmptyAttMark (FLOW_ELEMENT_FNO Mark);
static void SetCommonMark (char *Name,BOOL Mark);
static void SetHeading (int L);
static void OnNewList (FLOW_ELEMENT_FNO ListType);
static void OnNewLH (void);
static void OnNewLI (LI_FNO ListType);
static LH *CreateListHeader (void);
static void OnNewTable (void);
static void OnNewTableRow (BOOL);
static void OnNewTableCell (CELL_FNO Type,BOOL);
static void OnNewTableCol(void);
static void OnNewTableColGroup(void);
static void OnNewTableHead(void);
static void OnNewTableFoot(void);
static void OnNewTableBody(void);
static void OnNewCaption (void);
static void OnNewFormTextArea (void);
static void OnNewFormSelect (void);
static void OnNewFormOption (void);
static void OnNewMap (void);
static void OnNewArea (void);
static void AddHeadElement (HEADELEM_FNO);
static void* html_cur_Flow (void);
static int  InvalidContextBeginTag(int Key);
static int  InvalidContextEndTag(int Key);
/*
 * html_term () - the core predicate
 *           1.  (i,o)  calls yyparse ()
 *                      returns the term of DOC domain
 *           2.  (o,i)  constructs the HTML document from the
 *                      term of DOC domain
 *           3.  (i,i)  unify the HTML document and the term
 *
 *           The first flow pattern is implemented in C
 *           The second and third ones are implemented in
 *           Prolog and calls the appropriate internal
 *           predicates
 */
/*
 * (i,o)
 */
void html_term_0 (char *Str,DOC **ppDoc)
{

	HEADELEM *pHE;

	InitHTMLParser ();

        IsPreformatted=0;
        IsScript=0;

	yylineno=1;
	yycharno=1L;

	yy_input_string = Str;

	pDoc = galloc (sizeof(DOC));
	pBody = galloc (sizeof(BODY));
	/*
	 *  Initialize pDoc with null values
	 */
	pDoc->fno = doc_doc;
	pDoc->Doctype=galloc(sizeof(char));
	pDoc->Doctype[0]='\0';

	pDoc->Head=(HEAD*)list_GCreate();
        pDoc->Body=pBody;
	//
	//  Apply HTML meta information
	//
	pHE = (HEADELEM*)galloc(sizeof(HEADELEM));
	pHE->fno = headelem_meta;
	pHE->u.meta = (ATTLIST*) list_GCreate();
		list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("NAME",attval_lit,"SOURCE",0));
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("CONTENT",attval_lit,"HTML",0));
	list_AddTail((PLIST)pDoc->Head,pHE);
	
	pHE = (HEADELEM*)galloc(sizeof(HEADELEM));
	pHE->fno = headelem_meta;
	pHE->u.meta = (ATTLIST*) list_GCreate();
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("NAME",attval_lit,"UNITS",0));
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("CONTENT",attval_lit,"PIXEL",0));
	list_AddTail((PLIST)pDoc->Head,pHE);

        pBody->fno = body_body;
        pBody->Attlist=(ATTLIST*)list_GCreate();
        pBody->Flow = (FLOW*) list_GCreate();

	html_push_Context (CNTX_BODY);	/* The first body context       */
        html_push_List (pBody->Flow);	/* The body element list ptr    */

	IsPreformatted = 0;
	IsScript = 0;

	yyparse ();

	*ppDoc = pDoc;
	CloseHTMLParser ();
}
/*
**   ProcessTag () - the main tag processor
*/
void ProcessTag (void)
{
	int Key = GetTagValue(cur_Tag.tag_Name);
        //
        //  Head contexts should be immediatelly closed
        //  if the tag is found in the context,
        //  because only CDATA (i.e. plain strings) are allowed
        //  in those contexts (HTML 3.2 DTD)
        //
        if(CHECK_CONTEXT(CNTX_HEAD_STYLE)) OnEndTag_1(CNTX_HEAD_STYLE);
        if(CHECK_CONTEXT(CNTX_HEAD_TITLE)) OnEndTag_1(CNTX_HEAD_TITLE);
	//
	//  Check if tag allowed in current context
	//
	if(InvalidContextBeginTag(Key)) return;

	switch ( Key )
	{
		case tag_BODY:	OnBodyAtt (); break;
		/*
		 *  Text flow blocks
		 */
		case tag_P:     OnNewBlock (flow_element_par,CNTX_PARA); break;
		case tag_DEL:	OnNewBlock (flow_element_del,CNTX_BLOCK); break;
		case tag_INS:	OnNewBlock (flow_element_ins,CNTX_BLOCK); break;
		case tag_A:     OnNewBlock (flow_element_a,CNTX_BLOCK);break;
		case tag_FN:    OnNewBlock (flow_element_fn,CNTX_BLOCK);break;
		case tag_NOTE:  OnNewBlock (flow_element_note,CNTX_BLOCK);break;
		case tag_BQ:    OnNewBlock (flow_element_blockquote,CNTX_BLOCK);break;
		case tag_PRE:   IsPreformatted = 1;
				OnNewBlock (flow_element_preformatted,CNTX_BLOCK);break;
		case tag_ADDRESS: OnNewBlock (flow_element_address,CNTX_BLOCK); break;
                case tag_DIV:   OnNewBlock (flow_element_div,CNTX_BLOCK); break;
		case tag_SPAN:	OnNewInline (flow_element_span,CNTX_BLOCK);break;
		/*
		 *  Font markups
		 */
                case tag_B:       SetBOOLMark (flow_element_b,TRUE); break;
                case tag_U:       SetBOOLMark (flow_element_u,TRUE); break;
                case tag_I:       SetBOOLMark (flow_element_i,TRUE); break;
                case tag_TT:      SetBOOLMark (flow_element_tt,TRUE); break;
                case tag_S:       SetBOOLMark (flow_element_s,TRUE); break;
                case tag_BIG:     SetBOOLMark (flow_element_big,TRUE); break;
                case tag_SMALL:   SetBOOLMark (flow_element_small,TRUE); break;
                case tag_SUB:     SetBOOLMark (flow_element_sub,TRUE); break;
                case tag_SUP:     SetBOOLMark (flow_element_sup,TRUE); break;
                case tag_EM:      SetBOOLMark (flow_element_em,TRUE); break;
                case tag_STRONG:  SetBOOLMark (flow_element_strong,TRUE); break;
                case tag_CODE:    SetBOOLMark (flow_element_code,TRUE); break;
                case tag_SAMP:    SetBOOLMark (flow_element_samp,TRUE); break;
                case tag_KBD:     SetBOOLMark (flow_element_kbd,TRUE); break;
                case tag_VAR:     SetBOOLMark (flow_element_var,TRUE); break;
                case tag_CITE:    SetBOOLMark (flow_element_cite,TRUE); break;
                case tag_DFN:     SetBOOLMark (flow_element_dfn,TRUE); break;
		case tag_ABBR:	  SetBOOLMark (flow_element_abbr,TRUE); break;
		case tag_ACRONYM: SetBOOLMark (flow_element_acronym,TRUE); break;
		case tag_Q:       SetBOOLMark (flow_element_q,TRUE); break;
                /*
                 *   Line breaks,hrs,tabs,spots, and images
		 */
		case tag_BR:    SetEmptyMark (flow_element_br); break;
                case tag_HR:    SetEmptyAttMark (flow_element_hr);break;
		case tag_IMG:   SetEmptyAttMark (flow_element_img); break;
		case tag_TAB:   SetEmptyAttMark (flow_element_tab); break;
		/*
		 *   Fonts
		 */
		case tag_FONT:  SetBOOLAttMark (flow_element_font,TRUE); break;
		/*
		 *   Headings (up to 6 levels)
		 */
		case tag_H1: SetHeading (1); break;
		case tag_H2: SetHeading (2); break;
		case tag_H3: SetHeading (3); break;
		case tag_H4: SetHeading (4); break;
		case tag_H5: SetHeading (5); break;
		case tag_H6: SetHeading (6); break;
		/*
		 *   Other body elements
		 */
                case tag_SCRIPT:
			IsScript = 1;
			OnNewScript (); break;
                case tag_APPLET:OnNewApplet (); break;
                case tag_PARAM: OnNewAppletParam (); break;
		case tag_FRAMESET: OnNewFrameSet (); break;
		case tag_FRAME: OnNewFrame (); break;
		case tag_NOFRAMES: SetBOOLMark (flow_element_noframes,TRUE); break;
		/*
		 *   Lists (ordered, unordered, definitions)
		 */
		case tag_OL: OnNewList (flow_element_ol); break;
		case tag_UL: OnNewList (flow_element_ul); break;
		case tag_DL: OnNewList (flow_element_dl); break;
		case tag_LH: OnNewLH () ;break;
		case tag_LI: OnNewLI (li_li); break;
		case tag_DD: OnNewLI (li_dd); break;
		case tag_DT: OnNewLI (li_dt); break;
		/*
		 *   Tables
		 */
		case tag_TABLE:   OnNewTable (); break;
		case tag_CAPTION: OnNewCaption (); break;
		case tag_TR:      OnNewTableRow (TRUE); break;
		case tag_TD:      OnNewTableCell (cell_td,TRUE); break;
		case tag_TH:      OnNewTableCell (cell_th,TRUE); break;
		case tag_COL:	  OnNewTableCol();break;
		case tag_COLGROUP:OnNewTableColGroup();break;
		case tag_THEAD:   OnNewTableHead();break;
		case tag_TFOOT:   OnNewTableFoot();break;
		case tag_TBODY:   OnNewTableBody();break;
		/*
		 *   Fill out forms
		 */
		case tag_FORM:     OnNewBlock (flow_element_form,CNTX_FORM); break;
		case tag_SELECT:   OnNewFormSelect (); break;
		case tag_OPTION:   OnNewFormOption (); break;
		case tag_TEXTAREA: OnNewFormTextArea (); break;
		case tag_INPUT:    SetEmptyAttMark (flow_element_input); break;
		/*
		 *   Figures
		 */
		case tag_MAP:	   OnNewMap (); break;
                case tag_AREA:     OnNewArea (); break;
		/*
		 *   Document head elements
		 */
		case tag_TITLE  : AddHeadElement (headelem_title); break;
		case tag_LINK   : AddHeadElement (headelem_link); break;
		case tag_META   : AddHeadElement (headelem_meta); break;
		case tag_ISINDEX: AddHeadElement (headelem_isindex); break;
		case tag_BASE   : AddHeadElement (headelem_base); break;
		case tag_STYLE  : AddHeadElement (headelem_style); break;
                /*
                 *   Common tag
                 */
                case tag_Common : SetCommonMark (cur_Tag.tag_Name,TRUE);break;

	}
}

void CloseTag (char *Tag)
{
	int     Key;
	char    UName[NAMELEN];

	strcpy_toupper(UName,Tag);
	Key = GetTagValue(UName);
	if(IsScript && Key!=tag_SCRIPT)
	{
		char	*Buff;
		Buff = (char*)galloc(strlen(Tag)+4*sizeof(char));
		sprintf(Buff,"</%s>",Tag);
		AddPlainText(Buff);
		return;
	}
	//
	//  Check if the tag is valid in the current context
	//
	if(InvalidContextEndTag(Key)) return;	
	
	switch ( Key )
	{
		case tag_P      : OnEndTag_1 (CNTX_PARA);break;
		case tag_LI     : OnEndTag_1 (CNTX_LI);break;
		case tag_OPTION : OnEndTag_1 (CNTX_FORM_OPTION);break;
		case tag_TR     : OnEndTag_1 (CNTX_TABLE_CELL|CNTX_TABLE_ROW);break;
		case tag_TH     :
		case tag_TD     : OnEndTag_1 (CNTX_TABLE_CELL);break;
		
		case tag_COLGROUP: OnEndTag_1(CNTX_TABLE_COLGROUP); break;
		
		case tag_STYLE  : OnEndTag_1 (CNTX_HEAD_STYLE); break;
		case tag_TITLE  : OnEndTag_1 (CNTX_HEAD_TITLE); break;
		case tag_SCRIPT	: IsScript=0;
				  OnEndTag_1 (CNTX_SCRIPT); break;
		case tag_H1     :
		case tag_H2     :
		case tag_H3     :
		case tag_H4     :
		case tag_H5     :
		case tag_H6     :
		case tag_ADDRESS:
                case tag_APPLET :
		case tag_FRAMESET:
		case tag_DIV	:
		case tag_SPAN	:
		case tag_DEL	:
		case tag_INS	:
		case tag_UL     :
		case tag_OL     :
		case tag_DL     :
		case tag_LH     :
		case tag_DD     :
		case tag_DT     :
		case tag_CAPTION:
		case tag_TABLE  :
		case tag_THEAD	:
		case tag_TFOOT	:
		case tag_TBODY	:
		case tag_FORM   :
		case tag_TEXTAREA:
		case tag_SELECT : OnEndTag_2 (); break;
		case tag_A      :
		case tag_FN     :
                case tag_NOTE   : OnEndTag_1 (CNTX_BLOCK);break;
		case tag_PRE    : IsPreformatted = 0;
				  OnEndTag_1 (CNTX_BLOCK); break;
		case tag_BQ     : OnEndTag_1 (CNTX_BLOCK); break;

		case tag_MAP	: OnEndTag_2 (); break;
                /*
		 *  Font markups
		 */
                case tag_B:       SetBOOLMark (flow_element_b,FALSE); break;
                case tag_U:       SetBOOLMark (flow_element_u,FALSE); break;
                case tag_I:       SetBOOLMark (flow_element_i,FALSE); break;
                case tag_TT:      SetBOOLMark (flow_element_tt,FALSE); break;
                case tag_S:       SetBOOLMark (flow_element_s,FALSE); break;
                case tag_BIG:     SetBOOLMark (flow_element_big,FALSE); break;
                case tag_SMALL:   SetBOOLMark (flow_element_small,FALSE); break;
                case tag_SUB:     SetBOOLMark (flow_element_sub,FALSE); break;
                case tag_SUP:     SetBOOLMark (flow_element_sup,FALSE); break;
                case tag_EM:      SetBOOLMark (flow_element_em,FALSE); break;
                case tag_STRONG:  SetBOOLMark (flow_element_strong,FALSE); break;
                case tag_CODE:    SetBOOLMark (flow_element_code,FALSE); break;
                case tag_SAMP:    SetBOOLMark (flow_element_samp,FALSE); break;
                case tag_KBD:     SetBOOLMark (flow_element_kbd,FALSE); break;
                case tag_VAR:     SetBOOLMark (flow_element_var,FALSE); break;
                case tag_CITE:    SetBOOLMark (flow_element_cite,FALSE); break;
		case tag_DFN:	  SetBOOLMark (flow_element_dfn,FALSE); break;
		case tag_ABBR:	  SetBOOLMark (flow_element_abbr,FALSE); break;
		case tag_ACRONYM: SetBOOLMark (flow_element_acronym,FALSE); break;
		case tag_Q:       SetBOOLMark (flow_element_q,FALSE); break;

		case tag_NOFRAMES:SetBOOLMark (flow_element_noframes,FALSE); break;
		case tag_FONT:  SetBOOLAttMark (flow_element_font,FALSE); break;

                case tag_Common:SetCommonMark (UName,FALSE); break;

	}
}
/*
 *  Update body attributies
 */
void OnBodyAtt (void)
{
	CopyAttlist (pBody->Attlist);
}
/*
 *  Insert new text block
 */
void OnNewBlock (FLOW_ELEMENT_FNO Mark,unsigned long NewCntx)
{
	FLOW_ELEMENT    *pNew;          /* new flow element */

	EndParagraph ();
	/*
	 *   Construct new text block (form or paragraph)
	 */
	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Mark;
	pNew->u.par.Attlist = CreateAttlist();
	pNew->u.par.Flow = (FLOW*)list_GCreate ();
    	list_AddTail (html_cur_Flow(),pNew);
	/*
	 *   Add new block to the current list tail
	 *   Push appropriate context
	 *   Set the current flow list
	 */
	html_push_Context (NewCntx);
	html_push_List (pNew->u.par.Flow);
}

void OnNewInline (FLOW_ELEMENT_FNO Mark,unsigned long NewCntx)
{
	FLOW_ELEMENT    *pNew;          /* new flow element */

	/*
	 *   Construct new text block (form or paragraph)
	 */
	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Mark;
	pNew->u.par.Attlist = CreateAttlist();
	pNew->u.par.Flow = (FLOW*)list_GCreate ();
    	list_AddTail (html_cur_Flow(),pNew);
	/*
	 *   Add new block to the current list tail
	 *   Push appropriate context
	 *   Set the current flow list
	 */
	html_push_Context (NewCntx);
	html_push_List (pNew->u.par.Flow);
}
/*
 *  Common end tag routine
 *
 *  1. Popup stacks only in permitted context
 *  2. First close "nonclosable" tags, then popup stacks
 *  3. Popup stacks until given context
 *
 */

void OnEndTag_1 (unsigned long Mask)
{
	if (CHECK_CONTEXT(CNTX_BODY)) return;
	if ( CHECK_CONTEXT(Mask) && !CHECK_CONTEXT(CNTX_BODY))
	{
		html_pop_Context ();
		html_pop_List ();
	}
}
void OnEndTag_2 (void)
{
	if (CHECK_CONTEXT(CNTX_BODY)) return;

	while ( CHECK_CONTEXT(CNTX_PARA|CNTX_LI|
			      CNTX_FORM_OPTION|
			      CNTX_TABLE_HEAD|
			      CNTX_TABLE_FOOT|
			      CNTX_TABLE_BODY|
			      CNTX_TABLE_ROW|
			      CNTX_TABLE_CELL) &&
                              !CHECK_CONTEXT(CNTX_BODY))
	{
		html_pop_Context ();
		html_pop_List ();
	}
        if(!CHECK_CONTEXT(CNTX_BODY))
        {
		html_pop_Context ();
		html_pop_List ();
        }
}

void OnEndTag_3 (unsigned long Mask)
{
	if (CHECK_CONTEXT(CNTX_BODY)) return;

	while ( !CHECK_CONTEXT(Mask) )
	{
		html_pop_Context ();
		html_pop_List ();
	}
}
void EndParagraph (void)
{
	
	while ( CHECK_CONTEXT(CNTX_PARA) && !CHECK_CONTEXT(CNTX_BODY))
	{
		html_pop_Context ();
		html_pop_List ();
	}
	
}
/*
 *  Insert boolean markup in text flow
 *  Such markups are <B><I><EM> and so on
 */
void SetBOOLMark (FLOW_ELEMENT_FNO Fno,BOOL Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Fno;
	pNew->u.b = Mark;
        list_AddTail(html_cur_Flow(),pNew);
}
/*
 *  Insert boolean markup with attributies in text flow
 *  Such markups are <FONT><Q><LANG>
 */
void SetBOOLAttMark (FLOW_ELEMENT_FNO Fno,BOOL Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Fno;
	pNew->u.font.Bool = Mark;
	pNew->u.font.Attlist = CreateAttlist();
        list_AddTail(html_cur_Flow(),pNew);
}
/*
 *  Insert empty markup
 *  the typical one is <BR>
 */
void SetEmptyMark (FLOW_ELEMENT_FNO Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Mark;
        list_AddTail(html_cur_Flow(),pNew);
}
/*
 *  Insert empty markup with some attributies
 *  The typical ones are <IMG ...> or <TAB ....>
 */
void SetEmptyAttMark (FLOW_ELEMENT_FNO Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Mark;
	pNew->u.img = CreateAttlist();
        list_AddTail (html_cur_Flow(),pNew);
}
/*
 *  Insert common markup with some attributies
 */
void SetCommonMark (char *Name,BOOL Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
        pNew->fno = flow_element_tag;
        pNew->u.tag.Bool = Mark;
        pNew->u.tag.Attlist = CreateAttlist();
        pNew->u.tag.Name = galloc (sizeof(char)*(strlen(Name)+1));
        strcpy (pNew->u.tag.Name,Name);

        list_AddTail (html_cur_Flow(),pNew);
}
/*
 *  Insert the heading element
 */
void SetHeading (int L)
{
	FLOW_ELEMENT *pNew;

	EndParagraph ();

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_heading;
	pNew->u.heading.head_level = L;
	pNew->u.heading.Attlist = CreateAttlist();
	pNew->u.heading.Flow=(FLOW*)list_GCreate();

        list_AddTail (html_cur_Flow(),pNew);

	html_push_Context (CNTX_BLOCK);
	html_push_List (pNew->u.heading.Flow);
}
/*
 *  Insert the Scripting Language (Java|VBS) fragment
 */
void OnNewScript (void)
{
        FLOW_ELEMENT *pNew;

        EndParagraph ();

        pNew = galloc (sizeof(FLOW_ELEMENT));
        pNew->fno = flow_element_script;
        pNew->u.script.Attlist = CreateAttlist ();
        pNew->u.script.txt = galloc (sizeof(char));
	pNew->u.script.txt [0] = '\0';

        list_AddTail(html_cur_Flow(),pNew);
        html_push_Context (CNTX_SCRIPT);
        html_push_List (pNew);
}
/*
 *  Insert the Applet Block as list of Parameters
 */
void OnNewApplet (void)
{
        FLOW_ELEMENT *pNew;

        EndParagraph ();

        pNew = galloc (sizeof(FLOW_ELEMENT));
        pNew->fno = flow_element_applet;
        pNew->u.applet.Attlist = CreateAttlist ();
        pNew->u.applet.Paramlist = (PARAMLIST*)list_GCreate();
	pNew->u.applet.Flow = (FLOW*)list_GCreate();

        list_AddTail (html_cur_Flow(),pNew);
        html_push_Context (CNTX_APPLET);
        html_push_List (pNew->u.applet.Flow);

	pCurFlow=pNew;
}
void OnNewAppletParam (void)
{
        if ( CHECK_CONTEXT(CNTX_APPLET) && (pCurFlow!=NULL) )
        {
                PARAM *pParam = (PARAM*)galloc(sizeof(PARAM));

                pParam->fno=param_param;
                pParam->Attlist = CreateAttlist ();

                list_AddTail ((PLIST)pCurFlow->u.applet.Paramlist,pParam);
        }
}
/*
 *  Framesets, Frames
 */
void OnNewFrameSet (void)
{
        FLOW_ELEMENT *pNew;

        EndParagraph ();

        pNew = galloc (sizeof(FLOW_ELEMENT));
        pNew->fno = flow_element_frameset;
        pNew->u.frameset.Attlist = CreateAttlist ();
        pNew->u.frameset.Framelist = (FRAMELIST*)list_GCreate();
	pNew->u.frameset.Flow = (FLOW*)list_GCreate();

	list_AddTail (html_cur_Flow(),pNew);
        html_push_Context (CNTX_FRAMESET);
        html_push_List (pNew->u.frameset.Flow);

	pCurFlow=pNew;
}
void OnNewFrame (void)
{
        if ( CHECK_CONTEXT(CNTX_FRAMESET) && (pCurFlow!=NULL) )
        {
                FRAME *pFrame = (FRAME*)galloc(sizeof(FRAME));

                pFrame->fno=frame_frame;
                pFrame->Attlist = CreateAttlist ();

                list_AddTail ((PLIST)pCurFlow->u.frameset.Framelist,pFrame);
        }
}
/*
 *  Lists (ordered, unordered)
 */
void OnNewList (FLOW_ELEMENT_FNO ListType)
{
	FLOW_ELEMENT *pNew;

	EndParagraph ();

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = ListType;
	pNew->u.ul.Attlist = CreateAttlist();
	pNew->u.ul.Lh = CreateListHeader ();
	pNew->u.ul.Li_list = (LI_LIST*)list_GCreate ();
        list_AddTail (html_cur_Flow(),pNew);

	html_push_Context (CNTX_LIST);
	html_push_List (pNew);  /* push the pointer to the entire UL/OL */
}

void OnNewLH (void)
{
	FLOW_ELEMENT *pList;
	LH*     pLH;

	if ( CHECK_CONTEXT(CNTX_LIST) )
	{
		pList = (FLOW_ELEMENT*)html_cur_List();

		pLH = pList->u.ul.Lh;
		pLH->fno=lh_lh;
		CopyAttlist(pLH->Attlist);

		html_push_Context (CNTX_LH);
		html_push_List (pLH->Flow);
	}
	else
	{
		yyerror ("Invalid context. List header is not available");
	}
}

LH *CreateListHeader (void)
{
	LH *pLH = (LH*) galloc (sizeof(LH));

	pLH->fno=lh_lh;
	pLH->Attlist = (ATTLIST*)list_GCreate ();
	pLH->Flow = (FLOW*)list_GCreate ();

	return pLH;
}

void OnNewLI (LI_FNO Type)
{
	FLOW_ELEMENT    *pList;
	LI              *pNew;
	LI_LIST         *pLL;

	EndParagraph ();
	if ( CHECK_CONTEXT(CNTX_LIST|CNTX_LI) )
	{

		while ( CHECK_CONTEXT(CNTX_LI) )
		{
			html_pop_Context ();
			html_pop_List ();
		}
		pList = (FLOW_ELEMENT*)html_cur_List();
		pLL = pList->u.ul.Li_list;
		pNew = (LI*) galloc (sizeof(LI));
		pNew->fno=Type;
		pNew->u.li.Attlist = CreateAttlist ();
		pNew->u.li.Flow = (FLOW*)list_GCreate ();

		list_AddTail ((PLIST)pLL,pNew);

		html_push_Context (CNTX_LI);
		html_push_List (pNew->u.li.Flow);
	}
}
/*
 *   Tables
 *   ------
 *   In 4.01 the table specification gets a lot of changes
 *   Now every tables will be parsed into the table4 structure.
 *   the old table structure is kept for compatibility
 */
void OnNewTable (void)
{
	FLOW_ELEMENT *pNew;

	EndParagraph ();

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_table4;
	pNew->u.table4.Attlist = CreateAttlist();
	pNew->u.table4.Caption = (CAPTION*)CreateListHeader();
	pNew->u.table4.Colgroup_list = (COLGROUP_LIST*)list_GCreate();
	pNew->u.table4.Thead_list = (THEAD_LIST*)list_GCreate();
	pNew->u.table4.Tfoot_list = (TFOOT_LIST*)list_GCreate();
	pNew->u.table4.Tbody_list = (TBODY_LIST*)list_GCreate();
	list_AddTail (html_cur_Flow(),pNew);

	html_push_Context (CNTX_TABLE);
	html_push_List (pNew);  /* push the pointer to the entire table */
}
/*
 *  Table caption is allowed only in CNTX_TABLE context
 */
void OnNewCaption (void)
{
	FLOW_ELEMENT    *pList;
	CAPTION         *pCaption;

	if ( CHECK_CONTEXT(CNTX_TABLE) )
	{
		pList = (FLOW_ELEMENT*)html_cur_List();

		pCaption = pList->u.table.Caption;
		pCaption->fno=caption_caption;
		CopyAttlist(pCaption->Attlist);

		html_push_Context (CNTX_CAPTION);
		html_push_List (pCaption->Flow);
	}
}
/*
 *   Assumes that list stack points to the TABLE
 */
void OnNewTableRow (BOOL CopyAttr)
{
	TROW            *pNew;

	EndParagraph ();
	if ( CHECK_CONTEXT(CNTX_TABLE|CNTX_TABLE_ROW|CNTX_TABLE_CELL|CNTX_TABLE_HEAD|CNTX_TABLE_FOOT|CNTX_TABLE_BODY|CNTX_TABLE_COLGROUP) )
	{
		while(CHECK_CONTEXT(CNTX_TABLE_COLGROUP)) html_pop_Context();		/*  Ends the COLGROUP        */
		/*
		 *  Ends previous TR/TD/TH
		 */
		while ( CHECK_CONTEXT(CNTX_TABLE_CELL|CNTX_TABLE_ROW) )
		{
			html_pop_Context ();
			html_pop_List ();
		}
		/*
		 *   Create new table row
		 */
		pNew = (TROW*) galloc (sizeof(TROW));
		pNew->fno=trow_trow;
		if (CopyAttr) pNew->Attlist = CreateAttlist ();
		else pNew->Attlist = (ATTLIST*)list_GCreate ();
		pNew->Cell_list = (CELL_LIST*)list_GCreate ();
		/*
		 *   In CNTX_TABLE create the new TBODY element
		 *   Add new row to the appropriate THEAD/TFOOT/TBODY
		 */
		if(CHECK_CONTEXT(CNTX_TABLE)) OnNewTableBody();
		if(CHECK_CONTEXT(CNTX_TABLE_HEAD|CNTX_TABLE_FOOT|CNTX_TABLE_BODY)) list_AddTail(html_cur_List(),pNew);
		/*
		 *   Let the Cell list to be a current flow pointer
		 */
		html_push_Context (CNTX_TABLE_ROW);
		html_push_List (pNew->Cell_list);
	}
}
/*
 *   Allowed only in CELL or ROW context
 */
void OnNewTableCell (CELL_FNO Type, BOOL CopyAttr)
{
	CELL            *pNew;
	CELL_LIST       *pCL;

	EndParagraph ();
	if ( CHECK_CONTEXT(CNTX_TABLE_CELL|CNTX_TABLE_ROW|CNTX_TABLE_HEAD|CNTX_TABLE_FOOT|CNTX_TABLE_BODY) )
	{
		/*
		 *   Ends the previous cell
		 */
		while ( CHECK_CONTEXT(CNTX_TABLE_CELL) )
		{
			html_pop_Context ();
			html_pop_List ();
		}
		pNew = (CELL*) galloc (sizeof(CELL));
		pNew->fno=Type;
		if (CopyAttr) pNew->u.th.Attlist = CreateAttlist ();
		else pNew->u.th.Attlist = (ATTLIST*)list_GCreate ();
		pNew->u.th.Flow = (FLOW*)list_GCreate ();

		if(!CHECK_CONTEXT(CNTX_TABLE_ROW)) OnNewTableRow(CopyAttr);

		pCL = (CELL_LIST*)html_cur_List();
		list_AddTail ((PLIST)pCL,pNew);

		html_push_Context (CNTX_TABLE_CELL);
		html_push_List (pNew->u.th.Flow);
	}
}
/*
 *   In 4.01 the table specification gets a lot of changes
 *   The new elements introduced are implemented below
 */
/*
 *   COL is empty element allowed only in CTNX_TABLE_COLGROUP or in CNTX_TABLE contexts
 *   In last case the COL goes in the implicit COLGROUP list 
 *   In each cases we assume that the list stack point to the entire table
 */
void OnNewTableCol(void)
{
	COL		*pNew;
			
	if (CHECK_CONTEXT(CNTX_TABLE|CNTX_TABLE_COLGROUP))
	{
		pNew = (COL*) galloc (sizeof(COL));
		pNew->fno = col_col;
		pNew->Attlist = CreateAttlist();
		/*
		 *  Create new COLGROUP if the COLGROUP list is empty
		 */
		if(CHECK_CONTEXT(CNTX_TABLE))
		{
			FLOW_ELEMENT	*pTable;
			pTable = (FLOW_ELEMENT*) html_cur_List();
			if(list_IsEmpty((PLIST)(pTable->u.table4.Colgroup_list))) OnNewTableColGroup();
		}		
		/*
		 *  Then we are in COLGROUP Context and list stack points to the COL list
		 */
		list_AddTail(html_cur_List(),pNew);
	}
}
/*
 *   COLGROUP allowed only in CNTX_TABLE
 *   List stack points to the COL list
 */
void OnNewTableColGroup(void)
{
	if (CHECK_CONTEXT(CNTX_TABLE|CNTX_TABLE_COLGROUP))
	{
		COLGROUP	*pNewCG;
		FLOW_ELEMENT	*pTable;

		while(CHECK_CONTEXT(CNTX_TABLE_COLGROUP))
		{
			html_pop_Context();
			html_pop_List();
		}
		/*
		 *  for the security only
		 */
		pTable = (FLOW_ELEMENT*)html_cur_List();
		if(pTable->fno==flow_element_table4)
		{
			pNewCG = (COLGROUP*) galloc (sizeof(COLGROUP));
			pNewCG->fno = colgroup_colgroup;
			pNewCG->Attlist = CreateAttlist();
			pNewCG->Col_list = (COL_LIST*)list_GCreate();
			list_AddTail((PLIST)(pTable->u.table4.Colgroup_list),pNewCG);
			html_push_Context(CNTX_TABLE_COLGROUP);
			html_push_List(pNewCG->Col_list);
		}
	}
}
/*
 *   THEAD, TFOOT - always pop ups context until TABLE
 */
void OnNewTableHead(void)
{	
	FLOW_ELEMENT	*pTable;
	THEAD	*pNewTH;

	EndParagraph();

	if(CHECK_CONTEXT(CNTX_TABLE|			/*  Allowed in any table contexts */
		         CNTX_TABLE_COLGROUP|
			 CNTX_TABLE_HEAD|
			 CNTX_TABLE_FOOT|
			 CNTX_TABLE_BODY|
			 CNTX_TABLE_ROW|
			 CNTX_TABLE_CELL))
	{
		while(!CHECK_CONTEXT(CNTX_TABLE))				/*  Pops context until TABLE */
		{
			html_pop_Context ();
			html_pop_List ();
		}
		/*
		 *    Make new Table head element
		 */
		pNewTH = (THEAD*) galloc (sizeof(THEAD));
		pNewTH->fno=thead_thead;
		pNewTH->Attlist = CreateAttlist();
		pNewTH->Trow_list = (TROW_LIST*)list_GCreate();
		pTable = (FLOW_ELEMENT*)html_cur_List();
		list_AddTail((PLIST)(pTable->u.table4.Thead_list),pNewTH);
		html_push_Context(CNTX_TABLE_HEAD);
		html_push_List(pNewTH->Trow_list);
	}
}

void OnNewTableFoot(void)
{
	FLOW_ELEMENT	*pTable;
	THEAD	*pNewTF;

	EndParagraph();

	if(CHECK_CONTEXT(CNTX_TABLE|			/*  Allowed in any table contexts */
		         CNTX_TABLE_COLGROUP|
			 CNTX_TABLE_HEAD|
			 CNTX_TABLE_FOOT|
			 CNTX_TABLE_BODY|
			 CNTX_TABLE_ROW|
			 CNTX_TABLE_CELL))
	{
		while(!CHECK_CONTEXT(CNTX_TABLE))				/*  Pops context until TABLE */
		{
			html_pop_Context ();
			html_pop_List ();
		}
		/*
		 *    Make new Table head element
		 */
		pNewTF = (THEAD*) galloc (sizeof(THEAD));
		pNewTF->fno=tfoot_tfoot;
		pNewTF->Attlist = CreateAttlist();
		pNewTF->Trow_list = (TROW_LIST*)list_GCreate();
		pTable = (FLOW_ELEMENT*)html_cur_List();
		list_AddTail((PLIST)(pTable->u.table4.Tfoot_list),pNewTF);
		html_push_Context(CNTX_TABLE_FOOT);
		html_push_List(pNewTF->Trow_list);
	}
}
void OnNewTableBody(void)
{
	FLOW_ELEMENT	*pTable;
	THEAD	*pNewTB;

	EndParagraph();

	if(CHECK_CONTEXT(CNTX_TABLE|			/*  Allowed in any table contexts */
		         CNTX_TABLE_COLGROUP|
			 CNTX_TABLE_HEAD|
			 CNTX_TABLE_FOOT|
			 CNTX_TABLE_BODY|
			 CNTX_TABLE_ROW|
			 CNTX_TABLE_CELL))
	{
		while(!CHECK_CONTEXT(CNTX_TABLE))				/*  Pops context until TABLE */
		{
			html_pop_Context ();
			html_pop_List ();
		}
		/*
		 *    Make new Table head element
		 */
		pNewTB = (THEAD*) galloc (sizeof(THEAD));
		pNewTB->fno=tbody_tbody;
		pNewTB->Attlist = CreateAttlist();
		pNewTB->Trow_list = (TROW_LIST*)list_GCreate();
		pTable = (FLOW_ELEMENT*)html_cur_List();
		list_AddTail((PLIST)(pTable->u.table4.Tbody_list),pNewTB);
		html_push_Context(CNTX_TABLE_BODY);
		html_push_List(pNewTB->Trow_list);
	}
}
/*
 *   Fill out form handling
 */
void OnNewFormTextArea (void)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc(sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_textarea;
	pNew->u.textarea.Attlist = CreateAttlist ();
	pNew->u.textarea.initial = galloc(1*sizeof(char));
	pNew->u.textarea.initial [0] = '\0';
        list_AddTail (html_cur_Flow(),pNew);
	html_push_Context (CNTX_FORM_TEXT);
	html_push_List (pNew);
}

void OnNewFormSelect (void)
{
	FLOW_ELEMENT *pNew;

        EndParagraph ();

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_select;
	pNew->u.select.Attlist = CreateAttlist();
	pNew->u.select.Option_list = (OPTION_LIST*)list_GCreate ();
        list_AddTail (html_cur_Flow(),pNew);

	html_push_Context (CNTX_FORM_LBOX);
	html_push_List (pNew);  /* push the pointer to the entire element */

}
void OnNewFormOption (void)
{
	FLOW_ELEMENT    *pList;
	OPTION          *pNew;
	OPTION_LIST     *pOL;

	EndParagraph ();

	if ( CHECK_CONTEXT(CNTX_FORM_LBOX|CNTX_FORM_OPTION) )
	{
		while ( CHECK_CONTEXT(CNTX_FORM_OPTION) )
		{
			html_pop_Context ();
			html_pop_List ();
		}
		pList = (FLOW_ELEMENT*)html_cur_List();
		pOL = pList->u.select.Option_list;
		pNew = (OPTION*) galloc (sizeof(OPTION));
		pNew->fno=option_option;
		pNew->Attlist = CreateAttlist ();
		pNew->item = galloc (sizeof(char));
		pNew->item [0] = '\0';

		list_AddTail ((PLIST)pOL,pNew);

		html_push_Context (CNTX_FORM_OPTION);
		html_push_List (pNew);
	}
}
/*
 *   Add document's head element
 *   i.e <TITLE><LINK><META> etc.
 */
void AddHeadElement (HEADELEM_FNO Fno)
{
	HEADELEM  *pNew;

	pNew = (HEADELEM*)galloc(sizeof(HEADELEM));
	pNew->fno = Fno;

	switch ( Fno )
	{
		case headelem_style:
			pNew->u.style.Attlist=CreateAttlist();
			pNew->u.style.txt = galloc (sizeof(char));
			pNew->u.style.txt [0] = '\0';
			html_push_Context (CNTX_HEAD_STYLE);
			html_push_List (pNew);
			break;
		case headelem_title:
			pNew->u.title = galloc (sizeof(char));
			pNew->u.title [0] = '\0';
			html_push_Context (CNTX_HEAD_TITLE);
			html_push_List (pNew);
			break;
		default:
			pNew->u.base = CreateAttlist ();
	}
	list_AddTail ((PLIST)pDoc->Head,pNew);
}
/*
 *   Client side image maps
 */
void OnNewMap (void)
{
	FLOW_ELEMENT    *pNew;

	EndParagraph ();

	pNew = (FLOW_ELEMENT*) galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_map;
	pNew->u.map.Attlist = CreateAttlist ();
	pNew->u.map.Area_list = (AREA_LIST*)list_GCreate ();

        list_AddTail (html_cur_Flow(),pNew);

	html_push_Context (CNTX_IMGMAP);
	html_push_List (pNew->u.map.Area_list);
}

void OnNewArea (void)
{
	if ( CHECK_CONTEXT(CNTX_IMGMAP) ) SetEmptyAttMark (area_area);
}
/*
 *   Return current flow
 *   In case of tables and lists add empty cell or list item
 */
void *html_cur_Flow ()
{
        if ( CHECK_CONTEXT(CNTX_TABLE) )
        {
                OnNewTableRow (FALSE);
                OnNewTableCell (cell_td,FALSE);
        }
	if ( CHECK_CONTEXT(CNTX_TABLE_ROW) )
	{
		OnNewTableCell (cell_td,FALSE);
	}
        if ( CHECK_CONTEXT(CNTX_LIST) )
        {
                FLOW_ELEMENT *pList = (FLOW_ELEMENT*)html_cur_List();
		if (pList->fno==flow_element_dl)
			OnNewLI (li_dd);
		else	OnNewLI (li_li);
        }
        return html_cur_List ();
}
/*
 *  InvalidContext
 *
 *   Checks if tag is valid in current context
 */
int InvalidContextBeginTag(int Tag)
{
	//
	//  FORM options, Style, Title requires only plain text (CDATA)
	//  so, any tags will be rejected in those contexts
	//
	if(CHECK_CONTEXT(CNTX_HEAD_STYLE|
			 CNTX_HEAD_TITLE)) return 1;
	//
	//  only option or select close allowed inside FORM option
	//
	if(CHECK_CONTEXT(CNTX_FORM_OPTION) &&
	   !(Tag == tag_OPTION || Tag == tag_SELECT))
		return 1;
	//
	//  only areas are allowed inside image maps
	//
	if(CHECK_CONTEXT(CNTX_IMGMAP) && Tag!=tag_AREA)
		return 1;
	return 0;
}
int InvalidContextEndTag(int Tag)
{
	//
	//  FORM options, Style, Title requires only plain text (CDATA)
	//  so, any tags will be rejected in those contexts
	//
	if(CHECK_CONTEXT(CNTX_HEAD_STYLE|CNTX_HEAD_TITLE)) return 1;
	//
	//  only option or select close allowed inside FORM option
	//
	if(CHECK_CONTEXT(CNTX_FORM_OPTION) &&
	   !(Tag == tag_OPTION || Tag == tag_SELECT))
		return 1;
	//
	//  only map close are allowed inside image maps
	//
	if(CHECK_CONTEXT(CNTX_IMGMAP) && Tag!=tag_MAP)
		return 1;
	return 0;
}
