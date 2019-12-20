/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_MEM.H
 Purpose: IPF Parser. Memory handling routines
	  Initialize and close down the parser
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __IPF_MEM_H__
#define __IPF_MEM_H__

void InitIPFParser (void);
void CloseIPFParser (void);
int ipf_ExtractLiteral (char);
void ipf_push_Context (unsigned long);
unsigned long ipf_pop_Context (void);
unsigned long ipf_cur_Context (void);
void ipf_push_List (void *);
void *ipf_pop_List (void);
void *ipf_cur_List (void);

#endif



