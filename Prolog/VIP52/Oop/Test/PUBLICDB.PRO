/******************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

			Demonstrates Public database using

 ModuleName:	OBJECT & CLASSES
 FileName:	PUBLICDB.PRO
 PURPOSE:	test : load string from one object into public database another OBJECT
 Writen By :	Compiler Group

 two classes
 access from one object to another object
 loaded some strings into public database
******************************************************************************/

CLASS DestinationObject
  PREDICATES
    writeString
  FACTS
    dstDB( STRING )
ENDCLASS DestinationObject

CLASS SourceObject
  PREDICATES
  procedure new(STRING)
  procedure loadString( DestinationObject )
  FACTS
    srcDB( STRING )
ENDCLASS SourceObject


IMPLEMENT SourceObject
CLAUSES
   new( StringForLoad ):-
	write( "SourceObject: Set string to DataBase\n" ),
	assert( srcDB( StringForLoad) ).
   
   loadString( DstObj ):-
	write( "SourceObject: LoadString predicate has been started\n" ),
	srcDB( StringFromDataBase ),!,
	writef( "SourceObject: Place string <%s> to public database\n", StringFromDataBase ),
	assert( DstObj:dstDB( StringFromDataBase ) ).
   loadString( _ ).

ENDCLASS SourceObject

IMPLEMENT DestinationObject
CLAUSES
   writeString:-
	dstDB( StringFromDataBase ),!,
	writef( "String from Destination database : <%s>\n", StringFromDataBase ).
ENDCLASS DestinationObject

GOAL
  SourceObj = SourceObject::new("Source string"),
  DestinationObj = DestinationObject::new,
  SourceObj:LoadString(	DestinationObj ),
  DestinationObj:writeString,
  DestinationObj:delete,
  SourceObj:delete.
