/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_OI.C
 Purpose: HTML Parser. This module is a "code generator" and produces the
	  Prolog term of the domain, that last is a representation of HTML DTD
	  See: DOCSTR.DOM
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/
#include "html.h"

extern void make_html_doc (char **pStr,DOC *pDoc);
/*
 *  (o,i)
 */
void html_term_1 (char **pStr,DOC *pDoc)
{
	make_html_doc (pStr,pDoc);
}
