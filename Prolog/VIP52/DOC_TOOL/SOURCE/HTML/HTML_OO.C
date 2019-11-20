/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_OO.C
 Purpose: HTML Parser. This module is a "code generator" and produces the
	  Prolog term of the domain, that last is a representation of HTML DTD
	  See: DOCSTR.DOM
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/
#include "html.h"

extern void gen_html_doc (char **pStr,DOC **ppDoc);
/*
 *  (o,o)
 */
void html_term_3 (char **pStr,DOC **ppDoc)
{
	gen_html_doc (pStr,ppDoc);
}
