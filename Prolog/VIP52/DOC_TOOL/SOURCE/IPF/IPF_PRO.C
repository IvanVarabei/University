/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_PRO.C
 Purpose: IPF Parser.  This module is a "code generator" and produces the
	  Prolog term of the domain DOC
	  See: DOCSTR.DOM
 Written by: 
 Comments:
******************************************************************************/

#include "ipf.h"
#include "../common/list.h"
#include "../common/misc.h"
#include "../common/atts.h"
#include "ipf_key.h"
#include "ipf_tag.h"
#include "ipf_pro.h"
#include "ipf_mem.h"

DOC *p_ipf_Doc;         	/* Pointer to document term to be parsed in */
BODY *p_ipf_Body;    	        /* Pointer to document's body               */
static FLOW_ELEMENT *pCurFlow;  /* Pointer to the currently parsed element  */
char *yy_input_string;          /* Points to the input string               */
int yylineno=0;
long yycharno=0L;
BOOL ipf_NLENDEDTAG=0;          /* Indicate the tag to be enclosed by NL    */
BOOL ipf_CGRAPHIC=0;            /* Indicate the CGARPHIC mode               */
BOOL ipf_NOBLANC=0;             /* Don't separate tokens                    */
int ipf_CurTag = 0;             /* Store current tag for above...           */
ATTLIST *ipf_CurArtwork=NULL;	/* Store the pointer for artlink map ref    */
int ipf_CurImgMap = 0;		/* Current image map number                 */
/*
 *  Local functions
 */
static void OnNewBlock (FLOW_ELEMENT_FNO Mark,unsigned long NewCntx);
static void OnNewLink (void);
static void OnNewNote (char *Class, unsigned long NewCntx);
static void OnEndTag_1 (unsigned long);
static void OnEndTag_2 (void);
static void OnEndTag_3 (unsigned long);
static void EndParagraph (void);
static void OnNewList (FLOW_ELEMENT_FNO ListType,BOOL SubClass, char *Class);
static void OnNewLI (LI_FNO ListType, BOOL HD);
static void MakeListSimple (void);
static LH *CreateListHeader (void);
static void SetEmptyMark (FLOW_ELEMENT_FNO Mark);
static void SetBOOLMark (FLOW_ELEMENT_FNO Fno,BOOL Mark);
static void SetBOOLAttMark (FLOW_ELEMENT_FNO Fno, BOOL Mark);
static void SetFontMark (void);
static void ipf_SetHeading (int L);
static void ipf_AddDocTitle (void);
static void SetCommonMark (char *Name,BOOL Mark);
static void OnNewTable (void);
static void OnNewTableRow (void);
static void OnNewTableCell (void);
static void OnNewArtwork (void);
static void OnNewArtlink (void);
static void OnNewArea (void);
static void *ipf_cur_Flow (void);
/*
 * ipf_term () - the core predicate
 *           1.  (i,o)  calls yyparse ()
 *                      returns the term of DOC domain
 *           2.  (o,i)  constructs the IPF document from the
 *                      term of DOC domain
 *           3.  (i,i)  unify the IPF document and the term
 *
 *           The first flow pattern is implemented in C
 *           The second and third ones are implemented in
 *           Prolog and calls the appropriate internal
 *           predicates
 */
/*
 * (i,o)
 */
