/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_FONT.C
 Purpose: RTF Parser. Font Handlihg Routines Color Handlihg routines are placed
	  here too, because colors are used for fonts only.
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "rtf.h"
#include "rtf_font.h"
#include "rtf_pro.h"	/* Interface to Prolog */
#include "../common/list.h"

int FontTableIdx  = -1;
int ColorTableIdx = -1;

FONTTBL_RECORD tmp_FontRec;
FONTTBL_RECORD *FontTable = NULL;

COLORTBL_RECORD tmp_ColorRec;
COLORTBL_RECORD *ColorTable = NULL;

/*
 * Local functions
 */
void default_FontRec (void);
void default_ColorRec (void);

void InitTables (void)
{
	FontTableIdx = -1;
	FontTable = NULL;
	ColorTableIdx = -1;
	ColorTable = NULL;
}
void ClearTables (void)
{
    #ifdef __PROLOG__
	if (FontTable!=NULL) 
		free (FontTable,sizeof(FONTTBL_RECORD)*(FontTableIdx+1));
	if (ColorTable!=NULL)
		free (ColorTable,sizeof(COLORTBL_RECORD)*(ColorTableIdx+1));
    #else
	free (FontTable);
	free (ColorTable);
    #endif
}

void CreateFontTableRecord (void)
{
	//FONTTBL_RECORD	*NewTbl;
	//int i;

	FontTableIdx++;

	if (FontTable==NULL)
	{
		FontTable = (FONTTBL_RECORD*) malloc(sizeof(FONTTBL_RECORD));
	} else {
    #ifdef __PROLOG__
		FontTable = (FONTTBL_RECORD*) MEM_ReAllocHeap (FontTable,sizeof(FONTTBL_RECORD)*(FontTableIdx),sizeof(FONTTBL_RECORD)*(FontTableIdx+1));
		/*
		NewTbl = (FONTTBL_RECORD*)malloc(sizeof(FONTTBL_RECORD)*(FontTableIdx+1));
		for (i=0;i<FontTableIdx;i++)
		{
			memcpy(&NewTbl[i],&FontTable[i],sizeof(FONTTBL_RECORD));
			MEM_MovMem(&NewTbl[i],&FontTable[i],sizeof(FONTTBL_RECORD));
		}
		free (FontTable,sizeof(FONTTBL_RECORD)*(FontTableIdx));
		FontTable = NewTbl;
		*/
    #else
		FontTable = (FONTTBL_RECORD*) realloc (
			(char*)FontTable,
			sizeof(FONTTBL_RECORD)*(FontTableIdx+1));

    #endif
	};
	default_FontRec ();
}

void CreateColorTableRecord (void)
{
	COLORTBL_RECORD	*NewTbl;
	int i;

	ColorTableIdx++;
	if (ColorTable==NULL)
	{
		ColorTable = (COLORTBL_RECORD*) malloc (
			sizeof(COLORTBL_RECORD));
	} else {
    #ifdef __PROLOG__
		NewTbl = (COLORTBL_RECORD*)malloc(
				sizeof(COLORTBL_RECORD)*(ColorTableIdx+1));
		for (i=0;i<ColorTableIdx;i++)
		{
			memcpy(&NewTbl[i],&ColorTable[i],sizeof(COLORTBL_RECORD));
		}
		free (ColorTable,sizeof(COLORTBL_RECORD)*(ColorTableIdx));
		ColorTable = NewTbl;
    #else
		ColorTable = (COLORTBL_RECORD*) realloc (
			(char*)ColorTable,
			sizeof(COLORTBL_RECORD)*(ColorTableIdx+1));
    #endif
	};
	default_ColorRec ();
}

void CutLastColorTableRecord (void)
{
	COLORTBL_RECORD	*NewTbl;
	int i;

	if (ColorTable==NULL) return;
    #ifdef __PROLOG__

		NewTbl=(COLORTBL_RECORD*)malloc(sizeof(COLORTBL_RECORD)*ColorTableIdx);
		for (i=0;i<ColorTableIdx;i++)
		{
			memcpy(&NewTbl[i],&ColorTable[i],sizeof(COLORTBL_RECORD));
		}
		free (ColorTable,sizeof(COLORTBL_RECORD)*(ColorTableIdx+1));
		ColorTable=NewTbl;
		ColorTableIdx--;
    #else
		ColorTable = (COLORTBL_RECORD*) realloc (
			(char*)ColorTable,
			sizeof(COLORTBL_RECORD)*(ColorTableIdx+1));
    #endif
}

