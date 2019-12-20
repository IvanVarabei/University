/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_TAG.C
 Purpose: HTML Parser. Tag Handling
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "html.h"

#ifndef __PROLOG__
#include <ctype.h>
#include <malloc.h>
#include <string.h>
#endif

#include "html_tag.h"
#include "html_key.h"
#include "html_mem.h"
#include "html_pro.h"
#include "../common/list.h"
#include "../common/misc.h"
#include "../common/atts.h"

int isInline(int F);

TAG     cur_Tag;        /* Current parsed tag   */

/*
 *   Clears the current tag
 *
 *   In Prolog programs all the attributies are allocated
 *   at the global stack, so we don't need to free
 *   their memory manualy
 *
 */
void ClearTag (void)
{
    #ifndef __PROLOG__

    	int i;

	for (i=0;i<cur_Tag.tag_AttCount;i++)
	{
		ClearAttVal (cur_Tag.tag_AttArray[i].Val);
	 	free(cur_Tag.tag_AttArray[i].Name);
	}
    #endif
	cur_Tag.tag_Name[0]='\0';
	cur_Tag.tag_AttCount=(-1);
}

#ifndef __PROLOG__
/*
 *  Frees tag attribute value
 */
void ClearAttVal (ATTVAL *pVal)
{
	switch ( pVal->fno )
	{
		case attval_lit :
			free (pVal->u.lit);
			break;
		case attval_atom:
			free (pVal->u.atom);
			break;
	}
	free (pVal);
}
#endif

/*
 *  Adds the next attribute to the tag's attribute list
 *  If it is the 'empty' tag then it is the tag
 *  itself.
 */
void AddAttribute (char *Name,char Type,char *Str,int Num)
{
	int i = cur_Tag.tag_AttCount;
	ATTVAL *pVal;

	if (i==-1)
	{
		strcpy_toupper(cur_Tag.tag_Name,Name);
	}
	else
	{
		cur_Tag.tag_AttArray[i].Name = galloc(strlen(Name)+1);
		strcpy_toupper(cur_Tag.tag_AttArray[i].Name,Name);
		switch ( Type )
		{
			case attval_nill:
				pVal=CreateNillAttVal ();
				break;
			case attval_atom:
				pVal=CreateAtomAttVal(Str);
				break;
			case attval_lit :
				pVal=CreateLitAttVal(Str);
				break;
			case attval_num :
				pVal=CreateNumAttVal(Num);
				break;
		}
		cur_Tag.tag_AttArray[i].Val = pVal;
	}
	cur_Tag.tag_AttCount=i+1;
}

/*
 *  BeginTag() - the current tag is parsed
 *               process it
 */
void BeginTag (void)
{
	ProcessTag ();
	ClearTag ();
}

/*
 *  EndTag () - ends the named tag
 */
void EndTag (char *Name)
{
	CloseTag (Name);
	ClearTag ();
}

/*
 *  AddDocProlog () - adds document prolog
 *                    now ignored
 */
void AddDocProlog (char *Prolog)
{
	char *pBuff;

	pBuff = galloc((strlen(Prolog)+
			strlen(pDoc->Doctype)+2)*
			sizeof(char));
	sprintf (pBuff,"%s%s",pDoc->Doctype,Prolog);
	pDoc->Doctype=pBuff;
}

void AddWhiteSpace (void)
{
	FLOW_ELEMENT    *pFlow;
	FLOW_ELEMENT	*pTail;
	STRING		pBuff;
	
	if ( CHECK_CONTEXT(CNTX_TEXT|CNTX_PARA|CNTX_BLOCK|
	  		   CNTX_LH|CNTX_LI|CNTX_CAPTION|CNTX_TABLE_CELL|
			   CNTX_FORM|CNTX_BODY) )
	{
		pTail = (FLOW_ELEMENT*)list_GetTail(html_cur_List());
		if (pTail && isInline(pTail->fno))
		{
			pFlow = galloc (sizeof(FLOW_ELEMENT));
			pFlow->fno = flow_element_txt;
			pFlow->u.txt = galloc (2*sizeof(char));
			strcpy (pFlow->u.txt," ");
			list_AddTail (html_cur_List(),pFlow);
		}
		if (pTail && pTail->fno == flow_element_txt)
		{
			pBuff = galloc ((strlen(pTail->u.txt)+2)*
				 	sizeof(char));
			sprintf (pBuff,"%s ",pTail->u.txt);
			pTail->u.txt = pBuff;
		}
	}
}			
	
