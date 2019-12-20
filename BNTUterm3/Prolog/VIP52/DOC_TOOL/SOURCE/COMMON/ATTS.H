/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: ATTS.H
 Purpose: Create various types of tag attributies values
	  literal; atom; numeric; nill
 Written by: 
 Comments:
******************************************************************************/

#ifndef __ATTS_H__
#define __ATTS_H__

ATT    *CreateAttribute (char *Name,char Type,char *Str,int Num);
ATTVAL *CreateLitAttVal (char*);
ATTVAL *CreateAtomAttVal (char*);
ATTVAL *CreateNumAttVal (int);
ATTVAL *CreateNillAttVal (void);

#endif