void ipf_term_0 (char *Str,DOC **ppDoc)
{

	HEADELEM *pHE;

	InitIPFParser ();
	
	yylineno=1;
	yycharno=1L;

	yy_input_string = Str;

	p_ipf_Doc = galloc (sizeof(DOC));
	p_ipf_Body = galloc (sizeof(BODY));
	/*
	 *  Initialize pDoc with null values
	 */
	p_ipf_Doc->fno = doc_doc;
	p_ipf_Doc->Doctype=galloc(sizeof(char));
	p_ipf_Doc->Doctype[0]='\0';

	p_ipf_Doc->Head=(HEAD*)list_GCreate();
	p_ipf_Doc->Body=p_ipf_Body;
	//
	//  Apply IPF meta information
	//
	pHE = (HEADELEM*)galloc(sizeof(HEADELEM));
	pHE->fno = headelem_meta;
	pHE->u.meta = (ATTLIST*) list_GCreate();
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("NAME",attval_lit,"SOURCE",0));
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("CONTENT",attval_lit,"IPF",0));
	list_AddTail((PLIST)p_ipf_Doc->Head,pHE);
	
	pHE = (HEADELEM*)galloc(sizeof(HEADELEM));
	pHE->fno = headelem_meta;
	pHE->u.meta = (ATTLIST*) list_GCreate();
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("NAME",attval_lit,"UNITS",0));
	list_AddTail((PLIST)pHE->u.meta,
		CreateAttribute ("CONTENT",attval_lit,"CHAR",0));
	list_AddTail((PLIST)p_ipf_Doc->Head,pHE);

	p_ipf_Body->fno = body_body;
	p_ipf_Body->Attlist=(ATTLIST*)list_GCreate();
	p_ipf_Body->Flow = (FLOW*) list_GCreate();

	ipf_push_Context (CNTX_BODY);		/* The first body context    */
	ipf_push_List (p_ipf_Body->Flow);	/* The body element list ptr */

	yyparse ();

	*ppDoc = p_ipf_Doc;
	CloseIPFParser ();
}
/*
**  ipf_ProcessTag () - the main tag processor
*/
void ipf_ProcessTag (void)
{
	int Key = ipf_GetTagValue (ipf_cur_Tag.tag_Name);

	switch (Key)
	{
		/*
                 *   Text flow blocks
		 */
		case tag_P:     OnNewBlock (flow_element_par,CNTX_PARA); break;
                case tag_LP:    OnNewBlock (flow_element_par,CNTX_PARA); break;
		case tag_FN:	OnNewBlock (flow_element_fn,CNTX_BLOCK); break;
                case tag_CAUTION: OnNewNote ("CAUTION",CNTX_BLOCK); break;
                case tag_WARNING: OnNewNote ("WARNING",CNTX_BLOCK); break;
                case tag_NT:    OnNewNote ("NOTE",CNTX_BLOCK); break;
                case tag_NOTE:	OnNewNote ("NOTE",CNTX_PARA); break;
                case tag_LINK:  
                        if (CHECK_CONTEXT(CNTX_ARTLINK))
                        	OnNewArea ();
                        else 	OnNewLink (); break;
		/*
		 *   Lists (ordered, unordered, definitions)
		 */
		case tag_OL: OnNewList (flow_element_ol,FALSE,""); break;
		case tag_UL: OnNewList (flow_element_ul,FALSE,""); break;
                case tag_PARML: OnNewList (flow_element_dl,TRUE,"parml");break;
                case tag_DL: OnNewList (flow_element_dl,FALSE,""); break;
                case tag_SL: OnNewList (flow_element_ul,TRUE,"simple");break;
                case tag_LI: OnNewLI (li_li,FALSE); break;
                case tag_PD:
                case tag_DD: OnNewLI (li_dd,FALSE); break;
                case tag_DDHD: OnNewLI (li_dd,TRUE); break;
                case tag_PT:
                case tag_DT: OnNewLI (li_dt,FALSE); break;
                case tag_DTHD: OnNewLI (li_dt,TRUE); break;
                /*
                 *   Phrase highlighting
                 */
                case tag_HP1: SetBOOLMark (flow_element_i,TRUE);break;
                case tag_HP2: SetBOOLMark (flow_element_b,TRUE);break;
                case tag_HP3: SetBOOLMark (flow_element_i,TRUE);
                              SetBOOLMark (flow_element_b,TRUE);break;
                //case tag_HP4: SetBOOLMark (,TRUE);break;// blue
                case tag_HP5: SetBOOLMark (flow_element_u,TRUE);break;
                case tag_HP6: SetBOOLMark (flow_element_i,TRUE);
                              SetBOOLMark (flow_element_u,TRUE);break;
                case tag_HP7: SetBOOLMark (flow_element_b,TRUE);
                              SetBOOLMark (flow_element_u,TRUE);break;
                //case tag_HP8: SetBOOLMark (,TRUE);break;// red
                //case tag_HP9: SetBOOLMark (,TRUE);break;// magenta
                /*
                 *   Font markups
                 */
                case tag_FIG:
		case tag_XMP:
		case tag_LINES:
                case tag_CGRAPHIC:
			ipf_CGRAPHIC = TRUE;
                        OnNewBlock (flow_element_preformatted,CNTX_BLOCK);
                        break;
                case tag_FONT:  SetFontMark (); break;
                /*
		 *   Headings (up to 6 levels)
		 */
                case tag_H1: ipf_CurTag = Key;ipf_SetHeading (1); break;
                case tag_H2: ipf_CurTag = Key;ipf_SetHeading (2); break;
                case tag_H3: ipf_CurTag = Key;ipf_SetHeading (3); break;
                case tag_H4: ipf_CurTag = Key;ipf_SetHeading (4); break;
                case tag_H5: ipf_CurTag = Key;ipf_SetHeading (5); break;
                case tag_H6: ipf_CurTag = Key;ipf_SetHeading (6); break;
		/*
		 *   Tables
		 */
		case tag_TABLE:	OnNewTable (); break;
		case tag_ROW:	OnNewTableRow (); break;
		case tag_CELL:	OnNewTableCell (); break;
                /*
                 *   Artworks and Artlinks
                 */
                case tag_ARTWORK:OnNewArtwork (); break;
                case tag_ARTLINK:OnNewArtlink (); break;
                /*
                 *   Other tags (unsupported by DOC_TOOL)
                 */
                case tag_TITLE: ipf_CurTag = Key;ipf_AddDocTitle (); break;
		case tag_LM:
		case tag_RM:
		case tag_I1:
		case tag_I2:
		case tag_ICMD:
		case tag_ISYN:
                case tag_COLOR:
                case tag_CTRL:
                case tag_CTRLDEF:
                case tag_DDF:
                case tag_DOCPROF:
                case tag_HIDE:
                case tag_PBUTTON:
        	case tag_Common:SetCommonMark (ipf_cur_Tag.tag_Name,TRUE); break;


	}
}

