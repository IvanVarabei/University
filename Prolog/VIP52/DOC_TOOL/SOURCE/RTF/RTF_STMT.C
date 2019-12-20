/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: RTF_STMT.C
 Purpose: RTF Parser. Statement handling
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "rtf.h"
#include "rtf_stmt.h"
#include "rtf_mem.h"
#include "rtf_form.h"
#include "rtf_font.h"
#include "rtf_foot.h"
#include "rtf_pro.h"

int stmt_nest;

void stmt_Begin (void)
{
	int Context = rtf_cur_Context();

	push_Format (&cur_Form);

	switch (Context)
	{
		case CNTX_PLAIN:
			break;
                case CNTX_IGNORED:   /* For nested statements */
                        rtf_push_Context (CNTX_IGNORED);
                        break;
		case CNTX_FONTTBL:
			rtf_push_Context (CNTX_FONTRECORD);
			CreateFontTableRecord ();
			break;
		case CNTX_FONTRECORD:
                        rtf_push_Context (CNTX_IGNORED);
                        break;
		case CNTX_FOOTNOTE:
			rtf_push_Context (CNTX_FOOTNEST);
			break;
	}
}
void stmt_End (void)
{
	int Context = rtf_pop_Context();
	FORMAT	tmp_Form;

	pop_Format (&tmp_Form);
	rev_Format (&cur_Form,&tmp_Form);

	switch (Context)
	{
		case CNTX_PLAIN:
                        rtf_push_Context(Context);
                        break;
                case CNTX_IGNORED:  /* until other context */
                        break;
		case CNTX_FONTRECORD:
			FillFontTableRecord ();
			break;
		case CNTX_FONTTBL:
			#ifdef __DEBUG_RTF__
				PrintFontTable ();
			#endif
			break;
		case CNTX_COLORTBL:
			CutLastColorTableRecord ();
			#ifdef __DEBUG_RTF__
				PrintColorTable ();
			#endif
			break;
		case CNTX_FOOTNEST:
			break;
		case CNTX_FOOTNOTE:
			MakePageAttributies ();
			ClearFootNote ();
			break;
                /*
                case CNTX_HOTSPOT:
			strncpy (cur_Link.Hotspot,FootBuff,255);
			FootBuff[0]='\0';
			break;
                */
		case CNTX_HYPERLINK:
                        MakeHyperLink ();
			FootBuff[0]='\0';
			ClearHyperLink ();
			break;
	}
}
