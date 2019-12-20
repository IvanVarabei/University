/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  DB_CLASS
 FileName: DB_CLASS.PRO
 Purpose: Sample Implementation of CDatabase class
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

include "db_class.inc"
include "db_class.con"
include "hlptopic.con"
include "edit.pre"

CONSTANTS
 sql_StringType             = 1
 sql_LongType               = 2
 sql_ShortType              = 3
 sql_RealType               = 4
 sql_DateType               = 5
 sql_TimeType               = 6
 sql_TimeStampType          = 7


%BEGIN_WIN Task Window
/***************************************************************************
	Event handling for Task Window
***************************************************************************/
PREDICATES

  task_win_eh : EHANDLER

CONSTANTS

%BEGIN Task Window, CreateParms, 16:27:48-26.11.1999, Code automatically updated!
  task_win_Flags = [wsf_SizeBorder,wsf_TitleBar,wsf_Close,wsf_Maximize,wsf_Minimize,wsf_ClipSiblings]
  task_win_Menu  = res_menu(idr_task_menu)
  task_win_Title = "DB_Class"
  task_win_Help  = idh_contents
%END Task Window, CreateParms

CLAUSES

%BEGIN Task Window, e_Create
  task_win_eh(_Win,e_Create(_),0):-!,
%BEGIN Task Window, InitControls, 16:27:48-26.11.1999, Code automatically updated!
%END Task Window, InitControls
%BEGIN Task Window, ToolbarCreate, 16:27:48-26.11.1999, Code automatically updated!
	tb_project_toolbar_Create(_Win),
	tb_help_line_Create(_Win),
%END Task Window, ToolbarCreate
IFDEF use_message
	msg_Create(100),
ENDDEF
	!.
%END Task Window, e_Create

%MARK Task Window, new events

%BEGIN Task Window, id_file_open
  task_win_eh(_Win,e_Menu(id_file_open,_ShiftCtlAlt),0):-!,
  	dlg_select_table_create (_Win,DSN,TABLE),
  	dlg_browse_table_create (_Win,DSN,TABLE),
	!.
%END Task Window, id_file_open

%BEGIN Task Window, id_help_contents
  task_win_eh(_Win,e_Menu(id_help_contents,_ShiftCtlAlt),0):-!,
  	vpi_ShowHelp("db_class.hlp"),
	!.
%END Task Window, id_help_contents

%BEGIN Task Window, id_help_about
  task_win_eh(Win,e_Menu(id_help_about,_ShiftCtlAlt),0):-!,
	dlg_about_dialog_Create(Win),
	!.
%END Task Window, id_help_about

%BEGIN Task Window, id_file_exit
  task_win_eh(Win,e_Menu(id_file_exit,_ShiftCtlAlt),0):-!,
  	win_Destroy(Win),
	!.
%END Task Window, id_file_exit

%BEGIN Task Window, e_Size
  task_win_eh(_Win,e_Size(_Width,_Height),0):-!,
IFDEF use_tbar
	toolbar_Resize(_Win),
ENDDEF
IFDEF use_message
	msg_Resize(_Win),
ENDDEF
	!.
%END Task Window, e_Size

%END_WIN Task Window

/***************************************************************************
	Invoking on-line Help
***************************************************************************/

  project_ShowHelpContext(HelpTopic):-
  	vpi_ShowHelpContext("db_class.hlp",HelpTopic).

/***************************************************************************
	Main Goal
***************************************************************************/

GOAL

IFDEF use_mdi
  vpi_SetAttrVal(attr_win_mdi,b_true),
ENDDEF
IFDEF ws_win
  IFDEF use_3dctrl
    vpi_SetAttrVal(attr_win_3dcontrols,b_true),
  ENDDEF
ENDDEF  
  vpi_Init(task_win_Flags,task_win_eh,task_win_Menu,"db_class",task_win_Title).

%BEGIN_TLB Project toolbar, 16:27:58-26.11.1999, Code automatically updated!
/**************************************************************************
	Creation of toolbar: Project toolbar
**************************************************************************/

clauses

  tb_project_toolbar_Create(_Parent):-
ifdef use_tbar
	toolbar_create(tb_top,0xC0C0C0,_Parent,
		[tb_ctrl(id_file_open,pushb,idb_open_up,idb_open_dn,idb_open_up,"Open;Open file",1,1),
		 separator,
		 tb_ctrl(id_help_about,pushb,idb_help_up,idb_help_down,idb_help_up,"Help;Help",1,1)]),
enddef
	true.
%END_TLB Project toolbar




