/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_FORM.H
 Purpose: RTF Parser. Format Handlihg Routines Manage paragraph, font and
	  text highlighting.
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __RTF_FORM_H__
#define __RTF_FORM_H__

void InitFormat (void);
void push_Paragraph (PARAGRAPH *Para);
void pop_Paragraph (PARAGRAPH *Para);
void cur_Paragraph (PARAGRAPH *Para);
void push_Format (FORMAT *Format);
void pop_Format (FORMAT *Format);
void cur_Format (FORMAT *Format);
void default_Para (PARAGRAPH *Para);
void default_Trow (TROWINF *Trow);
void copy_Para (PARAGRAPH *Dest, PARAGRAPH *Src);
BOOL is_Para_Equal (PARAGRAPH *P1,PARAGRAPH *P2);
void plain_Text (FORMAT *Form);
void rev_Format (FORMAT *to_Form,FORMAT *from_Form);
void copy_Format (FORMAT *Dest,FORMAT *Src);
BOOL is_Font_Equal (FORMAT *F1,FORMAT *F2);
void AddTabstopToPara (int Val);
void AddCellToTrow (int Val);
void NewPageFormat (void);

#endif
