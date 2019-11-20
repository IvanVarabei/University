/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: ATTS.C
 Purpose: 
 Written by: 
 Comments:
******************************************************************************/
#ifdef __TURBOC__
  #include "config.h"
  #include "docstr.h"
  #include "common/y_pdcdef.h"
  #include "atts.h"
  #include "misc.h"
#else
  #include "../config.h"
  #include "../docstr.h"
  #include "y_pdcdef.h"
  #include "atts.h"
  #include "misc.h"
#endif

ATT *CreateAttribute (char *Name,char Type,char *Str,int Num)
{
	ATT    *pAtt;

	pAtt = (ATT*)galloc(sizeof(ATT));
	pAtt->fno = att_att;

	pAtt->Name = galloc(strlen(Name)+1);
	strcpy_toupper(pAtt->Name,Name);
	switch ( Type )
	{
		case attval_nill:
			pAtt->Val=CreateNillAttVal ();
			break;
		case attval_atom:
			pAtt->Val=CreateAtomAttVal(Str);
			break;
		case attval_lit :
			pAtt->Val=CreateLitAttVal(Str);
			break;
		case attval_num :
			pAtt->Val=CreateNumAttVal(Num);
			break;
	}
	return pAtt;
}


/*
 *  Create various types of tag attributies values
 *     literal; atom; numeric; nill
 */
ATTVAL *CreateLitAttVal (char *Lit)
{
	ATTVAL  *pVal;

	pVal = (ATTVAL*) galloc (sizeof(ATTVAL));
	pVal->fno=(unsigned char)attval_lit;
	pVal->u.lit=galloc(strlen(Lit)+1);
	strcpy(pVal->u.lit,Lit);

	return pVal;
}

ATTVAL *CreateAtomAttVal (char *Atom)
{
	ATTVAL  *pVal;

	pVal = (ATTVAL*) galloc (sizeof(ATTVAL));
	pVal->fno=(unsigned char)attval_atom;
	pVal->u.lit=galloc(strlen(Atom)+1);
	strcpy(pVal->u.atom,Atom);

	return pVal;
}

ATTVAL *CreateNumAttVal (int Num)
{
	ATTVAL  *pVal;

	pVal = (ATTVAL*) galloc (sizeof(ATTVAL));
	pVal->fno=(unsigned char)attval_num;
	pVal->u.num=Num;

	return pVal;
}

ATTVAL *CreateNillAttVal (void)
{
	ATTVAL  *pVal;

	pVal = (ATTVAL*) galloc (sizeof(ATTVAL));
	pVal->fno=(unsigned char)attval_nill;

	return pVal;
}

