/******************************************************************************
                Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:
 FileName: ARGTOOLS.PRO
 Purpose: Some tools for ISAPI Extension DLLs to simplify access
          to Web Server's query arguments
 Written by: PDC
 Comments:
        To start the tools call attach_query ( ECB ) , where ECB is
 bounded Extension Control Block received from server.
        Then You may call only query_argument(Name,Value)  -
 nondeterministic predicate to get and analize named arguments .
        Call clear_query() after all desired processing.
        The command line argument is automatically named as "comline" .

16.12.97 OE I seem that for ISAPI applications it is not suitable
            to store query arguments in a database, because in 
            multiuser environment they can be accidentaly
            overwriten. So, QArgs handling is rewritten using
            appropriate list of name/value pairs
            Use: get_Query_Arglist/2 for request parsing
                 http_qa_member/2 for arguments retrieving
            
******************************************************************************/
DOMAINS
  http_qa = http_qa(string,string)
  http_qa_list = http_qa*

PREDICATES
  get_Query_ArgList (EXTENSION_CONTROL_BLOCK,http_qa_list)
  parse_Query (string,http_qa_list,http_qa_list)
  nondeterm http_qa_member (http_qa,http_qa_list)
  
/*=============================================================================
                get_query( ECB, ComLine, Arg_String )
  Retrieves the string and command line sent by server
=============================================================================*/
PREDICATES
  get_query( EXTENSION_CONTROL_BLOCK, string, string )

  get_query_by_method(EXTENSION_CONTROL_BLOCK,string,string,string)

  split_arg_string(string,string,string)

CLAUSES
  get_query( ECB, ComLine, Arg_String ) :-
        % Detecting submit method  ("GET" or "POST")
        http_Method(ECB,Method),
        % Getting the string
        get_query_by_method(ECB,Method,ComLine,Arg_String).

  get_query_by_method(ECB,"GET",ComLine,Arg_String) :-
        http_QueryString(ECB,Full_Arg_String),
        split_arg_string(Full_Arg_String,ComLine,Arg_String).

  get_query_by_method(ECB,"POST",ComLine,Arg_String) :-
        http_QueryString(ECB,ComLine),
        http_DataString(ECB,Arg_String).

  split_arg_string(Full,Coml,Args) :-
        searchchar(Full,'?',QuePos),!,
                ComLen = QuePos-1 ,
                frontstr(ComLen,Full,Coml,Rest0),
                frontchar(Rest0,_,Args).
  split_arg_string(Args,"",Args).

/*=============================================================================
        nondeterm urle_argument ( Arg_String, Name, Value )
  Sequently scans the input Arg_String for Name/Value pairs
=============================================================================*/
PREDICATES
  nondeterm
  urle_argument( string, string, string )

  urle_arg( string, string, string, string )
  urle_arg_end( string, string, string )

CLAUSES

  urle_argument( ArgS , Name, Value ) :-
        urle_arg( ArgS, Name, Value , _ ).
  urle_argument( ArgS, Name, Value ) :-
        urle_arg( ArgS,_,_,RestS ), urle_argument(RestS,Name,Value).

  urle_arg( ArgS, Name, Value, Rest ) :-
        searchchar(ArgS,'=',EqPos),
        NameLen = EqPos-1 ,
        frontstr(NameLen,ArgS,Name,Rest0),
        frontchar(Rest0,_,Rest1),
        urle_arg_end(Rest1,EncodedValue,Rest),
        url_to_str(EncodedValue,Value).

  urle_arg_end(ValStr,Value,Rest) :-
        searchchar(ValStr,'&',ValEndPos),
        ValLen = ValEndPos-1,
        frontstr(ValLen,ValStr,Value,Rest0),
        frontchar(Rest0,_,Rest),
        !.
  urle_arg_end(Value,Value,"").

/*=============================================================================
        Implementation of main tools predicates
=============================================================================*/
  
  get_Query_ArgList (ECB,ArgList) :-
  	get_query( ECB,Coml,Arg_String ),
        parse_Query (Arg_String,[http_qa("comline",Coml)],ArgList),!.
  get_Query_ArgList (_,[]).
  
  parse_Query ("",Args,Args) :-!.
  parse_Query (ArgString,Buff,Args) :-
  	urle_arg( ArgString , Name, Value, Rest ),!,
  	url_to_str(Value,Value1),
  	parse_Query (Rest,[http_qa(Name,Value1)|Buff],Args).
%  parse_Query (_,Args,Args).
  
  http_qa_member (QA,[QA|_]) :-!.
  http_qa_member (QA,[_|T]) :- http_qa_member (QA,T).

                