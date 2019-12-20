/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_MEM.C
 Purpose: RTF Parser. Memory handling routines
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "rtf.h"

#include "rtf_mem.h"
#include "rtf_pro.h"
#include "rtf_form.h"
#include "rtf_font.h"
#include "../common/list.h"
#include "../common/misc.h"

/*
 *  Global Buffers
 */
char PARSER_MODE;		/* The parser mode (read/parse)	*/
char *PageBuff = NULL;		/* Page text buffer      	*/
PAGEATTR cur_Page;		/* Current page Attributies     */
/*
 * Context stack made as array
 */
#define STACK_MAX_DEEP	256
static int rtf_CntxStack [STACK_MAX_DEEP];  	/* The stack  		*/
static int *rtf_CntxSP;                        	/* Next place 		*/
static void *rtf_ListStack [STACK_MAX_DEEP];	/* The list stack	*/
static void **rtf_ListSP;			/* Next place 		*/
/*
 *  Global stack saved top for iteration
 */
STACKMARK gs_Parser;
/*
 *  Init Parser internal variables
 */
void InitRTFParser (void)
{
	AllocPageBuff ();
	rtf_CntxSP = rtf_CntxStack;
	rtf_ListSP = rtf_ListStack;
	rtf_push_Context (CNTX_PLAIN);
	InitFormat ();
	InitTables ();
	gs_Parser = MEM_MarkGStack ();

}
/*
 *  Close down parser
 */
void CloseRTFParser (void)
{
   #ifdef __PROLOG__
	free (PageBuff,0xFF00);
	free (FootBuff,0xFF00);
   #else
	free (PageBuff);
	free (FootBuff);
   #endif
   ClearTables ();
}

int yywrap () {return 1;}

void AllocPageBuff (void)
{
	PageBuff=malloc(0xFF00);
	PageBuff[0]='\0';
	FootBuff=malloc(0xFF00);
	FootBuff[0]='\0';
	cur_Page.Context[0]='\0';
	cur_Page.Title[0]='\0';
	cur_Page.Keywords[0]='\0';
	cur_Page.Macro[0]='\0';
	cur_Page.BrowseSeq[0]='\0';
}
/*
 *  Add string to page buffer
 *  return FALSE if result lenght .GT. 0xFF00
 *  Check parser context
 *  If context is CNTX_IGNORED then immediately
 *  return, otherwise process text
 */
BOOL AddStrToParaBuff (char *Str)
{
    int Context = rtf_cur_Context();
    char *p1,*p2;

    FLOW_ELEMENT   *pFlow;
    FLOW_ELEMENT   *pTail;
    STRING	   pBuff;


    if (Context==CNTX_IGNORED) return TRUE;

    p1 = Str;

    if(need_Skip)
    {
	while (*p1 && isspace(*p1)) p1++;
        need_Skip = FALSE;
    };

    switch (Context)
    {
    	case CNTX_FONTRECORD:
		if ((p2=strchr(p1,';'))!=0)
		{
            		int FaceNameLen = p2-p1;
			if (FaceNameLen>=LF_FACESIZE-1) FaceNameLen=LF_FACESIZE-1;
			strncpy (tmp_FontRec.ftbl_FaceName,p1,FaceNameLen);
            		tmp_FontRec.ftbl_FaceName[FaceNameLen]='\0';
            	}
            	else strcpy (tmp_FontRec.ftbl_FaceName,p1);
    		return TRUE;
	case CNTX_COLORTBL:
		if (strcmp(p1,";")==0)
		{
			FillColorTableRecord ();
			CreateColorTableRecord ();
		}
		return TRUE;
	case CNTX_FOOTNEST:
	case CNTX_FOOTNOTE:
        //case CNTX_HOTSPOT:
	case CNTX_HYPERLINK:
		strcat (FootBuff,p1);
		return TRUE;
        case CNTX_HOTSPOT:
		WriteFontCode ();
                pFlow = galloc (sizeof(FLOW_ELEMENT));
                pFlow->fno = flow_element_txt;
                pFlow->u.txt = galloc ((strlen(p1)+1)*sizeof(char));
                strcpy (pFlow->u.txt,p1);
                list_AddTail (rtf_cur_List(),pFlow);
                return TRUE;
	default:
		WriteFontCode ();
		{
			pTail = (FLOW_ELEMENT*)list_GetTail(rtf_cur_List());
			if ( pTail && pTail->fno == flow_element_txt )
			{
				pBuff = galloc ((strlen(pTail->u.txt)+
					 	strlen(p1)+2)*
				 		sizeof(char));
				sprintf (pBuff,"%s%s",pTail->u.txt,p1);
				pTail->u.txt = pBuff;
			}
			else
			{
				pFlow = galloc (sizeof(FLOW_ELEMENT));
				pFlow->fno = flow_element_txt;
				pFlow->u.txt = galloc ((strlen(p1)+1)*sizeof(char));
				strcpy (pFlow->u.txt,p1);
				list_AddTail (rtf_cur_List(),pFlow);
			}
		}
		/*
		if (strlen(ParaBuff)+strlen(p1)>0xFF00) return FALSE;
                else
                {
                        strcat (ParaBuff,p1);
                }
		*/
		return TRUE;
	}
}
/*
 *  Add paragraph to page buffer
 *  Convert paragraph if needed
 *  Clean up paragraph buffer
 */
