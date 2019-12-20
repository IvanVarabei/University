/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  SETUP
 FileName: SETUP.INC
 Purpose:  Setup global declarations
 Written by: Zaichenko Michael
 Comments:
*****************************************************************************/

CONSTANTS
%BEGIN_CONST Project configuration constants
  use_3dctrl = 1
  use_dlgpack = 1
  use_message = 1
  use_ownerdraw = 1
  use_progress = 1
  use_dlgdir = 1
%END_CONST
  %%use_message =1

include "oserrm.pre"
include "vpi.con"
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

 
/*****************************************************************************
			User's Declarations
*****************************************************************************/
include "setup.pre"

include "owndraw\\owndraw.dom"		% for Directory Browser
include "owndraw\\owndraw.pre"		% for Directory Browser

		% required for some VPI tools
 

include "iodecl.con"		%\
%include "types.dom"		% \
include "binary\\binary.pre"	%  > required for setup tools
include "pdcrunt.dom"		% /
include "pdcrunt.pre"		%/


 include "progress\\progress.pre"
 include "setup\\file.pre"
 include "setup\\space.pre"
 include "setup\\setupdde.pre"
 include "setup\\bmpctrl.pre"
 include "setup\\dial_dir.pre"

ifdef ws_win
 ifdef cd_ver
include "aaplay\\aaplay.dom"
include "aaplay\\aaplay.pre"
 enddef
enddef
ifdef ws_win
 include "apicalls\\win\\apicalls.con"
 include "apicalls\\win\\apicalls.dom"
 include "apicalls\\win\\apicalls.pre"
enddef
