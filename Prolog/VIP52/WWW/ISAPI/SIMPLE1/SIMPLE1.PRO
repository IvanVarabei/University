/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  SIMPLE1
 FileName: SIMPLE1.PRO
 Purpose: This example shows how to make simple ISAPI response using
          HTML authoring predicates
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "simple1.inc"

include "types.dom"

%%  	ISAPI include files  
include "httpext.con"
include "httpext.dom"
include "httpext.pre"
include "htmlfun.pre"

%% Extension Entry Points 
CLAUSES
  http_ExtensionVersion("The Simple1 Extension").
  
  http_ExtensionProc(ECB,hse_status_success) :-
	html_CreatePage(ECB,"The Simple1 Page"),
	html_BeginHeading(ECB,2),
	html_WriteString(ECB,"This is the Simple1 HTML Page"),
	html_EndHeading(ECB,2),
	html_EndPage(ECB),!.
  http_ExtensionProc (_, hse_status_success ).

  http_TerminateExtension(_Flags,b_true).
	
GOAL
  true.
