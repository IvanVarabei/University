/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_TAG.H
 Purpose: HTML Parser. Tag handling
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __HTML_TAG_H__
#define __HTML_TAG_H__

void ClearTag(void);
void ClearAttVal (ATTVAL *pVal);
void BeginTag (void);
void EndTag (char *Name);
void AddAttribute (char *Name,char Type,char *Str,int Num);
void AddDocProlog (char *Prolog);
void AddPlainText (char *Str);
void AddWhiteSpace (void);
ATTLIST *CreateAttlist (void);
void CopyAttlist (ATTLIST *pList);

#ifdef __DEBUG__
void DumpTag ();
#endif


#endif



