/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: HTML_MEM.H
 Purpose: HTML Parser. Memory handling routines
	  Initialize and close down the parser
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __HTML_MEM_H__
#define __HTML_MEM_H__

void InitHTMLParser (void);
void CloseHTMLParser (void);
int ExtractLiteral (char);
void html_push_Context (unsigned long);
unsigned long html_pop_Context (void);
unsigned long html_cur_Context (void);
void html_push_List (void *);
void *html_pop_List (void);
void *html_cur_List (void);

#endif



