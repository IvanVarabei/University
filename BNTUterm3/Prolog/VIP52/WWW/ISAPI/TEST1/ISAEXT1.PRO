/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  ISAEXT1	
 FileName: ISAEXT1.PRO
 Purpose: ISAPI Extension DLL Testing
 Written by: Serge Verkhovtsev
 Comments: 
    The program shows the different information corresponding to each
 server request -
    Server Variables, 
    Fields of Extension Control Block, 
    Request Arguments .
    
--------------


   The following is the source code for ISAEXT1.DEF module. When You'll create
the new project to build ISAPI Extension DLL don't forget to include 
"GetExtensionVersion"  and  "HttpExtensionProc" function names into "EXPORTS"
section of definition module.
--------------   
LIBRARY ISAPITST

CODE      PRELOAD MOVEABLE DISCARDABLE
DATA      PRELOAD SINGLE

HEAPSIZE  1000000

EXPORTS
GetExtensionVersion
HttpExtensionProc
TerminateExtension
--------------
    
******************************************************************************/

include "types.dom"

include "httpext.con"
include "httpext.dom"
include "httpext.pre"
include "htmlfun.pre"

include "argtools.pro"


%==============================================================================
%  New Line , New Line * 2 and New Line * 3
%==============================================================================

PREDICATES
  hnl( EXTENSION_CONTROL_BLOCK )
  hnl2( EXTENSION_CONTROL_BLOCK )
  hnl3( EXTENSION_CONTROL_BLOCK )
  
CLAUSES
  
  hnl(ECB) :- html_LineBreak(ECB).
  
  hnl2(ECB) :-
  	html_LineBreak(ECB),
  	html_LineBreak(ECB).
  
  hnl3(ECB) :-
  	html_LineBreak(ECB),
  	html_LineBreak(ECB),
  	html_LineBreak(ECB).


%==============================================================================
%	page_menu(ECB)
%  Creates BookMark Menu on the output Page
%==============================================================================
PREDICATES
  page_menu( EXTENSION_CONTROL_BLOCK )
  
CLAUSES
  page_menu( ECB ) :-      
      html_Heading(ECB,1,"The ISAPI Test Information Page"),
      html_HorizontalRule(ECB),
      
      html_SetBookMark(ECB,"Menu"),
      html_Heading(ECB,2,"Menu"), hnl(ECB),
      
      html_WriteString(ECB,"The following item shows the results of "),
      html_WriteString(ECB,"http_GetServerVariable predicate calls"),
      hnl(ECB),
      html_BookMarkLink(ECB,"Variables","Server Variables"),
      hnl2(ECB),  
      
      html_WriteString(ECB,"The following item shows the results of "),
      html_WriteString(ECB,"calls to different http_... predicates "),
      html_WriteString(ECB,"giving access to the EXTENSION CONTROL BLOCK "),
      html_WriteString(ECB,"Fields"), 
      hnl(ECB),
      html_BookMarkLink(ECB,"Fields","Control Block Fields"), 
      hnl2(ECB),
      
      html_WriteString(ECB,"The following item shows the results of "),
      html_WriteString(ECB,"\"ArgTools.pro\" module working"), 
      hnl(ECB),
      html_BookMarkLink(ECB,"Arguments","Request Arguments"), 
      hnl2(ECB),
      
      html_WriteString(ECB,"Back to calling page"),
      hnl(ECB),
      html_HyperLink(ECB,"isaext1.htm","Home"),
      html_HorizontalRule(ECB),
      hnl3(ECB).
      

%==============================================================================
%	server_variables(ECB)
%  Creates Report about Server Variables
%============================================================================== 

PREDICATES
  server_variables( EXTENSION_CONTROL_BLOCK )
  
  gather_variables( EXTENSION_CONTROL_BLOCK , slist , slist )
  show_variables(EXTENSION_CONTROL_BLOCK,slist,slist)
  
