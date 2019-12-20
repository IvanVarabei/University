/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  SETUP3
 FileName: SETUP3.PRO
 Purpose: Uninstall setup2,aaplay.
 Written by: Zaichenko Michael
 Comments:
******************************************************************************/

include "..\\..\\include\\setup\\slice.pro" % 

include "build_V\\script.con"	% used for determine conf. constants


CLAUSES

  delete_all:-
	trap(deletefile("SETUP3.exe"),_,write(" setup3.exe not deleted")),
	fail.

  delete_all:-
	trap(deleteFile("SETUP2.exe"),_,write(" setup2.exe not deleted")),
	fail.

ifdef cd_ver
  delete_all:-
	free_timeslice(),
	trap(deleteFile("AAPLAY.DLL"),_,write("aaplay.dll not deleted")),
	fail.
enddef
  delete_all:-
	trap(deleteFile("SETUP.HLP"),_,fail),
	fail.

  delete_all.
  
GOAL
  sleep_with_release_slice(3),		%wait 3 sec
 					%for  setup2 closed.
  delete_all.
 