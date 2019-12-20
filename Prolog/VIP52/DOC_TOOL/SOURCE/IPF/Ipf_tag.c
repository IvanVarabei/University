/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_TAG.C
 Purpose: IPF Parser. Tag Handling
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "ipf.h"

#ifndef __PROLOG__
#include <ctype.h>
#include <malloc.h>
#include <string.h>
#endif

#include "ipf_tag.h"
#include "ipf_key.h"
#include "ipf_mem.h"
#include "ipf_pro.h"
#include "../common/list.h"
#include "../common/misc.h"
#include "../common/atts.h"

TAG	ipf_cur_Tag;        /* Current parsed tag   */

/*
 *   Clears the current tag
 *
 *   In Prolog programs all the attributies are allocated
 *   at the global stack, so we don't need to free
 *   their memory manualy
 *
 */
void ipf_ClearTag (void)
{
    #ifndef __PROLOG__

	int i;

	for (i=0;i<ipf_cur_Tag.tag_AttCount;i++)
	{
		ClearAttVal (ipf_cur_Tag.tag_AttArray[i].Val);
		free(ipf_cur_Tag.tag_AttArray[i].Name);
	}
    #endif
	ipf_cur_Tag.tag_Name[0]='\0';
	ipf_cur_Tag.tag_AttCount=(-1);
}

#ifndef __PROLOG__
/*
 *  Frees tag attribute value
 */
void ipf_ClearAttVal (ATTVAL *pVal)
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
void ipf_AddAttribute (char *Name,char Type,char *Str,int Num)
{
	int i = ipf_cur_Tag.tag_AttCount;
	ATTVAL *pVal;

	if (i==-1)
	{
       		strcpy_tolower(ipf_cur_Tag.tag_Name,Name);
	}
	else
	{
		ipf_cur_Tag.tag_AttArray[i].Name = galloc(strlen(Name)+1);
		strcpy_tolower(ipf_cur_Tag.tag_AttArray[i].Name,Name);
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
		ipf_cur_Tag.tag_AttArray[i].Val = pVal;
	}
	ipf_cur_Tag.tag_AttCount=i+1;
}

/*
 *  BeginTag() - the current tag is parsed
 *               process it
 */
void ipf_BeginTag (void)
{
       ipf_ProcessTag ();
}

/*
 *  EndTag () - ends the named tag
 */
void ipf_EndTag (char *Name)
{
        ipf_CloseTag (Name);
	ipf_ClearTag ();
}

void ipf_AddPlainText (char *Str)
{
	FLOW_ELEMENT    *pFlow;
	FLOW_ELEMENT	*pTail;
	STRING		pBuff;
	/*
	 *   Most of text flow elements
	 *
	 *   If the previous flow element is txt(...)
	 *   then concatenate new string with this one,
	 *   otherwise create a new flow element
	 */

	if ( CHECK_CONTEXT(CNTX_TEXT|CNTX_PARA|CNTX_BLOCK|
			   CNTX_LH|CNTX_LI|CNTX_TABLE_CELL|
			   CNTX_BODY) )
	{
		pTail = (FLOW_ELEMENT*)list_GetTail(ipf_cur_List());
		if ( pTail && pTail->fno == flow_element_txt )
		{
			pBuff = galloc ((strlen(pTail->u.txt)+
					strlen(Str)+2)*
					sizeof(char));
			sprintf (pBuff,"%s%s",pTail->u.txt,Str);
			pTail->u.txt = pBuff;
		}
		else
		{
			pFlow = galloc (sizeof(FLOW_ELEMENT));
			pFlow->fno = flow_element_txt;
			pFlow->u.txt = galloc ((strlen(Str)+1)*sizeof(char));
			strcpy (pFlow->u.txt,Str);
			list_AddTail (ipf_cur_List(),pFlow);
		}
	}
	/*
	 *   term(string)
	 */
        if ( CHECK_CONTEXT(CNTX_HEAD_TITLE) )
	{
                HEADELEM *pHead = ipf_cur_List ();

		pBuff = galloc((strlen(Str)+
                                strlen(pHead->u.title)+2)*
				sizeof(char));
                sprintf (pBuff,"%s%s",pHead->u.title,Str);
                pHead->u.title=pBuff;
	}
}

/*
 *  CreateAttlist - collect ipf_cur_Tag att array
 *                     into Prolog list and return it
 */
ATTLIST *ipf_CreateAttlist (void)
{
	ATTLIST *pList;
	ATT     *pAtt;
	int     i;

	pList = (ATTLIST*)list_GCreate ();

	for ( i=0; i < ipf_cur_Tag.tag_AttCount; i++ )
	{
		pAtt = (ATT*)galloc(sizeof(ATT));
		pAtt->fno = att_att;
		pAtt->Name = ipf_cur_Tag.tag_AttArray[i].Name;
		pAtt->Val  = ipf_cur_Tag.tag_AttArray[i].Val;
		list_AddTail ((PLIST)pList,pAtt);
	}
	return pList;
}

void ipf_CopyAttlist (ATTLIST *pList)
{
	ATT     *pAtt;
	int     i;

	for ( i=0; i < ipf_cur_Tag.tag_AttCount; i++ )
	{
		pAtt = (ATT*)galloc(sizeof(ATT));
		pAtt->fno = att_att;
		pAtt->Name = ipf_cur_Tag.tag_AttArray[i].Name;
		pAtt->Val  = ipf_cur_Tag.tag_AttArray[i].Val;
		list_AddTail ((PLIST)pList,pAtt);
	}
}

#ifdef __DEBUG__

void ipf_DumpTag ()
{
	int i;

	printf("%s\t(%d)\tAtt\tType\tVal\n",
		ipf_cur_Tag.tag_Name,
		ipf_GetTagValue(ipf_cur_Tag.tag_Name));
	printf("-------------------------------------------\n");
	for (i=0;i<ipf_cur_Tag.tag_AttCount;i++)
	{
		printf ("\t\t%s",
				ipf_cur_Tag.tag_AttArray[i].Name);
		switch ( ipf_cur_Tag.tag_AttArray[i].Val->fno )
		{
			case attval_nill:
				printf ("\tnill\n");
				break;
			case attval_lit:
				printf ("\tlit\t%s\n",
					ipf_cur_Tag.tag_AttArray[i].Val->u.lit);
				break;
			case attval_atom:
				printf ("\tatom\t%s\n",
					ipf_cur_Tag.tag_AttArray[i].Val->u.atom);
				break;
			case attval_num:
				printf ("\tnum\t%d\n",
					ipf_cur_Tag.tag_AttArray[i].Val->u.num);
				break;

		}
	}
	printf("-------------------------------------------\n");
}
#endif