void ipf_CloseTag (char *Tag)
{
	int     Key;
	char    UName[NAMELEN];

        if ( strcmp (Tag,"NLEND")==0 ) Key = ipf_CurTag;
        else
        {
                strcpy_tolower(UName,Tag);
                Key = ipf_GetTagValue(UName);
        }

	switch ( Key )
	{
                case tag_H1     :
		case tag_H2     :
		case tag_H3     :
		case tag_H4     :
		case tag_H5     :
		case tag_H6     :
                case tag_UL     :
		case tag_OL     :
		case tag_DL     :
                case tag_SL     :
                case tag_TABLE  : OnEndTag_2 (); break;
                case tag_LINK   :
                case tag_CAUTION:
                case tag_WARNING:
		case tag_FN	:
                case tag_NT	: OnEndTag_1 (CNTX_BLOCK); break;
                case tag_ROW    : OnEndTag_1 (CNTX_TABLE_ROW); break;
		case tag_CELL   : OnEndTag_1 (CNTX_TABLE_CELL);break;

                /*
                 *   Phrase highlighting
                 */
                case tag_HP1: SetBOOLMark (flow_element_i,FALSE);break;
                case tag_HP2: SetBOOLMark (flow_element_b,FALSE);break;
                case tag_HP3: SetBOOLMark (flow_element_b,FALSE);
                              SetBOOLMark (flow_element_i,FALSE);break;
                //case tag_HP4: SetBOOLMark (,TRUE);break;// blue
                case tag_HP5: SetBOOLMark (flow_element_u,FALSE);break;
                case tag_HP6: SetBOOLMark (flow_element_u,FALSE);
                              SetBOOLMark (flow_element_i,FALSE);break;
                case tag_HP7: SetBOOLMark (flow_element_u,FALSE);
                              SetBOOLMark (flow_element_b,FALSE);break;
                //case tag_HP8: SetBOOLMark (,TRUE);break;// red
                //case tag_HP9: SetBOOLMark (,TRUE);break;// magenta
                case tag_TITLE  : OnEndTag_3 (CNTX_BODY); break;
		/*
		 *  Artlink
		 */
		case tag_ARTLINK:
			OnEndTag_1 (CNTX_ARTLINK);
			ipf_CurArtwork=NULL;
			break;
                /*
                 *  Font markups
                 */
                case tag_FIG:
		case tag_LINES:
		case tag_XMP:
                case tag_CGRAPHIC:
			ipf_CGRAPHIC = FALSE;
                        OnEndTag_1 (CNTX_BLOCK);
			break;
                case tag_CTRLDEF:
                case tag_HIDE:
        	case tag_Common:SetCommonMark (ipf_cur_Tag.tag_Name,FALSE); break;

        }
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
	while ( CHECK_CONTEXT(Mask) )
	{
                ipf_pop_Context ();
                ipf_pop_List ();
	}
}
void OnEndTag_2 (void)
{
	if (CHECK_CONTEXT(CNTX_BODY)) return;

	while ( CHECK_CONTEXT(CNTX_PARA|CNTX_LI|
			      CNTX_TABLE_ROW|
			      CNTX_TABLE_CELL) )
	{
                ipf_pop_Context ();
                ipf_pop_List ();
	}
        ipf_pop_Context ();
        ipf_pop_List ();
}
void OnEndTag_3 (unsigned long Mask)
{
	if (CHECK_CONTEXT(CNTX_BODY)) return;

	while ( !CHECK_CONTEXT(Mask) )
	{
                ipf_pop_Context ();
                ipf_pop_List ();
	}
}

