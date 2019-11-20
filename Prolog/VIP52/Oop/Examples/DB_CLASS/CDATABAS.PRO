/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  DB_CLASS
 FileName: CDATABASE.PRO
 Purpose: Sample Implementation of CDatabase class
 Written by: Oleg V. Erjomin
 Comments: Implementation of cDatabase & cRecordset
******************************************************************************/
ifndef cDatabase_Dom_Included
 #ERROR: file cdatabas.dom must be included
enddef
ifndef sqlbind_Pre_Included
 #ERROR: file sqlbind.pre must be included
enddef

/******************************************************
   cDatabase implementation
******************************************************/
  
IMPLEMENT cDatabase
  % private facts
  FACTS
     single db_error (INTEGER)
     single connectInfo (STRING DSN, STRING UID, STRING PASSWORD)
     % recordsets (CRecordset)
  
  CLAUSES
        % internal facts initialization
        m_hdbc(0).
        db_error (0).
        connectInfo ("","","").
        %
        % destructor (calls the destructor for all connected recordsets)
        %
        %delete :-
        %	recorsets (RS),
        %		sql_Drop (RS),
        %	fail.
        %delete.
        %
        % opens the database
        %
  	open (_,_,_,0) :- isOpen,!.
  	open (DSN,UID,PASSWORD,1) :-
  		trap(HDBC=sql_Connect(DSN,UID,PASSWORD),Err,assert(db_error(Err))),!,
  		assert(m_hdbc(HDBC)),
  		assert(connectInfo(DSN,UID,PASSWORD)).
  	open (_,_,_,0).
  	% closes the opened database
  	close :-
  		m_hdbc(HDBC),
  		trap(sql_Disconnect(HDBC),_,fail).
  	%
  	% directly executes the SQL statement
  	%
  	executeSQL (SQL) :-
  		m_hdbc(HDBC),
  		dlg_Note("SQL Statement",SQL),
  		trap(HSTMT=sql_Exec(HDBC,SQL),Err,assert(db_error(Err))),!,
   		trap(sql_Drop(HSTMT),_,fail).
   	executeSQL (_) :-
   		db_Error(E),
   		write("E:",E),nl.
   	%
   	% completes the transaction
   	%
   	commitTrans :-
   		m_hdbc(HDBC),
   		trap(sql_Commit(HDBC),_,fail),!.
   	commitTrans.
   	%
   	% reverses changes made during current transaction
   	%
   	rollBack :-
   		m_hdbc(HDBC),
   		trap(sql_RollBack(HDBC),_,fail),!.
   	rollBack.
   	%
  	% returns the connection information
  	getConnect (DSN,UID,PASSWORD) :- connectInfo (DSN,UID,PASSWORD).
  	% TRUE if the database open
  	isOpen :- m_hdbc(HDBC),HDBC<>0.
  	% returns last error
  	getError(ERR) :- db_Error(ERR).
  	% add recordset to the internal database
  	% addRecordset(RS) :-
  	%	assert(recordsets(RS)).

ENDCLASS

/******************************************************
    cRecordset implementation
******************************************************/
CONSTANTS
   rs_mode_view = 0
   rs_mode_edit = 1
   rs_mode_add  = 2
   rs_mode_del  = 3
