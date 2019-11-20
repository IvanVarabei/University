/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: TDOMS.PRO
 Purpose: 
 Written by: PDC
 Comments:
 	In order to use the tools, the following domain declarations 
 	should be included at the start of your program		
******************************************************************************/

ifndef tdoms_in
CONSTANTS
  tdoms_in = 1

GLOBAL DOMAINS
  ROW, COL, LEN, ATTR   = INTEGER
  STRINGLIST = STRING*
  INTEGERLIST = INTEGER*
  KEY    = cr; esc(); break; tab; btab; del; bdel; ctrlbdel; ins;
  	   end ; home ; fkey(INTEGER) ; up ; down ; left ; right ;
  	   ctrlleft; ctrlright; ctrlend; ctrlhome; pgup; pgdn; 
  	   ctrlpgup; ctrlpgdn; char(CHAR) ; otherspec

enddef
