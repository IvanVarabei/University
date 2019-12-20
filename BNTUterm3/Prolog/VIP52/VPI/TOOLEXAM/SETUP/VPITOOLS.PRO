/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  SETUP
 FileName: VPITOOLS.PRO
 Purpose: Include VPI predicates and tools
 Written by: Visual Prolog Application expert
 Comments:
******************************************************************************/

ifdef ws_win
  code = 5000
enddef
ifdef os_os2
%  code = 8200
enddef

include "build_v\\script.con"		% for access max_disc const in file.pro
include "setup.Inc"
include  "error.con"

/******************************************************************************
			Include tools
******************************************************************************/

  include "iodecl.pre"
  

IFDEF use_DlgPack
  include "dialog\\dialog.pro"
ENDDEF
IFDEF use_tbar
  include "toolbar\\toolbar.pro"
ENDDEF
IFDEF use_tree
  include "tree\\vpitree.pro"
ENDDEF
IFDEF use_message
  include "messages\\messages.pro"
ENDDEF
  include "owndraw\\owndraw.pro"
ifdef ws_win
 include "apicalls\\win\\apicalls.pro"
enddef
include "apicalls\\win\\apiutils.pro"

include "binary\\binary.pro"		% required for mergebinary.
include "progress\\progress.pro"

include "setup\\space.pro"
include "setup\\setupdde.pro"
include "dlgdir\\sort.pro"	%need for dial_dir
include "setup\\dial_dir.pro"
ifdef ws_win
  include "setup.con"
 elsedef
  include "setup2.con"
enddef
include "setup\\bmpctrl.pro"
include "setup\\file.pro"