/*
 *  Popup context if the current context is paragraph
 */
void EndParagraph (void)
{
        while ( CHECK_CONTEXT(CNTX_PARA) )
	{
		ipf_pop_Context ();
		ipf_pop_List ();
	}
}

/*
 *  Insert new text block
 */
void OnNewBlock (FLOW_ELEMENT_FNO Mark,unsigned long NewCntx)
{
	FLOW_ELEMENT    *pNew;          /* new flow element */

        EndParagraph ();
	/*
	 *   Construct new text block (paragraph)
	 */
	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Mark;
	pNew->u.par.Attlist = ipf_CreateAttlist();
	pNew->u.par.Flow = (FLOW*)list_GCreate ();
	
        list_AddTail (ipf_cur_Flow(),pNew);
	/*
	 *   Add new block to the current list tail
	 *   Push appropriate context
	 *   Set the current flow list
	 */                       
	ipf_push_Context (NewCntx);
	ipf_push_List (pNew->u.par.Flow);
}
/*
 *  Insert hypertext link block. Rename the refid= attribute to href=
 */
void OnNewLink (void)
{
	FLOW_ELEMENT    *pNew;          /* new flow element */
        ATT     *pAtt;
	int     i;
        char	Str[80];
        BOOL	InformLink = FALSE;
	BOOL	hasHref = FALSE;

	EndParagraph ();
	/*
	 *   Construct new text block (paragraph)
	 */
        pNew = galloc (sizeof(FLOW_ELEMENT));
        pNew->fno = flow_element_a;
	pNew->u.a.Attlist = (ATTLIST*)list_GCreate();
        /*
         *  Copy attributies (possible rename it)
         */
	for ( i=0; i < ipf_cur_Tag.tag_AttCount; i++ )
	{
		if (!hasHref &&
			strcmp(ipf_cur_Tag.tag_AttArray[i].Name,"refid")==0)
                {
                        hasHref=TRUE;
			if (ipf_cur_Tag.tag_AttArray[i].Val->fno==attval_num)
                        {
                        	sprintf (Str,"#%d",ipf_cur_Tag.tag_AttArray[i].Val->u.num);
                        }
                        else
                        {
                        	sprintf (Str,"#%s",ipf_cur_Tag.tag_AttArray[i].Val->u.lit);
                        }
                        pAtt=CreateAttribute("href",attval_lit,Str,0);
                }
		else if (!hasHref &&
			strcmp(ipf_cur_Tag.tag_AttArray[i].Name,"res")==0)
                {
                        hasHref=TRUE;
			if (ipf_cur_Tag.tag_AttArray[i].Val->fno==attval_num)
                        {
                        	sprintf (Str,"#%d",ipf_cur_Tag.tag_AttArray[i].Val->u.num);
                        }
                        else
                        {
                        	sprintf (Str,"#%s",ipf_cur_Tag.tag_AttArray[i].Val->u.lit);
                        }
                        pAtt=CreateAttribute("href",attval_lit,Str,0);
                }
                else
                {
			pAtt = (ATT*)galloc(sizeof(ATT));
			pAtt->fno = att_att;
                	pAtt->Name = ipf_cur_Tag.tag_AttArray[i].Name;
			pAtt->Val  = ipf_cur_Tag.tag_AttArray[i].Val;
               	}

                if ((strcmp(ipf_cur_Tag.tag_AttArray[i].Name,"retype")==0) &&
                    (strcmp(ipf_cur_Tag.tag_AttArray[i].Val->u.lit,"inform")==0))
                     InformLink = TRUE;
                else InformLink = FALSE;


		list_AddTail ((PLIST)pNew->u.a.Attlist,pAtt);
	}

        pNew->u.a.Flow = (FLOW*)list_GCreate ();
	list_AddTail (ipf_cur_Flow(),pNew);
	/*
	 *   Add new block to the current list tail
	 *   Push appropriate context
	 *   Set the current flow list
         *
         *   But if this is inform link then don't change context
	 */
	if (InformLink)
        {
        	ipf_push_Context (CNTX_BLOCK);
		ipf_push_List (pNew->u.a.Flow);
	}
}

