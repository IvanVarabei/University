/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: LIST.C
 Purpose: Generalized list handling routines
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "../config.h"
#include "y_pdcdef.h"
#include "list.h"

/*
 *  Create an empty list in global stack
 */
PLIST list_GCreate (void)
{
	LIST	*pList;

	pList = galloc (sizeof(LIST));
	pList->fno  = NILLFNO;
	pList->item = NULL;
	pList->next = NULL;

	return pList;
}
/*
 *  Add new item to the list's tail
 */
void list_AddTail (PLIST pList,void *pItem)
{
	PLIST	tail;
	/*
	 *  Go to the list's tail
	 */
        tail = pList;
	while ( tail!=NULL && tail->fno==LISTFNO ) tail = tail->next;
	/*
	 *  Make the tail as new item
	 *  Add new empty item to the tail of a new list
	 */
	tail->fno  = LISTFNO;
	tail->item = pItem;
	tail->next = list_GCreate ();
}
/*
 *  Return the pointer to the tail element
 */
void *list_GetTail (PLIST pList)
{
	PLIST tail;
	PLIST next;

	tail = pList;
	next = tail->next;
	while ( next && next->fno==LISTFNO )
	{
		tail = next;
		next = tail->next;
	}
	return tail->item;
}

/*
 *  Check if the list is empty
 */
int list_IsEmpty (PLIST pList)
{
	return (pList->fno==NILLFNO);
}
/*
 *  Split the list at the specified element
 *  If this element is not found in the list
 *  the second list will be NULL
 */
void list_SplitAt (PLIST pList,void *pItem,PLIST pTail)
{
        PLIST cur;
        PLIST prev = NULL;

        cur=pList;
        /*
         *  scan the list
         */
        while ( cur->fno == LISTFNO )
        {
                /*
                 *  If found
                 */
                if ( cur->item == pItem )
                {
                        pTail = cur;
                        if ( prev == NULL ) pList = NULL;
                        else
                        {
                                prev->next=list_GCreate();
                        }
                        return;
                }
                else /* further more */
                {
                        prev = cur;
                        cur=cur->next;
                }
        }
        /*
         * not found
         */
        pTail = NULL;
}
/*
 *  Split the list after the specified element
 *  If this element is not found in the list
 *  the second list will be []
 */
PLIST list_SplitAfter (PLIST pList,void *pItem)
{
        PLIST cur;
        PLIST next;

        cur=pList;

        while ( cur && cur->fno == LISTFNO )
        {
                if ( cur->item==pItem )
                {
                        next=cur->next;
                        cur->next=list_GCreate();
                        return next;
                }
		cur=cur->next;
        }
        return(list_GCreate());
}