IMPLEMENT cRecordset
   % private facts
   FACTS
   	single m_hdbc(DBC_HANDLE)
   	single m_TableName (STRING)
   	single rs_error(INTEGER)
   	single rs_errmsg(STRING)
   	fields (STRING Name, USHORT ColNum, COL_TYPE Type, SDWORD Width, COL_DATA)
   	copyfields (STRING Name, USHORT ColNum, COL_TYPE Type, SDWORD Width, COL_DATA)
   	single rs_mode(INTEGER)
   	single strBuff1(STRING)
   	single strBuff2(STRING)
   	single strWhere(STRING)
   PREDICATES
   	%isDBOpen
   	getSetStructure (STMT_HANDLE,USHORT,USHORT)
   	rs_errhndl (INTEGER ERRNO)
   	try_fetch_first_record (STMT_HANDLE)
   	fill_record_buffer (STMT_HANDLE,USHORT,USHORT)
   	buildSelectSQL (STRING UserSQL, STRING QuerySQL)
   	buildFieldClause (STRING)
   	buildWhereClause (STRING)
   	buildOrderByClause (STRING)
   	buildInsertSQL (STRING)
   	buildUpdateSQL (STRING)
   	buildDeleteSQL (STRING)
   	buildWhereClauseForUpdateDelete (STRING)
   	nondeterm rs_member (STRING,SLIST)
   	rs_reverse (SLIST,SLIST,SLIST)
   	rs_slist_str (SLIST,STRING,STRING)
   	addBrakets (STRING, STRING)
   	get_ValueListForUpdate (STRING)
   	get_ValueListForInsert (STRING, STRING)
   	format_DataStr (COL_DATA, STRING)
   	eraseLastComma (STRING, STRING)
   	storeFields
   	loadFields
   CLAUSES
   	% internal facts initializing
   	m_hdbc(0).
   	m_hstmt(0).
   	m_nFields(0).
   	m_strFilter("").
   	m_strSort("").
   	m_TableName("").
   	rs_error(0).
   	rs_errmsg("").
   	rs_mode(rs_mode_view).
   	strBuff1("").
   	strBuff2("").
   	strWhere("").
   	% constructor
   	new (TheDB) :-
   		TheDB:m_hdbc(HDBC),!,
   		assert(m_hdbc(HDBC)),
   		retractall(m_Database(_)),
   		assert(m_Database(TheDB)).
   	new (_) :-
   		assert(rs_error(err_recordset_database_notopen)).
   	%  destructor
   	delete :-
   		m_hstmt(HSTMT),
   		trap(sql_Drop(HSTMT),ERR,rs_errhndl(ERR)),!.
   	delete.
   %---------------------------------------------------------------
   %   Public clauses
   %---------------------------------------------------------------
   	% opens the recordset
   	open (_,0) :- isOpen,!.
   	open (SQL,1) :-
   		%isDBOpen,
   		m_hdbc(HDBC),
   		buildSelectSQL (SQL,SELSQL),
   		trap(HSTMT=sql_Exec(HDBC,SELSQL),Err,assert(rs_error(Err))),!,
   		try_fetch_first_record (HSTMT),
   		assert(rs_mode(rs_mode_view)),
   		assert(m_hstmt(HSTMT)),
   		NCols = sql_NumCols(HSTMT),
   		assert(m_nFields(NCols)),
   		retractall (fields(_,_,_,_,_)),
	   	getSetStructure (HSTMT,1,NCols).
   	open (_,0).
   	% closes the recordset
   	close :-
   		m_hstmt(HSTMT),
   		sql_Close(HSTMT).
   	%
   	% requery the recordset
   	%
   	requery :-
		m_hstmt(HSTMT),
		sql_Close(HSTMT),
		trap(sql_ExecStmt(HSTMT),Err,assert(rs_error(Err))),!,
   		try_fetch_first_record (HSTMT),
   		m_nFields(N),
  		fill_record_buffer (HSTMT,1,N).
   	%	
  	% error handling
  	%
  	rs_errhndl (ERRNO) :-
  		m_hdbc(HDBC),
  		m_hstmt(HSTMT),
  		ErrMsg = sql_ErrorMsg (HDBC,HSTMT,_),
  		dlg_Error (ErrMsg),
  		assert (rs_Error(ERRNO)),
  		assert (rs_ErrMsg(ErrMsg)).
  		
  	getError(ERR) :- rs_Error(ERR).
  	getErrorMsg(Msg) :- rs_ErrMsg(Msg).
  	% TRUE if the recordset is open
  	isOpen :- m_hstmt(H),H<>0.
  	% fetch the next row in the recordset
  	% fails at the end of the set
  	moveNext :-
  		isOpen,
  		m_hstmt(HSTMT),
  		sql_FetchNext(HSTMT),
  		m_nFields(N),
  		fill_record_buffer (HSTMT,1,N),
  		assert (rs_mode(rs_mode_view)).
  	%
  	% fill the current record buffer with null value and marks it as new
  	%
  	addNew :- 
  		storeFields,
  		retractall (fields(_,_,_,_,_)),
  		copyfields(Name,ColNum,Type,Width,_Data),
  		asserta(fields(Name,ColNum,Type,Width,null_value)),
  		fail.
  	addNew :- assert(rs_mode(rs_mode_add)).
  	%
  	% marks the current record as edited
  	%
  	edit :- 
  		buildWhereClauseForUpdateDelete(Where),
  		assert(strWhere(Where)),
  		assert(rs_mode(rs_mode_edit)).
  	%
  	% Completes the AddNew or Edit operations
  	%
  	update :-
  		rs_mode(rs_mode_add),!,
  		buildInsertSQL(SQL),
		loadFields,
		m_Database(DB),
		DB:executeSQL(SQL),
  		assert(rs_mode(rs_mode_view)).
  	update :-
  		rs_mode(rs_mode_edit),!,
  		buildUpdateSQL(SQL),
  		m_Database(DB),
		DB:executeSQL(SQL),
  		assert(rs_mode(rs_mode_view)).
  	update.
  	%
  	%  Deletes the current record
  	%
  	erase :-
  		rs_mode(rs_mode_view),!,
  		buildDeleteSQL(SQL),
  		m_Database(DB),
		DB:executeSQL(SQL).
  	erase.
  	%
  	%  getFiled - retrieves data from the current record
  	%
  	getFieldbyName (Name, Data)  :-	fields (Name,_,_,_,Data),!.
  	getFieldbyNum (ColNum, Data) :- fields (_,ColNum,_,_,Data),!.
  	
  	setFieldbyName (Name, Data) :- 
  		retract(fields (Name,Num,Type,Width,_)),!,
  		assert (fields (Name,Num,Type,Width,Data)).
  	setFieldbyNum (ColNum, Data) :- 
  		retract(fields (Name,ColNum,Type,Width,_)),!,
  		assert (fields (Name,ColNum,Type,Width,Data)).
  	%
  	get_field (Num,Name,Type,Width) :- fields (Name,Num,Type,Width,_),!.
  	get_nFields (N) :- m_nFields (N).
  	%
  	%  returns the list of fields included in a query
  	%  by default, returns [], to include all fields
  	%  User can override this clause in the derived class
  	%
  	get_FieldList (FL) :- FL=[].
  	set_Filter (Filter) :-
  		assert(m_strFilter(Filter)).
  % ----------------------------------------------------------------
  %  Private clauses
  %-----------------------------------------------------------------
  	%isDBOpen :- m_hdbc(HDBC),HDBC<>0.
  	%
  	%  fills the private database with the Recordset structure
  	%
  	getSetStructure (HSTMT,NCols,NCols) :-!,
  		Name = sql_ColName (HSTMT,NCols),
  		Type = sql_ColType (HSTMT,NCols),
  		Width = sql_ColWidth (HSTMT,NCols),
  		Data = sql_GetColData (HSTMT,NCols),
  		assert (fields(Name,NCols,Type,Width,Data)),!.
  	getSetStructure (HSTMT,CurCol,NCols) :-
  		Name = sql_ColName (HSTMT,CurCol),
  		Type = sql_ColType (HSTMT,CurCol),
  		Width = sql_ColWidth (HSTMT,CurCol),
  		Data = sql_getColData (HSTMT,CurCol),
  		NextCol = CurCol + 1,
  		assert (fields(Name,CurCol,Type,Width,Data)),!,
  		getSetStructure (HSTMT,NextCol,NCols).
  	%
  	%  try fetch first record
  	%  sets the error condition if the set is empty
  	%
	try_fetch_first_record (HSTMT) :-
	   	trap(sql_FetchNext (HSTMT),ERR,rs_errhndl(ERR)),!.
	try_fetch_first_record (_) :-
		rs_errhndl (err_recordset_empty).
		
	fill_record_buffer (HSTMT,N,N) :- !,
		trap(Data = sql_GetColData (HSTMT,N),ERR,rs_errhndl(ERR)),
		retract (fields(Name,N,Type,Width,_)),!,
		assert (fields(Name,N,Type,Width,Data)).
	fill_record_buffer (HSTMT,ColNum,NCols) :-
		trap(Data = sql_GetColData (HSTMT,ColNum),ERR,rs_errhndl(ERR)),
		retract (fields(Name,N,Type,Width,_)),!,
		assert (fields(Name,N,Type,Width,Data)),
		NextCol = ColNum + 1,
		fill_record_buffer (HSTMT,NextCol,NCols).
	%
	%  Build SELECT SQL statement if user supplies only table name
	%  Otherwise, use user supplied SQL query
	%
	buildSelectSQL (UserSQL, UserSQL) :-
		fronttoken (UserSQL,Token,_),
		upper_lower (Utoken,Token),
		rs_member (Utoken,["SELECT","INSERT","UPDATE","DELETE"]),!.
	buildSelectSQL (TableName, SelectSQL) :-
		assert (m_TableName(TableName)),
		buildFieldClause (FieldClause),
		buildWhereClause (WhereClause),
		buildOrderByClause (OrderByClause),
		format (SelectSQL,"SELECT %s FROM %s%s%s",FieldClause,TableName,WhereClause,OrderByClause).
	%
	%  builds field list ([ID],[Phone Number]...)
	%  otherwise returns * to include all fields in a query
	% 	
	buildFieldClause ("*") :-
		get_FieldList (FieldList),
		FieldList = [],!.
	buildFieldClause (FieldClause) :-
		get_FieldList (FieldList),
		rs_reverse (FieldList,[],RevFieldList),
		rs_slist_str (RevFieldList,"",FieldClause).
	%
	%  builds WHERE clause, that is represented by a m_strFilter
	%
	buildWhereClause ("") :-
		m_strFilter (Filter),Filter="",!.
	buildWhereClause (WhereClause) :-
		m_strFilter (Filter),
		concat (" WHERE ",Filter,WhereClause).
	%
	%  builds WHERE clause for UPDATE and/or DELETE statements
	%  
	buildWhereClauseForUpdateDelete (_):-
		assert (strBuff1("")),
		fields (Name,_,_,_,Data),
			not (Data=null_value),
			addBrakets (Name,WithBrakets),
			format_DataStr (Data,DataStr),
			strBuff1(Buff),
			format (Buff1,"%s%s=%s AND ",Buff,WithBrakets,DataStr),
			assert (strBuff1(Buff1)),
		fail.
	buildWhereClauseForUpdateDelete (Where) :- % erase last _AND_
		strBuff1(Buff),
		str_len(Buff,Len),
		L = Len - 5,
		frontstr (L,Buff,Where,_),!.
	buildWhereClauseForUpdateDelete ("").
	%
	%   builds ORDER BY clause, that is represented by a m_strSort
	%
	buildOrderByClause ("") :-
		m_strSort (Sort),Sort="",!.
	buildOrderByClause (OrderByClause) :-
		m_strSort (Sort),
		concat (" ORDER BY ",Sort,OrderByClause).
	%
	%  builds INSERT INTO SQL statement
	%
	buildInsertSQL (SQL):-
		m_TableName (TableName),
		get_ValueListForInsert (Fields,Values),
		format (SQL,"INSERT INTO %s (%s) VALUES (%s)",TableName,Fields,Values).
	%
	%  builds UPDATE SQL statement
	%
	buildUpdateSQL (SQL) :-
		m_TableName (TableName),
		get_ValueListForUpdate (Values),
		strWhere(Where),
		%m_hstmt (HSTMT),
		%Cursor=sql_GetCursorName (HSTMT),
		format (SQL,"UPDATE %s SET %s WHERE %s",TableName,Values,Where).
	%
	%  builds DELETE FROM SQL statement
	%
	buildDeleteSQL (SQL) :-
		m_TableName (TableName),
		buildWhereClauseForUpdateDelete(Where),
  		format (SQL,"DELETE FROM %s WHERE %s",TableName,Where).
  	%
  	%  constructs FIELD and VALUE lists for INSERT and UPDATE statements
  	%
	get_ValueListForInsert (_,_) :-
		assert (strBuff1("")),
		assert (strBuff2("")),
		fields (Name,_,_,_,Data),
			not (Data=null_value),
			addBrakets (Name,WithBrakets),
			format_DataStr (Data,DataStr),
			strBuff1 (Buff1),
			strBuff2 (Buff2),
			format (Buff1_1,"%s%s, ",Buff1,WithBrakets),
			format (Buff2_1,"%s%s, ",Buff2,DataStr),
			assert (strBuff1(Buff1_1)),
			assert (strBuff2(Buff2_1)),
		fail.
	get_ValueListForInsert (Fields,Values) :-
		strBuff1(Buff1),
		strBuff2(Buff2),
		eraseLastComma (Buff1,Fields),
		eraseLastComma (Buff2,Values),!.
	get_ValueListForInsert ("","").
			
	%get_ValueListForUpdate ("[Name]='XXX'").
	
	get_ValueListForUpdate (_) :-
		assert (strBuff1("")),
		fields (Name,_,_,_,Data),
			not (Data=null_value),
			addBrakets (Name,WithBrakets),
			format_DataStr (Data,DataStr),
			strBuff1(Buff),
			format (Buff1,"%s%s=%s, ",Buff,WithBrakets,DataStr),
			assert(strBuff1(Buff1)),
		fail.
	get_ValueListForUpdate (Values) :-
		strBuff1 (Buff),
		eraseLastComma (Buff,Values),!.
	get_ValueListForUpdate ("").
	
	%  erase last comma in the field/value list
	eraseLastComma (Str1,Str2) :-
		str_len (Str1,Len),
		L = Len - 2,
		frontstr (L,Str1,Str2,_),!.
	
	format_DataStr (s(S),DataSTR) :-!,format (DataSTR,"'%s'",S).
	format_DataStr (i(I),DataSTR) :-!,format (DataSTR,"%d",I).
	format_DataStr (l(L),DataSTR) :-!,format (DataSTR,"%D",L).
	format_DataStr (r(R),DataSTR) :-!,format (DataSTR,"%f",R).
	format_DataStr (d(STR),STR) :-!.
	format_DataStr (t(STR),STR) :-!.
	format_DataStr (ts(STR),STR) :-!.
	format_DataStr (null_value,"NULL").
	%
	%  store fields in a copy buffer
	%
	storeFields :-
		retractall (copyfields(_,_,_,_,_)),
  		fields(Name,ColNum,Type,Width,Data),
  		asserta(copyfields(Name,ColNum,Type,Width,Data)),
  		fail.
  	storeFields.
  	%
  	%  load fields from a copy buffer
  	%
  	loadFields :-
		retractall (fields(_,_,_,_,_)),
  		copyfields(Name,ColNum,Type,Width,Data),
  		asserta(fields(Name,ColNum,Type,Width,Data)),
  		fail.
  	loadFields.
	%
	%  [Item1,Item2,Item3] -> "Item1,Item2,Item3"
	%
	rs_slist_str ([LastField|Tail],Buff,FieldClause) :-
		Tail = [],!,
		addBrakets(LastField,WithBrakets),
		concat (Buff,WithBrakets,FieldClause).
	rs_slist_str ([H|T],Buff,FieldClause) :-
		addBrakets (H,WithBrakets),
		concat (Buff,WithBrakets,S1),
		concat (S1,",",Buff1),
		rs_slist_str (T,Buff1,FieldClause).
	%
	%  some all purpose predicates (member, reverse ...)
	%
	rs_member (X,[X|_]).
	rs_member (X,[_|Y]) :- rs_member (X,Y).
	
	rs_reverse ([],L,L) :-!.
	rs_reverse ([H|T],Buff,L) :- rs_reverse (T,[H|Buff],L).
	%
	% enclose field name with brakets
	%
	addBrakets (FN,FN) :-frontchar (FN,'[',_),!.
	addBrakets (FN,WithBrakets) :- format(WithBrakets,"[%s]",FN).

ENDCLASS cRecordset

