/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  W3Esta
 FileName: W3ESTA.INC
 Purpose:  Project's global declarations
 Written by: Oleg V. Erjomin
 Comments:
*****************************************************************************/

include "httpext.con"		

include "types.dom"
include "httpext.dom"
include "docstr.dom"
include "w3esta.dom"

include "httpext.pre"		%  HTTP extension
%include "urle.pre"		%  URL encoding/decoding
include "html.pre"		%  DOC_TOOL HTML generator
include "errhndl.pre"		%  DOC_TOOL error handler

include "w3esta.pre"		%  core ESTA engine
include "w3misc.pre"		%  Misc handys
include "w3eaux.pre"		%  Other aux predicates
include "w3edb.pre"		%  ESTA databaser
include "w3err.pre"		%  ESTA error handling
include "w3eintf.pre"		% 
include "w3efile.pre"		%  ESTA file handling
include "w3epars.pre"		%  ESTA parser
include "w3etitle.pre"		%  ESTA titles
include "w3econs.pre"		%  ESTA inference engine
include "w3econ2.pre"		%  ""
include "w3echeck.pre"		%  ESTA checking routines
include "w3edlg.pre"		%  ESTA consultation dialogs
include "w3elog.pre"		%  ESTA dialog protocol
include "w3eadv.pre"		%  ESTA advisor
/*****************************************************************************
			User's Declarations
*****************************************************************************/

