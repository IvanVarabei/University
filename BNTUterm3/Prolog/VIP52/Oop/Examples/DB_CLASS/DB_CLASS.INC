/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  DB_Class
 FileName: DB_CLASS.INC
 Purpose:  Project's global declarations
 Written by: Oleg V. Erjomin
 Comments:
*****************************************************************************/

CONSTANTS
%BEGIN_CONST Project configuration constants, Code automatically updated!
  use_mdi = 1
  use_3dctrl = 1
  use_tbar = 1
  use_dlgpack = 1
  use_editor = 1
  use_message = 1
  use_sql = 1
%END_CONST

include "vpi.con"
include "vpi.dom"
include "vpi.pre"
IFDEF use_tabdlg
  IFNDEF use_dlgpack
    CONSTANTS
       use_dlgpack =1
  ENDDEF
ENDDEF
IFDEF use_dlgpack
  include "dialog\\dialog.dom"
  include "dialog\\dialog.pre"
ENDDEF
IFDEF use_message
  IFNDEF use_editor
    CONSTANTS
       use_editor =1
  ENDDEF
ENDDEF
IFDEF use_editor
  include "edit.dom"
ENDDEF
IFDEF use_message
  include "messages\\messages.pre"
ENDDEF
IFDEF use_tbar
  include "toolbar\\toolbar.dom"
  include "toolbar\\toolbar.pre"
ENDDEF
IFDEF use_tree
  include "tree\\vpitree.dom"
ENDDEF
IFDEF use_tabdlg
  include "tabdlg\\tabdlg.dom"
ENDDEF
IFDEF use_dlgdir
  IFNDEF use_ownerdraw
    CONSTANTS
       use_ownerdraw =1
  ENDDEF
ENDDEF
IFDEF use_ownerdraw
  include "owndraw\\owndraw.dom"
ENDDEF
IFDEF use_grid
  include "grid\\grid.dom"
ENDDEF
IFDEF use_date
  include "date\\date.dom"
ENDDEF
IFDEF use_treebrowser
GLOBAL DOMAINS
  BROWSELIST_USERITEMKEY = INTEGER % User specified

  include "treebrws\\treebrws.dom"
ENDDEF
IFDEF use_listproperty
  include "property\\property.dom"
ENDDEF
IFDEF use_palette
  include "palette\\palette.dom"
ENDDEF
IFDEF use_doc
  include "docstr.dom"
ENDDEF
IFDEF use_sql
  include "sqlbind.dom"
ENDDEF
IFDEF use_odbc
  include "odbc.dom"
ENDDEF
IFDEF use_socket
  include "pdcrunt.dom"
  include "pdcsock.dom"
ENDDEF


/*****************************************************************************
			User's Declarations
*****************************************************************************/
GLOBAL DOMAINS
  DB_SELECTOR = browselist_db	% For treebrowser tool
  FILE = fileselector1; fileselector2 % To be edited

include "db_class.pre"
include "cdatabas.dom"

CLASS cMyRecordset : cRecordset
   FACTS
   	single m_nRecNo (INTEGER)
   PREDICATES
        % overrided predicates
        procedure new (cDatabase)
        moveNext
        requery
        get_FieldList(slist) - (o)
        % other publics
   	STRING dump
   	getRecNo (INTEGER) - (o)
        edit_CurRecord
ENDCLASS cMyRecordset