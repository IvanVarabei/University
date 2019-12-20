/******************************************************************************

                 Copyright (C) 1984 - 2000 Prolog Development Center A/S

				VISUAL PROLOG

 File name: ERRHNDL.PRO

 PURPOSE: Default clause for error handler
          that is called by Parser Library

 Written by Oleg V. Erjomin

******************************************************************************/

ifndef errHndl_Pre_Included
 #ERROR: file errhndl.pre must be included
enddef

CONSTANTS 
errHndl_Pro_included = 1

CLAUSES  
   yy_parser_error (Msg,LineNo,_CharNo) :-
	writef("Possible incorrectness at line %d: %s\n",LineNo,Msg).

