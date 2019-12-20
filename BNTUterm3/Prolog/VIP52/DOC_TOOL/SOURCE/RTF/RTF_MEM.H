/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_MEM.H
 Purpose: RTF Parser. Memory handling routines
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __RTF_MEM_H__
#define __RTF_MEM_H__

void InitRTFParser (void);
void CloseRTFParser (void);
void AllocPageBuff (void);
BOOL AddStrToParaBuff (char *Str);
void clear_Page (void);
void rtf_push_Context (int);
int  rtf_pop_Context (void);
int  rtf_cur_Context (void);
void rtf_push_List (void *List);
void *rtf_pop_List (void);
void *rtf_cur_List (void);

#endif
