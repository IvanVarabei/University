/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_FOOT.C
 Purpose: RTF Parser. Footnotes handling
 Written by: Oleg V. Erjomin
 Comments:    27.10.96   Simplify browse sequence encoding, don't parse
              it into [major:minor]. Allow it to be done by
              calee

******************************************************************************/

#include "rtf.h"
#include "rtf_foot.h"
#include "rtf_mem.h"
#include "../common/list.h"

#ifndef  __PROLOG__
#include <ctype.h>
#endif

char	*FootBuff = NULL;

static char FootCode;	/* Current footnote code */

/*
 *  Local Functions
 */
char *FindFootValue (void);
/*
 *  Get footnote code
 *
 *  This function suppose that valid footnote
 *  code ($#!K+*) was just read and placed at the
 *  tail of page buffer lits.
 *
 *  We must check this fact before entering
 *  the footnote interpretting context.
 *
 *  On success we will eat the last character
 *  from the page tail and return TRUE
 *
 */

BOOL get_Foot_Code (void)
{
	FLOW_ELEMENT *pTail;
	int 	Len;
	char	C;


	pTail = (FLOW_ELEMENT*)list_GetTail(rtf_cur_List());

	if ( pTail && pTail->fno == flow_element_txt )
	{
		Len = strlen (pTail->u.txt);
		if ( Len==0 ) return FALSE;
		C = pTail->u.txt[Len-1];

		if ( C=='#' || C=='$' || C=='!' || C=='K' || C=='+' || C=='*')
		{
			FootCode=C;
			pTail->u.txt[Len-1]='\0';
			return TRUE;
		}
		else return FALSE;
	}
	else return FALSE;
        /*

	if (Len==0) return FALSE;
 	C = ParaBuff[Len-1];

	if ( C=='#' || C=='$' || C=='!' || C=='K' || C=='+' || C=='*')
	{
		FootCode=C;
		ParaBuff[Len-1]='\0';
		return TRUE;
	}
	else return FALSE;
        */

}

/*
 *  Clear Footnote Buffers
 */
void ClearFootNote (void)
{
	FootBuff[0]='\0';
	FootCode = '\0';
}
/*
 *  Store current page attributies
 *  Copy only valid amount of text
 */
void MakePageAttributies (void)
{
	char	*p;	/* points to value beginning */

	p = FindFootValue ();

	switch ( FootCode )
	{
		case '#': strncpy (cur_Page.Context,p,255); break;
		case '$': strncpy (cur_Page.Title,p,255); break;
		case 'K': strncpy (cur_Page.Keywords,p,255); break;
		case '!': strncpy (cur_Page.Macro,p,2048); break;
                case '+': strncpy (cur_Page.BrowseSeq,p,255); break;
		case '*': break;
	}
}
/*
 *  Find the footnote value
 *  Skip lead blanks
 *  Skip foot code if one exists
 *  Skip blanks after this code
 */
char * FindFootValue (void)
{
	char *p = FootBuff;

	while ( *p && isspace(*p) ) p++;
	if (*p=='#' || *p=='$' || *p=='K' || *p=='!' || *p=='+' || *p=='*')
	{
		p++;
		while ( *p && isspace (*p) ) p++;
	}
	return p;
}

