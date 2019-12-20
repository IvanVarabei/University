/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_PRO.H
 Purpose: HTML Parser. The heart parser module
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __HTML_PRO_H__
#define __HTML_PRO_H__

#include "html.h"
#include "../common/list.h"
#include "../common/misc.h"
#include "html_mem.h"
#include "html_key.h"

void html_term_0 (char *Str,DOC **ppDoc);
void html_term_1 (char **pStr,DOC *pDoc);
void html_term_2 (char *Str,DOC *pDoc);
void html_term_3 (char **pStr,DOC **ppDoc);
void ProcessTag (void);
void CloseTag (char *Tag);

#endif