%BEGIN_TLB Help line, 16:28:02-26.11.1999, Code automatically updated!
/**************************************************************************
	Creation of toolbar: Help line
**************************************************************************/

clauses

  tb_help_line_Create(_Parent):-
ifdef use_tbar
	toolbar_create(tb_bottom,0xC0C0C0,_Parent,
		[tb_text(idt_help_line,tb_context,452,0,4,10,0x0,"")]),
enddef
	true.
%END_TLB Help line


%BEGIN_DLG About dialog
/**************************************************************************
	Creation and event handling for dialog: About dialog
**************************************************************************/

CONSTANTS

%BEGIN About dialog, CreateParms, 17:07:16-26.11.1999, Code automatically updated!
  dlg_about_dialog_ResID = idd_dlg_about
  dlg_about_dialog_DlgType = wd_Modal
  dlg_about_dialog_Help = idh_contents
%END About dialog, CreateParms

PREDICATES

  dlg_about_dialog_eh : EHANDLER

CLAUSES

  dlg_about_dialog_Create(Parent):-
	win_CreateResDialog(Parent,dlg_about_dialog_DlgType,dlg_about_dialog_ResID,dlg_about_dialog_eh,0).

%BEGIN About dialog, idc_ok _CtlInfo
  dlg_about_dialog_eh(_Win,e_Control(idc_ok,_CtrlType,_CtrlWin,_CtrlInfo),0):-!,
	win_Destroy(_Win),
	!.
%END About dialog, idc_ok _CtlInfo
%MARK About dialog, new events

  dlg_about_dialog_eh(_,_,_):-!,fail.

%END_DLG About dialog



%BEGIN_DLG Select Table
/**************************************************************************
	Creation and event handling for dialog: Select Table
**************************************************************************/

CONSTANTS

%BEGIN Select Table, CreateParms, 16:29:10-26.11.1999, Code automatically updated!
  dlg_select_table_ResID = idd_select_table
  dlg_select_table_DlgType = wd_Modal
  dlg_select_table_Help = idh_contents
%END Select Table, CreateParms

PREDICATES
  dlg_select_table_eh : EHANDLER
CLAUSES

  dlg_select_table_Create(Parent,_DSN,_TABLE):-

%MARK Select Table, new variables

	dialog_CreateModal(Parent,dlg_select_table_ResID,"",
  		[
%BEGIN Select Table, ControlList, 16:29:10-26.11.1999, Code automatically updated!
		df(idc_dsn,editstr("Persons",[mandatory]),nopr),
		df(idc_table,editstr("Persons",[mandatory]),nopr)
%END Select Table, ControlList
		],
		dlg_select_table_eh,0,VALLIST,ANSWER),
	ANSWER = idc_Ok,
	_DSN = dialog_VLGetstr(idc_dsn,VALLIST),
	_TABLE = dialog_VLGetstr(idc_table,VALLIST),
	_DSN <> "",
	_TABLE <> "".

%MARK Select Table, new events

  dlg_select_table_eh(_,_,_):-!,fail.

%END_DLG Select Table

%BEGIN_DLG Browse Table
/**************************************************************************
	Creation and event handling for dialog: Browse Table
**************************************************************************/
CONSTANTS
  the_rs = 1
%BEGIN Browse Table, CreateParms, 16:28:52-26.11.1999, Code automatically updated!
  dlg_browse_table_ResID = idd_browse_table
  dlg_browse_table_DlgType = wd_Modal
  dlg_browse_table_Help = idh_contents
%END Browse Table, CreateParms
DATABASE - browse_table_internal
  determ rs(cMyRecordset)
PREDICATES

  dlg_browse_table_eh : EHANDLER
  dlg_browse_table_handle_answer(INTEGER EndButton,DIALOG_VAL_LIST)
  dlg_browse_table_update(DIALOG_VAL_LIST)

CLAUSES

  dlg_browse_table_Create(Parent,DSN,Table):-
	MyDB = cDatabase::new,
   	Ret1 = MyDB:open(DSN,"",""),
	Ret1 <> 0,
		MyRS = cMyRecordset::new(MyDB),
		Ret2 = MyRS:open(TABLE),
		Ret2 <> 0, !,
		RECORD_DUMP=MyRS:dump,
	retractall (rs(_)),
	assert(rs(MyRS)),
	format(DSN_TITLE,"Data Source : %s",DSN),
	format(TABLE_TITLE,"Table : %s",Table),
