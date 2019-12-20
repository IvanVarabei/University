/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 FileName: scrp.pro
 Purpose: Conversion between RawScript and InstallScript
	  (used for read/write fdir & fdir 32)
 Written by: Zaichenko Michael
 Comments: should work under any platforms
 	 : 
******************************************************************************/

%igroup = bin (dword:GroupId,dword:DirFpos, dword:FileSize,dword UlongCrc32)
% 	/\ -size - 12 bytes
% igrp=struct igroup(INTEGER, ARCFPOS, FILESIZE, ULONG CRC32)


PREDICATES
% Word countListEntries(Install_Script)
 Install_Script rawBin2Script(Binary)
 rawBin2Script(Install_Script,Binary,WORD,WORD)
% Binary script2RawBin(Install_Script)
% script2RawBinL(Install_Script,BINARY,WORD)
CLAUSES
/*  countListEntries([],0):-!.
  countListEntries([_|T],Give):-
  	GetEnt=countListEntries(T),
  	Give=GetEnt+1.
  
  script2RawBin(IScript,RawBin):-
	CNT= countListEntries(IScript),
	RawBin=makeBinary(CNT,16),
 	script2RawBinL(IScript,RawBin,0).
 
  script2RawBinL([],_,_):-!.
  script2RawBinL([IS|T],RAW,IDX):-
	NIDX=IDX+1,
	GR_offs= Idx*4,
	FP_offs=GR_OFFS+1,
	FS_offs=GR_OFFS+2,
	CRC_offs=GR_OFFS+3,
	IS=igroup(GR,FP,FS,CRC),
	
	setDWordEntry(RAW,GR_offs,GR),
	setDwordEntry(RAW,FP_offs,FP),
	setDWordEntry(RAW,FS_offs,FS),
	setDwordEntry(RAW,CRC_offs,CRC),
 	script2RawBinL(T,RAW,NIDX),
 	!.
*/
/**/

 rawBin2Script(RawBin,IScript):-
	BS=getBinarySize(RawBin),
	MCNT=(BS div 16)-1,
	MCNT1=val(ushort,MCNT),
	rawBin2Script(IScript,RawBin,0,MCNT1).

  rawBin2Script([],_,X,MX):- X > Mx,!.
  rawBin2Script([IS|T],RAW,IDX,MaxIDX):-
	NIDX=IDX+1,
	GR_offs= Idx*4,
	FP_offs=GR_OFFS+1,
	FS_offs=GR_OFFS+2,
	CRC_offs=GR_OFFS+3,
	
	GR = getDWordEntry(RAW,GR_offs),
	FP = getDwordEntry(RAW,FP_offs),
	FS = getDWordEntry(RAW,FS_offs),
	CRC= getDwordEntry(RAW,CRC_offs),
 	
 	GR1=val(integer,GR),
 	IS=igroup(GR1,FP,FS,CRC),
 	NIDX1=val(ushort,NIDX),
	rawBin2Script(T,RAW,NIDX1,MaxIdx),
 	!.
/*end of include */ 
