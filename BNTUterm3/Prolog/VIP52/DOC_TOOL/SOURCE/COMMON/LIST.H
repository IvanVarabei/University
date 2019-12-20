/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: LIST.H
 Purpose: Generalized list handling routines
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __LIST_H__
#define __LIST_H__

#ifndef LISTFO
#define LISTFNO		1
#endif
#ifndef NILLFNO
#define NILLFNO		2
#endif
#ifndef NULL
#define NULL		0
#endif

#define LIST_ERROR	-1


typedef struct list_struct
{
	unsigned char fno;	/* list functor number			*/
	void *item;		/* pointer to list element structure	*/
	void *next;		/* pointer to next list element		*/
} LIST, *PLIST;

PLIST list_GCreate (void);
void list_AddTail (PLIST pList,void *pItem);
void *list_GetTail (PLIST);
int list_IsEmpty (PLIST);
void list_SplitAt (PLIST pList,void *pItem,PLIST pTail);
PLIST list_SplitAfter (PLIST pList,void *pItem);

#endif

