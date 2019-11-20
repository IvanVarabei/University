/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_II.C
 Purpose: HTML Parser. This module is a "code generator" and produces the 
	  Prolog term of the domain, that last is a representation of HTML DTD
	  See: DOCSTR.DOM
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/
#include "html.h"

extern void unify_html_doc (char *Str,DOC *pDoc);
/*
 *  (i,i)
 */
void html_term_2 (char *Str,DOC *pDoc)
{
	unify_html_doc (Str,pDoc);
}