void default_FontRec (void)
{
	tmp_FontRec.ftbl_Num      =
	tmp_FontRec.ftbl_Charset  =
	tmp_FontRec.ftbl_Prq      =
    	tmp_FontRec.ftbl_Family   = 0;
	strcpy(tmp_FontRec.ftbl_FaceName,"Unknown font");
}

void default_ColorRec (void)
{
	tmp_ColorRec.R =
	tmp_ColorRec.G =
	tmp_ColorRec.B = 0;	/* deep black */
}

void FillFontTableRecord (void)
{
	memcpy (&FontTable[FontTableIdx],
		&tmp_FontRec,
		sizeof(FONTTBL_RECORD));
}

void FillColorTableRecord (void)
{
	memcpy (&ColorTable[ColorTableIdx],
		&tmp_ColorRec,
		sizeof(COLORTBL_RECORD));
}

/*
 *  Copy Prolog internal RTF tables
 *
 *  Copy tables form Prolog to C
 */
void CopyRTFTablesIn (RTF_TABLES *pTblIn)
{
	/* Split the table into the two lists */
	FONT_TABLE  *pFontTbl  = pTblIn->Font_table;
	COLOR_TABLE *pColorTbl = pTblIn->Color_table;
	FONT_TBL_RECORD  *pFontRec;
	COLOR_TBL_RECORD *pColorRec;

	/*
	 *  Copy font table
	 */
	while ( pFontTbl->fno==LISTFNO )
	{
		pFontRec = pFontTbl->font_tbl_record;
		CreateFontTableRecord ();
		tmp_FontRec.ftbl_Num     = pFontRec->ftbl_Num;
		tmp_FontRec.ftbl_Charset = pFontRec->ftbl_Charset;
		tmp_FontRec.ftbl_Prq     = pFontRec->ftbl_Prq;
		tmp_FontRec.ftbl_Family  = pFontRec->ftbl_Family;
		strcpy (tmp_FontRec.ftbl_FaceName,pFontRec->ftbl_FaceName);
		FillFontTableRecord ();
		pFontTbl = pFontTbl->next;
	}
	/*
	 *  Copy color table
	 */
	while ( pColorTbl->fno==LISTFNO )
	{
		pColorRec = pColorTbl->color_tbl_record;
		CreateColorTableRecord ();
		tmp_ColorRec.R = pColorRec->ctbl_R;
		tmp_ColorRec.G = pColorRec->ctbl_G;
		tmp_ColorRec.B = pColorRec->ctbl_B;
		FillColorTableRecord ();
		pColorTbl = pColorTbl->next;
	}
}
/*
 *  Copy tables from C to Prolog
 */
void CopyRTFTablesOut (RTF_TABLES *pTblOut)
{
	int			i;
	FONT_TBL_RECORD 	*pFontRec;
	COLOR_TBL_RECORD	*pColorRec;

	/*
	 *  Copy font table
	 */
	for ( i=0;i<=FontTableIdx;i++ )
	{
		pFontRec = (FONT_TBL_RECORD*)galloc(sizeof(FONT_TBL_RECORD));
		pFontRec->fno           = font_tbl_record_font_tbl_record;
		pFontRec->ftbl_Num      = FontTable[i].ftbl_Num;
		pFontRec->ftbl_Charset  = FontTable[i].ftbl_Charset;
		pFontRec->ftbl_Prq      = FontTable[i].ftbl_Prq;
		pFontRec->ftbl_Family   = FontTable[i].ftbl_Family;
		pFontRec->ftbl_FaceName =
			galloc((strlen(FontTable[i].ftbl_FaceName)+1)
				*sizeof(char));
		strcpy (pFontRec->ftbl_FaceName,FontTable[i].ftbl_FaceName);
		list_AddTail ((PLIST)pTblOut->Font_table,pFontRec);
	}
	/*
	 *  Copy color table
	 */
	for ( i=0;i<=ColorTableIdx;i++ )
	{
		pColorRec = (COLOR_TBL_RECORD*)galloc(sizeof(COLOR_TBL_RECORD));
		pColorRec->fno    = color_tbl_record_color_tbl_record;
		pColorRec->ctbl_R = ColorTable[i].R;
		pColorRec->ctbl_G = ColorTable[i].G;
		pColorRec->ctbl_B = ColorTable[i].B;
		list_AddTail ((PLIST)pTblOut->Color_table,pColorRec);
	}
}