void AddPlainText (char *Str)
{
	FLOW_ELEMENT    *pFlow;
	FLOW_ELEMENT	*pTail;
	STRING		pBuff;
	OPTION		*pOpt;

	/*
	 *   Most of text flow elements
	 *
	 *   If the previous flow element is txt(...)
	 *   then concatenate new string with this one,
	 *   otherwise create a new flow element
	 */
	if ( CHECK_CONTEXT(CNTX_TEXT|CNTX_PARA|CNTX_BLOCK|
	  		   CNTX_LH|CNTX_LI|CNTX_CAPTION|CNTX_TABLE_CELL|
			   CNTX_FORM|CNTX_BODY) )
	{
		pTail = (FLOW_ELEMENT*)list_GetTail(html_cur_List());
			
		if ( pTail && pTail->fno == flow_element_txt )
		{
			pBuff = galloc ((strlen(pTail->u.txt)+
				 	strlen(Str)+2)*
				 	sizeof(char));
			if (IsPreformatted)
				sprintf (pBuff,"%s%s",pTail->u.txt,Str);
			else
				sprintf (pBuff,"%s %s",pTail->u.txt,Str);
			pTail->u.txt = pBuff;
		}
		else
		{
			pFlow = galloc (sizeof(FLOW_ELEMENT));
			pFlow->fno = flow_element_txt;
			/*
			 * If the last element is inline then add one blank
			 */
			/*
			if( pTail && isInline(pTail->fno) )
			{
				pFlow->u.txt = galloc ((strlen(Str)+2)*sizeof(char));
				sprintf (pFlow->u.txt," %s",Str);
			}
			else
			*/
			{
				pFlow->u.txt = galloc ((strlen(Str)+1)*sizeof(char));
				strcpy (pFlow->u.txt,Str);
			}
			list_AddTail (html_cur_List(),pFlow);
		}
	}
	/*
	 *   List stack points to the string itself
	 */
	if ( CHECK_CONTEXT(CNTX_FORM_TEXT) )
	{
		pFlow = html_cur_List ();
		pBuff = galloc((strlen(Str)+
				strlen(pFlow->u.textarea.initial)+2)*
				sizeof(char));
		sprintf (pBuff,"%s%s\n",pFlow->u.textarea.initial,Str);
		pFlow->u.textarea.initial=pBuff;
	}
	/*
	 *   term(attlist,string)
	 */
	if ( CHECK_CONTEXT(CNTX_FORM_OPTION|CNTX_HEAD_STYLE) )
	{
		pOpt = (OPTION*)html_cur_List ();
		pBuff = galloc((strlen(Str)+
				strlen(pOpt->item)+2)*
				sizeof(char));
		sprintf (pBuff,"%s%s",pOpt->item,Str);
		pOpt->item=pBuff;
	}
	/*
	 *   term(string)
	 */
	if ( CHECK_CONTEXT(CNTX_HEAD_TITLE) )
	{
		HEADELEM *pHead = html_cur_List ();

		pBuff = galloc((strlen(Str)+
				strlen(pHead->u.title)+2)*
				sizeof(char));
		sprintf (pBuff,"%s%s",pHead->u.title,Str);
		pHead->u.title=pBuff;
	}
        /*
         *  Scripting Language Text
         */
        if ( CHECK_CONTEXT(CNTX_SCRIPT) )
        {
                pFlow = html_cur_List ();
                pBuff = galloc((strlen(Str)+
                                strlen(pFlow->u.script.txt)+2)*
				sizeof(char));
                sprintf (pBuff,"%s%s",pFlow->u.script.txt,Str);
                pFlow->u.script.txt = pBuff;
        }
}

/*
 *  CreateAttlist - collect cur_Tag att array
 *                     into Prolog list and return it
 */
ATTLIST *CreateAttlist (void)
{
	ATTLIST *pList;
	ATT     *pAtt;
	int     i;

	pList = (ATTLIST*)list_GCreate ();

	for ( i=0; i < cur_Tag.tag_AttCount; i++ )
	{
		pAtt = (ATT*)galloc(sizeof(ATT));
		pAtt->fno = att_att;
		pAtt->Name = cur_Tag.tag_AttArray[i].Name;
		pAtt->Val  = cur_Tag.tag_AttArray[i].Val;
		list_AddTail ((PLIST)pList,pAtt);
	}
	return pList;
}

void CopyAttlist (ATTLIST *pList)
{
	ATT     *pAtt;
	int     i;

	for ( i=0; i < cur_Tag.tag_AttCount; i++ )
	{
		pAtt = (ATT*)galloc(sizeof(ATT));
		pAtt->fno = att_att;
		pAtt->Name = cur_Tag.tag_AttArray[i].Name;
		pAtt->Val  = cur_Tag.tag_AttArray[i].Val;
		list_AddTail ((PLIST)pList,pAtt);
	}
}

/*
 *  Returs true if the flow element is inline
 */
int isInline(int F)
{
	if (F==flow_element_u ||
		F==flow_element_b ||
		F==flow_element_i ||
		F==flow_element_tt ||
		F==flow_element_s ||
		F==flow_element_big ||
		F==flow_element_small ||
		F==flow_element_sub ||
		F==flow_element_sup ||
		F==flow_element_font ||
		F==flow_element_em ||
		F==flow_element_strong ||
		F==flow_element_dfn ||
		F==flow_element_code ||
		F==flow_element_samp ||
		F==flow_element_kbd ||
		F==flow_element_var ||
		F==flow_element_a) return TRUE;
	else return FALSE;
}

#ifdef __DEBUG__

void DumpTag ()
{
	int i;

	printf("%s\t(%d)\tAtt\tType\tVal\n",
		cur_Tag.tag_Name,
		GetTagValue(cur_Tag.tag_Name));
	printf("-------------------------------------------\n");
	for (i=0;i<cur_Tag.tag_AttCount;i++)
	{
		printf ("\t\t%s",
				cur_Tag.tag_AttArray[i].Name);
		switch ( cur_Tag.tag_AttArray[i].Val->fno )
		{
			case attval_nill:
				printf ("\tnill\n");
				break;
			case attval_lit:
				printf ("\tlit\t%s\n",
					cur_Tag.tag_AttArray[i].Val->u.lit);
				break;
			case attval_atom:
				printf ("\tatom\t%s\n",
					cur_Tag.tag_AttArray[i].Val->u.atom);
				break;
			case attval_num:
				printf ("\tnum\t%d\n",
					cur_Tag.tag_AttArray[i].Val->u.num);
				break;

		}
	}
	printf("-------------------------------------------\n");
}
#endif


