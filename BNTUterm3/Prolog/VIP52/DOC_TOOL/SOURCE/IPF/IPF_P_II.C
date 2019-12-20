/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_P_II.C
 Purpose: IPF Generator
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "ipf.h"
/*
 *  ipf_term (i,i)
 */
extern void unify_ipf_doc (char *Str,DOC *pDoc);

void ipf_term_2 (char *pStr,DOC *pDoc)
{
        unify_ipf_doc (pStr,pDoc);
}