/*
 *  Insert admonishment like NOTE, WARNING or CAUTION
 */
void OnNewNote (char *Class, unsigned long Cntx)
{
        FLOW_ELEMENT    *pNew;          /* new flow element */

	EndParagraph ();
	/*
	 *   Construct new text block (paragraph)
	 */
	pNew = galloc (sizeof(FLOW_ELEMENT));
        pNew->fno = flow_element_note;
        pNew->u.note.Attlist = ipf_CreateAttlist();
        pNew->u.note.Flow = (FLOW*)list_GCreate ();
        list_AddTail ((PLIST)pNew->u.note.Attlist,
                CreateAttribute("CLASS",attval_atom,Class,0));
	list_AddTail (ipf_cur_Flow(),pNew);
	/*
	 *   Add new block to the current list tail
	 *   Push appropriate context
	 *   Set the current flow list
	 */
        ipf_push_Context (Cntx);   
	ipf_push_List (pNew->u.par.Flow);
}
/*
 *  Lists (ordered, unordered)
 */
void OnNewList (FLOW_ELEMENT_FNO ListType, BOOL SubClass, char *Class)
{
	FLOW_ELEMENT *pNew;

	EndParagraph ();

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = ListType;
        pNew->u.ul.Attlist = ipf_CreateAttlist();
	pNew->u.ul.Lh = CreateListHeader ();
	pNew->u.ul.Li_list = (LI_LIST*)list_GCreate ();
	if ( SubClass )
	{
		list_AddTail ((PLIST)pNew->u.ul.Attlist,
			CreateAttribute("class",attval_lit,Class,0));
	}
        list_AddTail (ipf_cur_Flow(),pNew);

        ipf_push_Context (CNTX_LIST);
        ipf_push_List (pNew);  /* push the pointer to the entire UL/OL */
}


LH *CreateListHeader (void)
{
	LH *pLH = (LH*) galloc (sizeof(LH));

	pLH->fno=lh_lh;
	pLH->Attlist = (ATTLIST*)list_GCreate ();
	pLH->Flow = (FLOW*)list_GCreate ();

	return pLH;
}