/*
BOOL AddParaToPage ()
{
        char    *Buff;

	if (strlen(PageBuff)+strlen(ParaBuff)>0xFF00) return FALSE;
	else
	{
                if((Buff = malloc (0xFF00))==NULL)
			rtf_parser_error ("failed to allocate paragraph buffer");
                rtf_Paragraph (Buff);
                strcat (PageBuff,Buff);
	   #ifdef __PROLOG__
		free (Buff,0xFF00);
	   #else
		free (Buff);
	   #endif
		ParaBuff[0]='\0';
		return TRUE;
	}
}
*/
/*
 *  Clean up page buffer
 *
 */
void clear_Page (void)
{
	//AddParaToPage ();

	PageBuff [0] = '\0';
	cur_Page.Context[0]='\0';
	cur_Page.Title[0]='\0';
	cur_Page.Keywords[0]='\0';
	cur_Page.Macro[0]='\0';
	cur_Page.BrowseSeq[0]='\0';
}

/*
 *  Context stack handling (push, pop, current)
 */
void rtf_push_Context (int Cntx)
{
	if (rtf_CntxSP>=&rtf_CntxStack[STACK_MAX_DEEP])
		yyerror ("context stack is too deep");
	*rtf_CntxSP++=Cntx;
}

int rtf_pop_Context (void)
{
	if (rtf_CntxSP==rtf_CntxStack)
		yyerror ("context stack underflow");
	return *--rtf_CntxSP;
}

int rtf_cur_Context (void)
{
	if (rtf_CntxSP==rtf_CntxStack) return CNTX_ERROR;
	return *(rtf_CntxSP-1);
}

/*
 *  List stack handling (push, pop, current)
 */
void rtf_push_List (void *List)
{
	if (rtf_ListSP>=&rtf_ListStack[STACK_MAX_DEEP])
		yyerror ("list stack is too deep");
	*rtf_ListSP++=List;
}

void *rtf_pop_List (void)
{
	if (rtf_ListSP==rtf_ListStack)
	{
		// yyerror ("list stack underflow");
		return NULL;
	}
	return *--rtf_ListSP;
}

void *rtf_cur_List (void)
{
	if (rtf_ListSP==rtf_ListStack) return NULL;
	return *(rtf_ListSP-1);
}

/*
 *  Error handler. This routine is called from Lex/Yacc generated
 *  scanner/parser. It calls the user defined predicate "yy_parser_error"
 */

void yyerror (char *ErrMsg)
{
	yy_parser_error (ErrMsg,yylineno,yycharno);
}

