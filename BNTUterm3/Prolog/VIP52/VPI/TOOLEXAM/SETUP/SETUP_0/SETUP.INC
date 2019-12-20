
/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  SETUP
 FileName: SETUP.INC
 Purpose:  Project's global declarations
 Written by: Zaichenko Michael
 Comments:
*****************************************************************************/

CONSTANTS
%BEGIN_CONST Project configuration constants, Code automatically updated!
%END_CONST
ifdef ws_win
 


Include "vpi.con"
 include "vpi.dom"
 include "vpi.pre"
 IFDEF use_sql
   include "sqlbind.dom"
   include "sqlbind.pre"
 ENDDEF
 
IFDEF use_DlgPack
  include "dialog\\dialog.dom"
  include "dialog\\dialog.pre" 
 ENDDEF
 IFDEF use_editor
  include "edit.dom"
  include "edit.pre"
 ELSEDEF
  IFDEF use_message
    include "edit.dom"
    include "edit.pre"
  ENDDEF
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
  include "tree\\vpitree.pre"
 ENDDEF
enddef

/*****************************************************************************
			User's Declarations
*****************************************************************************/
CONSTANTS
 init32 = 0xFFFFFFFF
 init16 = 0

include "setup.pre"