%MARK Browse Table, new variables

	dialog_CreateModal(Parent,dlg_browse_table_ResID,"",
  		[
%BEGIN Browse Table, ControlList, 16:28:52-26.11.1999, Code automatically updated!
		df(idc_browse_table_edit,editstr(RECORD_DUMP,[]),nopr),
		df(idct_data_source,statictext(DSN_TITLE),nopr),
		df(idct_table,statictext(TABLE_TITLE),nopr)
%END Browse Table, ControlList
		],
		dlg_browse_table_eh,0,VALLIST,ANSWER),
	dlg_browse_table_handle_answer(ANSWER,VALLIST),
	MyRS:delete,
	MyDB:commitTrans,
	MyDB:close.
  dlg_browse_table_Create(_Parent,DSN,Table):-
   	format (Err,"Some error occurs when you retrieved %s from %s",TABLE,DSN),
   	dlg_Error (Err).

  dlg_browse_table_handle_answer(idc_ok,VALLIST):-!,
	dlg_browse_table_update(VALLIST).
  dlg_browse_table_handle_answer(idc_cancel,_):-!.  % Handle Esc and Cancel here
  dlg_browse_table_handle_answer(_,_):-
	errorexit().

  dlg_browse_table_update(_VALLIST):-
%BEGIN Browse Table, Update controls, 16:28:52-26.11.1999, Code automatically updated!
	_RECORD_DUMP = dialog_VLGetstr(idc_browse_table_edit,_VALLIST),
%END Browse Table, Update controls
	true.

%MARK Browse Table, new events

