/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_PRO.H
 Purpose: IPF Parser. The heart parser module
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __IPF_PRO_H__
#define __IPF_PRO_H__

#include "ipf.h"
#include "../common/list.h"
#include "../common/misc.h"
#include "ipf_mem.h"
#include "ipf_key.h"

void ipf_term_0 (char *Str,DOC **ppDoc);
//void ipf_term_1 (char **pStr,DOC *pDoc);
//void ipf_term_2 (char *Str,DOC *pDoc);
//void ipf_term_3 (char **pStr,DOC **ppDoc);
void ipf_ProcessTag (void);
void ipf_CloseTag (char *Tag);

#endif