/*
 *  Look for fonttable record
 *  Return TRUE if found and fill FONTTBL_RECORD
 */
BOOL lookup_Font (int FontNum,FONTTBL_RECORD *Rec)
{
	int i;

	for (i=0;i<=FontTableIdx;i++)
	{
		if ( FontTable[i].ftbl_Num == FontNum )
		{
			memcpy (Rec,&FontTable[i],sizeof(FONTTBL_RECORD));
			return TRUE;
		}
	}
	return FALSE;
}
/*
 *   Look for the colortable, return RGB values, or defaults
 */
void lookup_Color (int ForeIdx, int BackIdx, 
		   int *FR,int *FG,int *FB,
		   int *BR,int *BG,int *BB)
{
	if (ForeIdx==0 || ForeIdx>=ColorTableIdx) 
	{
		*FR=0;*FG=0;*FB=0;
	}
	else
	{
		*FR = ColorTable[ForeIdx].R;
		*FG = ColorTable[ForeIdx].G;
		*FB = ColorTable[ForeIdx].B;
	};

	if (BackIdx==0 || BackIdx>=ColorTableIdx) 
	{
		*BR=255;*BG=255;*BB=255;
	}
	else
	{
		*BR = ColorTable[BackIdx].R;
		*BG = ColorTable[BackIdx].G;
		*BB = ColorTable[BackIdx].B;
	}
}


#ifdef __DEBUG_RTF__
/*
 *  Font and Color Tables Dumps
 */
void PrintFontTable (void)
{
	int i;

    #ifdef __PROLOG__
	IO_Writef ("FONT TABLE:\n--------------\n");
	IO_Writef ("N\tSet\tPrq\tFamily\tFaceName\n");
	for (i=0;i<=FontTableIdx;i++)
	{
		IO_Writef("%d\t%d\t%d\t%d\t%s\n",
			FontTable[i].ftbl_Num,
			FontTable[i].ftbl_Charset,
			FontTable[i].ftbl_Prq,
			FontTable[i].ftbl_Family,
			FontTable[i].ftbl_FaceName);
	}
    #else
	fprintf (yyout,"FONT TABLE:\n--------------\n");
	fprintf (yyout,"N\tSet\tPrq\tFamily\tFaceName\n");
	for (i=0;i<=FontTableIdx;i++)
	{
		fprintf(yyout,"%d\t%d\t%d\t%d\t%s\n",
			FontTable[i].ftbl_Num,
			FontTable[i].ftbl_Charset,
			FontTable[i].ftbl_Prq,
			FontTable[i].ftbl_Family,
			FontTable[i].ftbl_FaceName);
	}
    #endif
}

void PrintColorTable (void)
{
	int i;

    #ifdef __PROLOG__
	IO_Writef ("COLOR TABLE:\n--------------\n");
	IO_Writef ("R\tG\tB\n");
	for (i=0;i<=ColorTableIdx;i++)
	{
                IO_Writef("%d\t%d\t%d\n",
			ColorTable[i].R,
			ColorTable[i].G,
			ColorTable[i].B);
	}
    #else
	fprintf (yyout,"COLOR TABLE:\n--------------\n");
	fprintf (yyout,"R\tG\tB\n");
	for (i=0;i<=ColorTableIdx;i++)
	{
		fprintf(yyout,"%d\t%d\t%d\n",
			ColorTable[i].R,
			ColorTable[i].G,
			ColorTable[i].B);
	}
    #endif
}

#endif
