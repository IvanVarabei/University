/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_P_OO.C
 Purpose: IPF Generator
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "ipf.h"

extern void gen_ipf_doc (char **pStr,DOC **ppDoc);
/*
 *  ipf_term (o,o)
 */
void ipf_term_3 (char **pStr,DOC **ppDoc)
{
        gen_ipf_doc (pStr,ppDoc);
}