%BEGIN Browse Table, idc_requery _CtlInfo
  dlg_browse_table_eh(_Win,e_Control(idc_requery,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
  	rs(MyRS),
  	MyRS:requery,
  	MyRS:getRecNo(RecNo),
  	RECORD_DUMP = MyRS:dump,
  	ED = win_GetCtlHandle (_Win,idc_browse_table_edit),
  	win_SetText (ED,RECORD_DUMP),
  	GB = win_GetCtlHandle (_Win,idc_record),
  	format (RecNoTxt,"Record: %d",RecNo),
  	win_SetText (GB,RecNoTxt),
	!.
%END Browse Table, idc_requery _CtlInfo

%BEGIN Browse Table, idc_delete _CtlInfo
  dlg_browse_table_eh(_Win,e_Control(idc_delete,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
	rs(MyRS),
	MyRS:erase,
	!.
%END Browse Table, idc_delete _CtlInfo

%BEGIN Browse Table, idc_edit _CtlInfo
  dlg_browse_table_eh(_Win,e_Control(idc_edit,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
  	rs(MyRS),
  	MyRS:edit,
  	MyRS:edit_CurRecord,
	MyRS:update,
	!.
%END Browse Table, idc_edit _CtlInfo

%BEGIN Browse Table, idc_add_new _CtlInfo
  dlg_browse_table_eh(_Win,e_Control(idc_add_new,_CtrlType,_CtrlWin,_CtlInfo),0):-!,
  	rs(MyRS),
  	MyRS:addNew,
  	MyRS:edit_CurRecord,
  	MyRS:update,
	!.
%END Browse Table, idc_add_new _CtlInfo

%BEGIN Browse Table, idc_next _CtlInfo
  dlg_browse_table_eh(_Win,e_Control(idc_next,_CtrlType,_CtrlWin,_CtlInfo),0):-
	rs(MyRS),
  	MyRS:moveNext,!,
  	MyRS:getRecNo(RecNo),
  	RECORD_DUMP = MyRS:dump,
  	ED = win_GetCtlHandle (_Win,idc_browse_table_edit),
  	win_SetText (ED,RECORD_DUMP),
  	GB = win_GetCtlHandle (_Win,idc_record),
  	format (RecNoTxt,"Record: %d",RecNo),
  	win_SetText (GB,RecNoTxt),
  	!.
  dlg_browse_table_eh(_Win,e_Control(idc_next,_CtrlType,_CtrlWin,_CtlInfo),0):- !,
  	dlg_Note ("The end of recordset is reached").
	
%END Browse Table, idc_next _CtlInfo

%BEGIN Browse Table, e_Create
  dlg_browse_table_eh(_Win,e_Create(_CreationData),0):-!,
  	ED = win_GetCtlHandle (_Win,idc_browse_table_edit),
  	win_SelectText (ED,0,0),
	!.
%END Browse Table, e_Create

  dlg_browse_table_eh(_,_,_):-!,fail.

%END_DLG Browse Table

IMPLEMENT cMyRecordset
   PREDICATES
   	dump_cur_record (USHORT, USHORT, STRING, STRING)
	format_dataStr (COL_DATA, STRING)
	format_typeStr (COL_TYPE, STRING)
	edit_CurRecordLoop (USHORT,USHORT)
	check_and_store_field (COL_TYPE,USHORT,STRING)
   CLAUSES
   	m_nRecNo (1).
   
        new (DB) :- cRecordset::new (DB).
        
        getRecNo (R) :- m_nRecNo (R).
        
        requery :-
        	assert (m_nRecNo(1)),
        	cRecordSet::requery.
        
        moveNext :-
        	m_nRecNo (N),
        	N1 = N+1,
        	assert (m_nRecNo(N1)),
        	cRecordset::moveNext.
                	
   	dump (Dump) :-
   		get_nFields (N),
   		%m_nFields (N),
   		dump_cur_record (1,N,"",Dump).
   	
   	dump_cur_record (N,N,Buff,Dump) :-!,
   		get_field (N,Name,_,_),
   		DATA = getFieldbyNum (N),
   		format_DataStr (DATA,DataStr),!,
   		format (Dump,"%s%s: %s",Buff,Name,DataStr).
   	dump_cur_record (Col,NCol,Buff,Dump) :-
   		get_field (Col,Name,_,_),
   		DATA = getFieldbyNum (Col),
   		format_DataStr (DATA,DataStr),!,
   		format (Buff1,"%s%s: %s\n",Buff,Name,DataStr),
		Next = Col + 1,
   		dump_cur_record (Next,NCol,Buff1,Dump).
   		
   	format_DataStr (s(STR),STR) :-!.
	format_DataStr (i(I),STR) :- !,format (STR,"%d",I).
	format_DataStr (l(L),STR) :- !,format (STR,"%D",L).
	format_DataStr (r(R),STR) :- !,format (STR,"%f",R).
	format_DataStr (d(STR),STR) :-!.
	format_DataStr (t(STR),STR) :-!.
	format_DataStr (ts(STR),STR) :-!.
	format_DataStr (null_value,"<NULL>").
	
	format_typeStr(sql_stringType,"String").
   	format_typeStr(sql_longType,"Long Integer").
   	format_typeStr(sql_shortType,"Short Integer").
   	format_typeStr(sql_realType,"Floating Point Number").
   	format_typeStr(sql_dateType,"Date").
   	format_typeStr(sql_timeType,"Time").
   	format_typeStr(sql_timeStampType,"Time Stamp").

	edit_CurRecord :-
		get_nFields (N),
   		edit_CurRecordLoop(0,N).
   		
   	edit_CurRecordLoop(N,N) :-!.
   	edit_CurRecordLoop(Col,N) :-
   		CurCol=Col+1,		% fields grows from 1
   		get_field (CurCol,Name,Type,_),
   		format_TypeStr(Type,TypeStr),
   		DATA = getFieldbyNum (CurCol),
   		format_DataStr (DATA,DataStr),
   		format(S1,"Enter new value for [%s]\nType:%s",Name,TypeStr),
   		NewVal=dlg_GetStr("Edit Record",S1,DataStr),
   		check_and_store_field (Type,CurCol,NewVal),!,
   		edit_CurRecordLoop(CurCol,N).
   	edit_CurRecordLoop(Col,N) :-
   		CurCol=Col+1,		% fields grows from 1
   		get_field (CurCol,Name,_,_),
   		format(Msg,"Column [%s] leaved unchanged",Name),
   		dlg_Note(Msg),
   		edit_CurRecordLoop(CurCol,N).
   	
   		
   	check_and_store_field (_,_,"<NULL>") :- !.
   	check_and_store_field (sql_stringType,Col,NewVal) :-!,
   		setFieldByNum(Col,s(NewVal)).
   	check_and_store_field (sql_longType,Col,NewVal) :-
   		trap(term_str(long,LongVal,NewVal),_,dlg_Error("Invalid input")),!,
   		setFieldByNum(Col,l(LongVal)).
   	check_and_store_field (sql_shortType,Col,NewVal) :-
   		trap(term_str(integer,LongVal,NewVal),_,dlg_Error("Invalid input")),!,
   		setFieldByNum(Col,i(LongVal)).
   	check_and_store_field (sql_realType,Col,NewVal) :-
   		trap(term_str(real,LongVal,NewVal),_,dlg_Error("Invalid input")),!,
   		setFieldByNum(Col,r(LongVal)).
   	check_and_store_field (_,_,_) :-
   		dlg_Note ("Leave this column unchanged").
   		
   	get_FieldList (["FirstName","LastName","Address","Phone","Age"]).
	
ENDCLASS cMyRecordset

