CLAUSES

  server_variables( ECB ) :-
    html_SetBookMark(ECB,"Variables"),
    html_Heading(ECB,3,"The Server Variables"),
    hnl(ECB),
    NList = [           % The List of Possible Server Variables
      	"AUTH_TYPE",
      	"CONTENT_LENGTH",
      	"CONTENT_TYPE",
      	"GATEWAY_INTERFACE",
      	"PATH_INFO",
      	"PATH_TRANSLATED",
      	"QUERY_STRING",
      	"REMOTE_ADDR",
      	"REMOTE_HOST",
      	"REMOTE_USER",
      	"REQUEST_METHOD",
      	"SCRIPT_NAME",
      	"SERVER_NAME",
      	"SERVER_PORT",
      	"SERVER_PROTOCOL",
      	"SERVER_SOFTWARE",
      	"AUTH_PASS",
      	"ALL_HTTP",
      	"HTTP_ACCEPT"
              ],
    gather_variables(ECB,NList,VList),
    show_variables(ECB,NList,VList),
    hnl(ECB),  
    html_BookMarkLink(ECB,"Menu","Menu"),
    html_HorizontalRule(ECB),
    hnl3(ECB).


  %
  %  Gathers Server Variables Values
  %
  gather_variables(_,[],[]):-!.
  gather_variables( ECB , [Name|NT] , [Var|VT] ) :-
  		Retc = http_GetServerVariable(ECB,Name,Var),
  		Retc = 1,!,
  			gather_variables(ECB,NT,VT).
  gather_variables( ECB , [_|NT] , ["No value"|VT] ) :-
  			gather_variables(ECB,NT,VT).

  %
  %  Shows Server Variables Info
  %
  show_variables(_,[],[]):-!.
  show_variables(ECB,[N|NT],[V|VT]) :-
      concat(N," = ",NS),
  		html_Bold(ECB,NS),
  		html_BeginVariable(ECB),
  		html_WriteText(ECB,V),
  		html_EndVariable(ECB),
  		html_EndParagraph(ECB),
  		show_variables(ECB,NT,VT).


%==============================================================================
%	server_fields(ECB)
%  Creates Report about EXTENSION CONTROL BLOCK FIELDS
%==============================================================================      
PREDICATES
  server_fields( EXTENSION_CONTROL_BLOCK )
  
  show_field( EXTENSION_CONTROL_BLOCK, STRING, STRING )

CLAUSES
  server_fields( ECB ) :-
    html_SetBookMark(ECB,"Fields"),
    html_Heading(ECB,3,"Control Block Fields"),
    hnl(ECB),
    
    ConnId = http_ConnId(ECB),
    str_int(SConnId,ConnId),
    show_field(ECB,"Connection Id",SConnId),

    http_Method (ECB,Method),
    show_field(ECB,"Method",Method),
    
    http_QueryString (ECB,QS),
    show_field(ECB,"Query String",QS),

    http_ContentType (ECB,CTS),
    show_field(ECB,"Content Type",CTS),

    CL = http_ContentLength (ECB),
    str_int(SCL,CL),
    show_field(ECB,"Content Length  ( == TotalBytes )",SCL),

    AB = http_AvailableBytes (ECB),
    str_int(SAB,AB),
    show_field(ECB,"Available Bytes",SAB),

    http_Data (ECB , BD ),
    term_str(binary,BD,SBD),
    show_field(ECB,"User data in BINARY form",SBD),

    http_DataString (ECB,SBD1),
    show_field(ECB,"User data in STRING form",SBD1), 
    
    hnl(ECB),  
    html_BookMarkLink(ECB,"Menu","Menu"),
    html_HorizontalRule(ECB),
    hnl3(ECB).


  show_field( ECB, FieldName, FieldValue ) :-
        concat(FieldName," : ",FNS),
  	html_Bold(ECB,FNS),
  	html_BeginVariable(ECB),
  	html_WriteText(ECB,FieldValue),
  	html_EndVariable(ECB),
  	html_EndParagraph(ECB).


%==============================================================================
%	request_arguments(ECB)
%  Creates Report about Request Arguments using ArgTools predicates
%==============================================================================      
PREDICATES
  request_arguments( EXTENSION_CONTROL_BLOCK )
  
  show_arguments( EXTENSION_CONTROL_BLOCK )

CLAUSES

  request_arguments(ECB) :-
    	html_SetBookMark(ECB,"Arguments"),
    	html_Heading(ECB,3,"Request Arguments"),
    	hnl(ECB),
    	attach_query(ECB),
    	show_arguments(ECB),
    	clear_query(),
    	hnl(ECB),
    	html_BookMarkLink(ECB,"Menu","Menu"),
    	html_HorizontalRule(ECB).      
	    

  show_arguments(ECB) :-
  	query_argument(Name,Value),
  	  show_field(ECB,Name,Value),
  	fail.
  show_arguments(_).  	



%==============================================================================
%	fill_page(ECB)
%  Complexly Filles the Output Page.
%==============================================================================      
PREDICATES
  fill_page ( EXTENSION_CONTROL_BLOCK )
  
CLAUSES

  fill_page ( ECB ) :-
      page_menu ( ECB ) , 
      server_variables(ECB),
      server_fields(ECB),
      request_arguments(ECB).


%==============================================================================
%
%   Extension Entry Points
%
%==============================================================================
CLAUSES

 http_ExtensionVersion ( "ISAPI Testing - First Try" ).


 http_ExtensionProc ( ECB , hse_status_success ) :-
     html_CreatePage( ECB, "The ISAPI Test Information Page" ) ,
     fill_page(ECB),
     html_EndPage(ECB),!.
 http_ExtensionProc ( _ , hse_status_error ).		


 http_TerminateExtension(_Flags,b_true).

%==============================================================================
%     GOAL
% We do nothing here .
%==============================================================================
GOAL
  true .