void OnNewLI (LI_FNO Type, BOOL HD)
{
	FLOW_ELEMENT    *pList;
	LI              *pNew;
	LI_LIST         *pLL;

	EndParagraph ();

        if ( CHECK_CONTEXT(CNTX_LIST|CNTX_LI) )
	{

		while ( CHECK_CONTEXT(CNTX_LI) )
		{
                        ipf_pop_Context ();
                        ipf_pop_List ();
		}
                pList = (FLOW_ELEMENT*)ipf_cur_List();
		pLL = pList->u.ul.Li_list;
		pNew = (LI*) galloc (sizeof(LI));
		pNew->fno=Type;
                pNew->u.li.Attlist = ipf_CreateAttlist ();
                if ( HD )
                {
                        list_AddTail ((PLIST)pNew->u.li.Attlist,
                                CreateAttribute ("class",attval_lit,"hd",0));
                }
		pNew->u.li.Flow = (FLOW*)list_GCreate ();

		list_AddTail ((PLIST)pLL,pNew);

                ipf_push_Context (CNTX_LI);
                ipf_push_List (pNew->u.li.Flow);
	}
}
/*
 *  Insert empty markup
 *  the typical one is .br
 */
void SetEmptyMark (FLOW_ELEMENT_FNO Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Mark;
	list_AddTail(ipf_cur_Flow(),pNew);
}
/*
 *  Insert boolean markup in text flow
 *  Such markups are :hp1. and so on
 */
void SetBOOLMark (FLOW_ELEMENT_FNO Fno,BOOL Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Fno;
	pNew->u.b = Mark;
        list_AddTail(ipf_cur_Flow(),pNew);
}
/*
 *  Insert boolean markup with attributies in text flow
 */
void SetBOOLAttMark (FLOW_ELEMENT_FNO Fno,BOOL Mark)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = Fno;
	pNew->u.font.Bool = Mark;
	pNew->u.font.Attlist = ipf_CreateAttlist();
	list_AddTail(ipf_cur_Flow(),pNew);
}
/*
 *  Insert font markup with attributies in text flow
 *  IPF uses an absolute font size values, so add appropriate
 *  attribute at the list tail.
 */
void SetFontMark (void)
{
	FLOW_ELEMENT    *pNew;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_font;
	pNew->u.font.Bool = TRUE;
	pNew->u.font.Attlist = ipf_CreateAttlist();
	list_AddTail((PLIST)pNew->u.font.Attlist,
		CreateAttribute ("ABSOLUTE",attval_nill,"",0));
	list_AddTail(ipf_cur_Flow(),pNew);
}

/*
 *  Insert the heading element
 *  IPF headings continue up to the next NL
 *  and pops the current context up to plain body one
 */
void ipf_SetHeading (int L)
{
	FLOW_ELEMENT *pNew;


        while (!CHECK_CONTEXT(CNTX_BODY))
        {
        	ipf_pop_List ();
                ipf_pop_Context ();
        }

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_heading;
	pNew->u.heading.head_level = L;
	pNew->u.heading.Attlist = ipf_CreateAttlist();
	pNew->u.heading.Flow=(FLOW*)list_GCreate();

	list_AddTail (ipf_cur_List(),pNew);

	ipf_push_Context (CNTX_BLOCK);
	ipf_push_List (pNew->u.heading.Flow);
        ipf_NLENDEDTAG = TRUE;
}
/*
 *  Makes the document title
 */
void ipf_AddDocTitle (void)
{
        HEADELEM  *pNew;

	pNew = (HEADELEM*)galloc(sizeof(HEADELEM));
	pNew->fno = headelem_title;

        pNew->u.title = galloc (sizeof(char));
        pNew->u.title [0] = '\0';
        ipf_push_Context (CNTX_HEAD_TITLE);
        ipf_push_List (pNew);

        list_AddTail ((PLIST)p_ipf_Doc->Head,pNew);
        ipf_NLENDEDTAG = TRUE;
}
/*
 *  Add line break
 */
void ipf_AddLineBreak (void)
{
        SetEmptyMark (flow_element_br);
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
        pNew->u.tag.Attlist = ipf_CreateAttlist();
        pNew->u.tag.Name = galloc (sizeof(char)*(strlen(Name)+1));
        strcpy (pNew->u.tag.Name,Name);

	list_AddTail (ipf_cur_Flow(),pNew);
}
/*
 *   Tables
 */
