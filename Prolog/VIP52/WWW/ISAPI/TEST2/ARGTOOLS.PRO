/******************************************************************************
                Copyright (c) 1986,97 Prolog Development Center

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
******************************************************************************/

PREDICATES
  attach_query(EXTENSION_CONTROL_BLOCK)
  nondeterm query_argument(string,string)
  clear_query()
  

/******************************************************************************
   Database for dinamic loading name/value query facts
******************************************************************************/
database - query_arguments
  q_arg(
        string ,       % Argument name
        string         % Argument value
       )


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
  decode_urle_value( EncodedString , DecodedString )
  Processes decoding of input URL-encoded string
=============================================================================*/
PREDICATES
  decode_urle_value(string,string)

  decode_urle_symbol(string,char,string)
  decode_urle_symbol(char,string,char,string)
  decode_char(char,integer)

CLAUSES

  decode_urle_value("",""):-!.
  decode_urle_value(CodedString,NormalString) :-
        decode_urle_symbol(CodedString,FrontSymb,CodedTail),
        decode_urle_value(CodedTail,NormalTail),
        frontchar(NormalString,FrontSymb,NormalTail).

  % Retrieves the first decoded symbol from the CGI string
  decode_urle_symbol(Str,Symb,RestStr) :-
        frontchar(Str,C0,Rest0),
        decode_urle_symbol(C0,Rest0,Symb,RestStr).

  decode_urle_symbol('+',Rest,' ',Rest):-!.
  decode_urle_symbol('%',Rest0,Symb,Rest) :-!,
        frontchar(Rest0,C0,Rest1),
        frontchar(Rest1,C1,Rest),
        decode_char(C0,HighQu),
        decode_char(C1,LowQu),
        AsciiCode = HighQu*16 + LowQu,
        char_int(Symb,AsciiCode).
  decode_urle_symbol(Symb,Str,Symb,Str).

  % Primitive char_to_hex convertion
  decode_char(C,HV) :-
        '0' <= C , C <= '9' ,!,
                HV = C - '0' .
  decode_char(C,HV) :-
        'A' <= C , C <= 'F' ,!,
                HV = C - 'A' + 10.
  decode_char(C,HV) :-
        'a' <= C , C <= 'f' ,!,
                HV = C - 'a' + 10.

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
        decode_urle_value(EncodedValue,Value).

  urle_arg_end(ValStr,Value,Rest) :-
        searchchar(ValStr,'&',ValEndPos),
        ValLen = ValEndPos-1,
        frontstr(ValLen,ValStr,Value,Rest0),
        frontchar(Rest0,_,Rest),
        !.
  urle_arg_end(Value,Value,"").


/*=============================================================================
        load_query_arguments( Arg_String )
 Loads the Name/Value pairs from the input string to the internal database
=============================================================================*/
PREDICATES
   load_query_arguments( string )

CLAUSES
  load_query_arguments( Arg_String ) :-
          urle_argument( Arg_String , Name, Value ),
          assertz(q_arg(Name,Value),query_arguments),
        fail.
  load_query_arguments(_).


/*=============================================================================
        Implementation of main tools predicates
=============================================================================*/

CLAUSES

  attach_query(ECB) :-
        retractall(_,query_arguments),
        get_query( ECB,Coml,Arg_String ),
        assertz(q_arg("comline",Coml),query_arguments),
        load_query_arguments( Arg_String ),
        !.
  attach_query (_) .


  query_argument( Name, Value ) :-
        q_arg(Name,Value).

  clear_query() :-
                retractall(_,query_arguments).
                