/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_SYM.H
 Purpose: IPF Parser. Symbol Table
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __IPF_SYM_H__
#define __IPF_SYM_H__

typedef struct tagSYM_TABLE_RECORD
{
	char 	SymStr [20];
	char	SymVal;
} SYM_TABLE_RECORD;

void ipf_SymbolByValue (char *Sym);

#endif
