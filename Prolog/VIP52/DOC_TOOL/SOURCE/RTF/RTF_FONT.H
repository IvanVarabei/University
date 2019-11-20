/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_FONT.H
 Purpose: RTF Parser. Font Handlihg Routines
	  Routines of this module will refer to
	  font table that is stored in GLOBALS.C
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __RTF_FONT_H__
#define __RTF_FONT_H__

#include "rtf_pro.h"

void InitTables (void);
void ClearTables (void);
void CreateFontTableRecord (void);
void FillFontTableRecord (void);
BOOL lookup_Font (int FontNum,FONTTBL_RECORD *Rec);
void lookup_Color (int ForeIdx, int BackIdx, 
		   int *FR,int *FG,int *FB,
		   int *BR,int *BG,int *BB);
void CreateColorTableRecord (void);
void FillColorTableRecord (void);
void CutLastColorTableRecord (void);
void PrintFontTable (void);
void PrintColorTable (void);
void CopyRTFTablesIn (RTF_TABLES *pTblIn);
void CopyRTFTablesOut (RTF_TABLES *pTblOut);

#endif
