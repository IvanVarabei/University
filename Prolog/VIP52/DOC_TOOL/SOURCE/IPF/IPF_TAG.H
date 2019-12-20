/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: IPF_TAG.H
 Purpose: IPF Parser. Tag handling
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __IPF_TAG_H__
#define __IPF_TAG_H__

void ipf_ClearTag(void);
void ipf_ClearAttVal (ATTVAL *pVal);
void ipf_BeginTag (void);
void ipf_EndTag (char *Name);
void ipf_AddAttribute (char *Name,char Type,char *Str,int Num);
void ipf_AddPlainText (char *Str);
ATTLIST *ipf_CreateAttlist (void);
void ipf_CopyAttlist (ATTLIST *pList);

#ifdef __DEBUG__
void ipf_DumpTag ();
#endif


#endif



