/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_P_OI.C
 Purpose: IPF Generator
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "ipf.h"

extern void make_ipf_doc (char **pStr,DOC *pDoc);

/*
 *  ipf_term (o,i)
 */
void ipf_term_1 (char **pStr,DOC *pDoc)
{
        make_ipf_doc (pStr,pDoc);
}


