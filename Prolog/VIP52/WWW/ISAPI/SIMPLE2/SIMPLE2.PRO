/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  SIMPLE2
 FileName: SIMPLE2.PRO
 Purpose: This example shows how to make simple ISAPI response using 
          Extension  predicates.
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "simple2.inc"

include "types.dom"

%%  	ISAPI include files  
include "httpext.con"
include "httpext.dom"
include "httpext.pre"

/*-----------------------------------------------------------------------------
     send_response_header(ECB)
     ISAPI extension must send the complete response header appended by
  "Content-type". This predicate do it. Fails on error.
-----------------------------------------------------------------------------*/
PREDICATES
  send_response_header( EXTENSION_CONTROL_BLOCK )
  
CLAUSES
  send_response_header( ECB ) :-
    	Data = cast(string,0) ,		% NULL pointer
	DataType = "Content-type: text/html\r\n",
  	str_len(DataType,BytesToSend),
	Retc = http_ServerSupportFunction (
			ECB,
			hse_req_send_response_header ,
			BytesToSend,
			Data,
			DataType,
			_BytesWritten	   ),
	1 = Retc.


/*-----------------------------------------------------------------------------
	send_response_page( ECB )
	Dynamic HTML page creation.
-----------------------------------------------------------------------------*/
PREDICATES
  send_response_page( EXTENSION_CONTROL_BLOCK )
  
CLAUSES
  send_response_page( ECB ) :-
	http_WriteClientString(
		ECB,
		"<HTML>\r\n\r\n<HEAD><TITLE>Simple2 Extension</TITLE><HEAD>\r\n\r\n",
		_ ),
	http_WriteClientString(ECB,"<BODY>\r\n",_),
	http_WriteClientString(ECB,"<H2>",_),
	Mess1 = "This is Simple2 Extension Response Page",
	http_WriteClientString(ECB,Mess1,_),	
	http_WriteClientString(ECB,"</H2>",_),
	http_WriteClientString(ECB,"</BODY>\r\n",_),
	http_WriteClientString(ECB,"</HTML>\r\n",_).    


/*-----------------------------------------------------------------------------

	Extension entry points : 
			http_ExtensionVersion
			http_ExtensionProc

-----------------------------------------------------------------------------*/
CLAUSES

  % Version description
  http_ExtensionVersion("Simple2 Extension").

  % Request Processing   
  http_ExtensionProc(ECB,hse_status_success) :-
        send_response_header(ECB),!,
           send_response_page(ECB).
  http_ExtensionProc(_,hse_status_error).

  http_TerminateExtension(_Flags,b_true).


GOAL
  true.
 
