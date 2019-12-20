/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  SETUP
 FileName: VPITOOLS.PRO
 Purpose: Include VPI predicates and tools
 Written by: Visual Prolog Application expert
 Comments:
******************************************************************************/

ifndef os_nt
  code = 5000
enddef

include "setup.inc"
include  "error.con"

/******************************************************************************
			Include tools
******************************************************************************/
IFDEF use_message
  include "iodecl.pre"
ENDDEF

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