void OnNewTable (void)
{
	FLOW_ELEMENT *pNew;

	EndParagraph ();

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_table;
	pNew->u.table.Attlist = ipf_CreateAttlist();
	pNew->u.table.Caption = (CAPTION*)CreateListHeader ();
	pNew->u.table.Trow_list = (TROW_LIST*)list_GCreate ();
	list_AddTail (ipf_cur_Flow(),pNew);

	ipf_push_Context (CNTX_TABLE);
	ipf_push_List (pNew);  /* push the pointer to the entire table */
}


void OnNewTableRow (void)
{
	FLOW_ELEMENT    *pList;
	TROW            *pNew;
	TROW_LIST       *pTrowL;

	EndParagraph ();
	if ( CHECK_CONTEXT(CNTX_TABLE|CNTX_TABLE_ROW|CNTX_TABLE_CELL) )
	{
		/*
		 *  Ends previous cell
		 */
		while ( CHECK_CONTEXT(CNTX_TABLE_CELL|CNTX_TABLE_ROW) )
		{
			ipf_pop_Context ();
			ipf_pop_List ();
		}
		pList = (FLOW_ELEMENT*)ipf_cur_List();
		pTrowL = pList->u.table.Trow_list;
		pNew = (TROW*) galloc (sizeof(TROW));
		pNew->fno=trow_trow;
		pNew->Attlist = ipf_CreateAttlist ();
		pNew->Cell_list = (CELL_LIST*)list_GCreate ();

		list_AddTail ((PLIST)pTrowL,pNew);

		ipf_push_Context (CNTX_TABLE_ROW);
		ipf_push_List (pNew->Cell_list);
	}
}

void OnNewTableCell (void)
{
	CELL            *pNew;
	CELL_LIST       *pCL;

	EndParagraph ();
	if ( CHECK_CONTEXT(CNTX_TABLE_CELL|CNTX_TABLE_ROW) )
	{
		/*
		 *   Ends the previous cell
		 */
		while ( CHECK_CONTEXT(CNTX_TABLE_CELL) )
		{
			ipf_pop_Context ();
			ipf_pop_List ();
		}
		pCL = (CELL_LIST*)ipf_cur_List();
		pNew = (CELL*) galloc (sizeof(CELL));
		pNew->fno=cell_td;
		pNew->u.td.Attlist = ipf_CreateAttlist ();
		pNew->u.td.Flow = (FLOW*)list_GCreate ();

		list_AddTail ((PLIST)pCL,pNew);

		ipf_push_Context (CNTX_TABLE_CELL);
		ipf_push_List (pNew->u.td.Flow);
	}
}
/*
 *  Artwork and Artlink handling
 *
 *  Rename the 'name' attribute to 'src' one
 *  Sets the pointer to the current artwork attlist
 *  for the following artlink
 */
void OnNewArtwork (void)
{
	FLOW_ELEMENT    *pNew;
        char		Str[80];
	int		i;
        ATT		*pAtt;

	pNew = galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_img;           
        pNew->u.img = (ATTLIST*)list_GCreate();
	/*
         *  Copy attributies (possible rename it)
         */
	for ( i=0; i < ipf_cur_Tag.tag_AttCount; i++ )
	{
		if (strcmp(ipf_cur_Tag.tag_AttArray[i].Name,"name")==0)
                {
                        if (ipf_cur_Tag.tag_AttArray[i].Val->fno==attval_num)
                        {
                        	sprintf (Str,"%d",ipf_cur_Tag.tag_AttArray[i].Val->u.num);
                        }
                        else
                        {
                        	sprintf (Str,"%s",ipf_cur_Tag.tag_AttArray[i].Val->u.lit);
                        }
                        pAtt=CreateAttribute("src",attval_lit,Str,0);
                }
                else
                {
			pAtt = (ATT*)galloc(sizeof(ATT));
			pAtt->fno = att_att;
                	pAtt->Name = ipf_cur_Tag.tag_AttArray[i].Name;
			pAtt->Val  = ipf_cur_Tag.tag_AttArray[i].Val;
               	}
		list_AddTail ((PLIST)pNew->u.img,pAtt);
	}	
        
        list_AddTail (ipf_cur_Flow(),pNew);
	ipf_CurArtwork = pNew->u.img;
}
void OnNewArtlink (void)
{
	FLOW_ELEMENT    *pNew;    
        char		Str[80];

	EndParagraph ();

	pNew = (FLOW_ELEMENT*) galloc (sizeof(FLOW_ELEMENT));
	pNew->fno = flow_element_map;
	pNew->u.map.Attlist = ipf_CreateAttlist ();
	pNew->u.map.Area_list = (AREA_LIST*)list_GCreate ();
        
	ipf_CurImgMap++;
        sprintf (Str,"img_map_%d",ipf_CurImgMap);
        list_AddTail((PLIST)pNew->u.map.Attlist,
        		CreateAttribute("name",attval_lit,Str,0));
        if (ipf_CurArtwork!=NULL)
        {
        	sprintf (Str,"#img_map_%d",ipf_CurImgMap);
                list_AddTail((PLIST)ipf_CurArtwork,
                	CreateAttribute("usemap",attval_lit,Str,0));
        }

	list_AddTail (ipf_cur_Flow(),pNew);
        
	ipf_push_Context (CNTX_ARTLINK);
	ipf_push_List (pNew->u.map.Area_list);
}
/*
 *   Insert image map area
 */
