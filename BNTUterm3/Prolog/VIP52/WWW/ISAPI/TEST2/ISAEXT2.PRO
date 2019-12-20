/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  ISAEXT2	
 FileName: ISAEXT2.PRO
 Purpose: ISAPI Extension DLL Testing + HTML/DOC conversion 
 Written by: Serge Verkhovtsev
 Comments: 
    The program shows the different information corresponding to each
 server request -
    Server Variables, 
    Fields of Extension Control Block, 
    Request Arguments .    
--------------


   The following is the source code for ISAPITST.DEF module. When You'll create
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
include "docstr.dom"
include "httpext.pre"
include "htmlfun.pre"
include "html.pre"
include "html.pro"
include "errhndl.pre"
include "errhndl.pro"
include "argtools.pro"

constants
  bodyelem = doc_flow_element

%==============================================================================
%
%		Page Heading
%
%==============================================================================
PREDICATES
  page_main_head( bodyelem )
  
CLAUSES
  
  page_main_head( heading(1,[],[txt("The ISAPI Test Information Page")]) ).
  

%==============================================================================
%	page_menu
%  Creates BookMark Menu on the output Page
%==============================================================================
PREDICATES
  page_menu( bodyelem , bodyelem )
  
CLAUSES

  page_menu( heading(2,[],[a([doc_att("NAME",atom("Menu"))],[]),txt("Menu")]) , 
             a([],[
             br,br,
             txt("The following item shows the results of "),
             txt("http_GetServerVariable predicate calls"),br,
             a([doc_att("HREF",atom("#Variables"))],[txt("Server Variables")]),
             br,br,
      
             txt("The following item shows the results of "),
             txt("calls to different http_... predicates "),
             txt("giving access to the EXTENSION CONTROL BLOCK "),
             txt("Fields"),br,
             a([doc_att("HREF",atom("#Fields"))],[txt("Control Block Fields")]),
             br,br,
      
             txt("The following item shows the results of "),
             txt("\"ArgTools.pro\" module working"), br,
             a([doc_att("HREF",atom("#Arguments"))],[txt("Request Arguments")]),
	     br,br,             
      
             txt("Back to calling page"),br,
             a([doc_att("HREF",atom("isaext2.htm"))],[txt("Home")]),
             br,br,br
                  ]) ).
  

%==============================================================================
%	server_variables
%  Creates Report about Server Variables
%============================================================================== 
PREDICATES
  server_variables( EXTENSION_CONTROL_BLOCK, bodyelem, bodyelem )
  
  gather_variables( EXTENSION_CONTROL_BLOCK, slist , slist )
  make_varinfo(slist,slist,doc_flow)
    
CLAUSES

  server_variables( ECB, heading(3,[],[a([doc_att("NAME",atom("Variables"))],[]),txt("The Server Variables")]), 
                    a([],[br|VarInfo]) ) :-
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
    make_varinfo(NList,VList,VarInfo).
                    

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
  %  Generates Server Variables Info
  %
  make_varinfo([],[],[
                      br,a([doc_att("HREF",atom("#Menu"))],[txt("Menu")]),br,br,br
                     ]):-!.
  make_varinfo([N|NT],[V|VT],[b(1),txt(NS),b(0),var(1),txt(V),var(0),br|VIT]) :-
      concat(N," = ",NS),
      make_varinfo(NT,VT,VIT).


%==============================================================================
%	control_fields
%  Creates Report about EXTENSION CONTROL BLOCK FIELDS
%==============================================================================      
PREDICATES
  control_fields( EXTENSION_CONTROL_BLOCK,bodyelem, bodyelem )
  
CLAUSES
  control_fields( ECB, heading(3,[],[a([doc_att("NAME",atom("Fields"))],[]),txt("Control Block Fields")]), 
                  a([],[
     br,
     b(1),txt("Connection Id : "),b(0),var(1),txt(SConnId),var(0),br,
     b(1),txt("Method : "),b(0),var(1),txt(Method),var(0),br,
     b(1),txt("Query String : "),b(0),var(1),txt(QS),var(0),br,
     b(1),txt("Content Type : "),b(0),var(1),txt(CTS),var(0),br,
     b(1),txt("Content Length  ( == TotalBytes ) : "),b(0),var(1),txt(SCL),var(0),br,
     b(1),txt("Available Bytes : "),b(0),var(1),txt(SAB),var(0),br,
     b(1),txt("User data in BINARY form : "),b(0),var(1),txt(SBD),var(0),br,
     b(1),txt("User data in STRING form : "),b(0),var(1),txt(SBD1),var(0),br,
     br,a([doc_att("HREF",atom("#Menu"))],[txt("Menu")]),br,br,br
                       ]) ) :-
    ConnId = http_ConnId(ECB),
    str_int(SConnId,ConnId),
    http_Method (ECB,Method),
    http_QueryString (ECB,QS),
    http_ContentType (ECB,CTS),
    CL = http_ContentLength (ECB),
    str_int(SCL,CL),
    AB = http_AvailableBytes (ECB),
    str_int(SAB,AB),
    http_Data (ECB , BD ),
    term_str(binary,BD,SBD),
    http_DataString (ECB,SBD1).
  
  

%==============================================================================
%	request_arguments
%  Creates Report about Request Arguments using ArgTools predicates
%==============================================================================        
PREDICATES
  request_arguments( EXTENSION_CONTROL_BLOCK, bodyelem, bodyelem )
  
CLAUSES
  request_arguments( ECB, heading(3,[],[a([doc_att("NAME",atom("Arguments"))],[]),txt("Request Arguments")]), 
                    a([],[br|ArgInfo]) ) :-
	attach_query(ECB),
	findall(N,query_argument(N,_),NL),
	findall(V,query_argument(_,V),VL),
	clear_query(),
	make_varinfo(NL,VL,ArgInfo).



%==============================================================================
%	page_body
%  Creates the full document body 
%==============================================================================        
PREDICATES
  page_body(EXTENSION_CONTROL_BLOCK,doc_body)

CLAUSES
  page_body(ECB,doc_body([],[ 
  	MainHead,hr([]),
  	MenuHead,Menu,hr([]),
  	VarHead,Variables,hr([]),
  	FieldsHead,Fields,hr([]),
  	ArgumentsHead,Arguments
  	   ])) :-
      page_main_head( MainHead ),
      page_menu( MenuHead , Menu ),
      server_variables( ECB, VarHead, Variables ),
      control_fields( ECB, FieldsHead, Fields ),
      request_arguments( ECB, ArgumentsHead, Arguments ).



  
%==============================================================================
%
%   Extension Entry Points
%
%==============================================================================  
CLAUSES

 http_ExtensionVersion ( "ISAPI Testing - Try with Doc Domains" ).

 http_ExtensionProc ( ECB , hse_status_success ) :-
     html_CreatePage(ECB,"The ISAPI Test Information Page"),
     page_body( ECB, doc_body(Attlist,Flow) ),
     make_CloseBlock ("","BODY",Attlist,Flow,DocBody),
     1 = http_WriteClientString(ECB,DocBody,_),
        html_EndPage(ECB),!.
 http_ExtensionProc ( _ , hse_status_error ).		

 http_TerminateExtension(_Flags,b_true).
 
 


%==============================================================================
%     GOAL
% We do nothing here .
%==============================================================================
GOAL
  true .