void OnNewArea (void)
{
	AREA    *pNew;          /* new area */
        ATT     *pAtt;
	int     i;
        char	Str[80];
	BOOL	hasHref = FALSE;

	EndParagraph ();
	/*
	 *   Construct new text block (paragraph)
	 */
        pNew = galloc (sizeof(AREA));
        pNew->fno = area_area;
	pNew->Attlist = (ATTLIST*)list_GCreate();
        /*
         *  Copy attributies (possible rename it)
         */
	for ( i=0; i < ipf_cur_Tag.tag_AttCount; i++ )
	{
		if (!hasHref &&
			strcmp(ipf_cur_Tag.tag_AttArray[i].Name,"refid")==0)
                {
                        hasHref=TRUE;
			if (ipf_cur_Tag.tag_AttArray[i].Val->fno==attval_num)
                        {
                        	sprintf (Str,"#%d",ipf_cur_Tag.tag_AttArray[i].Val->u.num);
                        }
                        else
                        {
                        	sprintf (Str,"#%s",ipf_cur_Tag.tag_AttArray[i].Val->u.lit);
                        }
                        pAtt=CreateAttribute("href",attval_lit,Str,0);
                }
		else if (!hasHref &&
			strcmp(ipf_cur_Tag.tag_AttArray[i].Name,"res")==0)
                {
                        hasHref=TRUE;
			if (ipf_cur_Tag.tag_AttArray[i].Val->fno==attval_num)
                        {
                        	sprintf (Str,"#%d",ipf_cur_Tag.tag_AttArray[i].Val->u.num);
                        }
                        else
                        {
                        	sprintf (Str,"#%s",ipf_cur_Tag.tag_AttArray[i].Val->u.lit);
                        }
                        pAtt=CreateAttribute("href",attval_lit,Str,0);
                }
                else
                {
			pAtt = (ATT*)galloc(sizeof(ATT));
			pAtt->fno = att_att;
                	pAtt->Name = ipf_cur_Tag.tag_AttArray[i].Name;
			pAtt->Val  = ipf_cur_Tag.tag_AttArray[i].Val;
               	}
		list_AddTail ((PLIST)pNew->Attlist,pAtt);
	}
	list_AddTail (ipf_cur_Flow(),pNew);
}	
/*
 *   Return current flow
 *   In case of tables and lists add empty cell or list item
 */
void *ipf_cur_Flow ()
{
        if ( CHECK_CONTEXT(CNTX_TABLE) )
        {
                OnNewTableRow ();
                OnNewTableCell ();
        }
	if ( CHECK_CONTEXT(CNTX_TABLE_ROW) )
	{
		OnNewTableCell ();
	}
        if ( CHECK_CONTEXT(CNTX_LIST) )
        {
                FLOW_ELEMENT *pList = (FLOW_ELEMENT*)ipf_cur_List();
		if (pList->fno==flow_element_dl)
			OnNewLI (li_dd,FALSE);
		else	OnNewLI (li_li,FALSE);
        }
        return ipf_cur_List ();
}
