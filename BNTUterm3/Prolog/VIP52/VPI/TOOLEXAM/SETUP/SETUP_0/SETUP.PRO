/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  SETUP
 FileName: SETUP.PRO
 Purpose:  Loader 
 Written by: Zaichenko Michael
 Comments: target platforms: "WIN 16bit vpi" or "OS/2 32bit textmode"
******************************************************************************/
include "setup.inc"
%include "setup.con"
%include "script.con"

CONSTANTS
 i_disk=0
 i_handle=1
 i_result=2
 binary_mode=0
 use_FDIR32=1			% for testing
 
 
 %id_debug_FDIR_ISB =1
 %id_debug_FDIR_DIR =1

 
ifndef use_FDIR32
 ifdef platform_32bit 
 use_FDIR32 =1	      % set support 'FDIR32' format instead of FDIR
 enddef
enddef


ifndef use_fdir32
% .error must fdir32	%this for testing,also should work with fdir16
enddef


	% set group number for unpack
	% (group should be defined in build\iscript.pro)
ifdef ws_win
  id_SystemGroupNumber=0	%for windows
enddef
ifdef os_os2
  id_SystemGroupNumber=1	%for os/2
enddef




IfDef os_os2
 
 PREDICATES
  dlg_note(STRING)
CLAUSES
  dlg_note(MSG):-
  	writeDevice(Was),
	writeDevice(screen),
	write(MSG),
	writeDevice(Was),
	readDevice(WasR),
	readDevice(stdin),
	readchar(_),
	readDevice(WasR).
	
EndDef





include "scrp.pro"	% RawScript Conversion
/*****************************************************************************/
DATABASE - install_params
 determ setup_started_on_path(STRING)

DATABASE - other
  determ setup2Info(DIRECTORY group0)
 %temp22(install_script2)


PREDICATES
  readArcExpanding(UNSIGNED,BINARY)
%  remove_any_trailing_slash(STRING,STRING)

  find_startup_path(STRING)
  mustExist(STRING Filename)
  assemble2(INSTALL_SCRIPT, INSTALL_SCRIPT2)
  test_crc(DWORD CRC32,DWORD CRC32, STRING)
%  NONDETERM member(IGRP2,INSTALL_SCRIPT2)
  nondeterm member(DIR_ENTRY,DIRECTORY)
%  NONDETERM repeat
  expandDirectory(DIRECTORY,ULONG sizeFileDisk_x)
CLAUSES
  mustExist(X):-existfile(X),!.
  mustExist(X):-
	concat("Error: Cant find ",X,Msg),
	dlg_note(Msg),
	exit(0).



PREDICATES
  multimkdir(string)	
  cutdir(string,string)
  trapmkdir(STRING)	
CLAUSES
  trapMKDir(D):-
	trap(mkdir(D),_,fail),
	fail.
  trapMKdir(_).
  
  cutdir(DIR,CUTDIR):-
	searchchar(Dir,'\\',Pos),
	Pos>1,!,
	Npos=Pos-1,
	substring(DIR,1,NPOS,CUTDIR).
	
  cutdir(DIR,DIR).

  multimkdir(DIR):-
   	not(searchchar(Dir,':',_)),
  	cutDir(Dir,CD),
  	trapmkdir(CD),
  	disk(CD),
 	searchchar(Dir,'\\',Pos),!,
	str_len(Dir,Len),
	NPos=Pos+1,
	Nlen=Len-Pos,
	substring(Dir,Npos,Nlen,NDir),
	multimkdir(NDir).
  multiMKDir(Dir):-
	searchchar(Dir,':',_),
	str_len(Dir,Len),
	Nlen=Len-3,
	NPos=4,
	substring(Dir,Npos,Nlen,NDir),
	substring(Dir,1,3,Root),
	disk(Root),
	multiMKDir(Ndir),!.
  multiMKDir(_).


PREDICATES
  setMake(STRING DirName)
CLAUSES
  setMake(Dir):-
	multimkdir(DIR),
	disk(DIR).

  member(H, [H|_]).
  member(H,[_|T]):- member(H,T).

%  remove_any_trailing_slash(P,Path):- concat(Path,"\\",P),!.
%  remove_any_trailing_slash(Path,Path).

%% what drive is SETUP running from?
  find_startup_path(Path):-
  	%disk(Path),		%commented by MZ 13.10.96
  	syspath(Path,_),	% now possible runing from non-mapped drive

	assert(setup_started_on_path(Path)).



PREDICATES
  expandFile(Dir_entry,ULONG)
  expSegs(BINARY,DWORD CRC32,ULONG)
  NONDETERM  for(INTEGER,INTEGER,INTEGER)
CLAUSES
expandDirectory(DirList,DiskSize):-
	member(DirEntry,DirList),  %repeat-fail to keep Gstack collected
	  expandFile(DirEntry,DiskSize),% (used by expand, file IO, etc)
	fail
	;
	true.

  for(I,I,_).
  for(I,J,K):- J<K, !,J2=J+1, for(I,J2,K).

%% ONLY USED TO EXPAND files from first disk !!! NO vitual mapping, disk spanning
  expandFile(small_file(FileName,FileSize,_,_,CRCWas,ArcFpos,BlkSize),_):-
	!,
	filepos(archive,ArcFpos,0),
	readArcExpanding(BlkSize, ExpandedBin),
	CRCNow=init32-crc32binary(ExpandedBin,init32),
	test_crc(CRCWas,CRCNow,FileName),
	openwrite(outfile,FileName),
	filemode(outfile,0),
	writedevice(Was),
	writedevice(outfile),
	FileSize1=val(unsigned,FileSize),
	writeblock(FileSize1,ExpandedBin),
	writedevice(Was),
	closefile(outfile).

  expandFile(large_file(FileName,_,_,_,CRCWas,ArcFpos,LenArray),FD_size):-
	!,
	filepos(archive,ArcFpos,0),
	openwrite(outfile,Filename),
	filemode(outfile,0),
	writedevice(Was),
	writedevice(outfile),
	expSegs(LenArray,CRCNow,FD_size),
	writedevice(Was),
	test_crc(CRCWas,CRCNow,FileName),
	closeFile(outfile).

  expandFile(subdir(_DirName, Directory),FSize):-!,
	expandDirectory(Directory,FSize).

% expand a set of compressed segments representing a file>64K
  expSegs(LenArray, ExpCrc,_):-
	Last=(getBinarySize(LenArray) div 2)-1,
	CRCHolder=makeBinary(4),	   % used for local storage
	setDWordEntry(CRCHolder,0,init32), % to accumulate CRC
	for(Index,0,Last),
	   BlkSize=getWordEntry(LenArray,Index),
	   readArcExpanding(BlkSize, ExpandedBin),
	   CrcSeed=getDWordEntry(CRCHolder,0),       %safe from backtracking
	   CRCNext=crc32Binary(ExpandedBin, CrcSeed),
	   setDWordEntry(CRCHolder,0,CRCNext),
	   OutBlkSize=getBinarySize(ExpandedBin),
	   writeBlock(OutBlkSize, ExpandedBin),
	Index=Last,!,
	ExpCrc=init32-getDWordEntry(CRCHolder,0).     %crc = ~crc
PREDICATES
  get_tempDirectory(String)
CLAUSES
  get_tempDirectory(Path):-
	envsymbol("temp",Path),
	trap(setmake(Path),_,fail),!.
  get_tempDirectory("c:\\temp"):-
 	trap(setmake("c:\\temp"),_,fail),!.
  get_tempDirectory("c:\\temp"):-
 	dlg_note("Not found temp directory in environment,\nUnable to create c:\\temp!"),
 	exit(0),fail,!.


%  repeat.
%  repeat:-repeat.

  readArcExpanding(Size, Expanded):-
	readdevice(Was),
	readdevice(archive),
	trap(readblock(Size,Bin),_,dlg_note("internal error reading ")),
	readdevice(Was),
	Expanded=expandBinary(Bin).



%% reassemble into list of groups from list of file pointers
%%  to groups (segmented as otherwise list might exceed
%%  64K in fixup format)

  assemble2([igroup(Id, Fpos, TreeSize,CRCWas)|_],
  		[install_group( Id, Directory)]):-
  	ID=id_SystemGroupNumber,	% set here group number to unpack
	filepos(archive,Fpos,0),
	TreeSize1=val(unsigned,TreeSize),
	readArcExpanding(TreeSize1, DirBin),
	CRCNow=init32-crc32binary(DirBin,init32),
	test_crc(CRCWas,CRCNow,"fdir - in proc:assemble2"),
ifdef use_FDIR32
	term_bin(string,DirStr,DirBin),
	term_str(directory,Directory, DirStr),
elsedef
	term_bin(directory,Directory,DirBin),
enddef
	!.	

  assemble2([_|Tail],Tail2):-
	assemble2(Tail,Tail2),!.
  assemble2([],[]).



  test_crc(X,X,_):-!.
  test_crc(_,_,File):-
	format(Msg,"CRC error expanding file %s",File),
	dlg_note(Msg),
	exit.
/***************************************************************************
	Main Goal
***************************************************************************/

GOAL
ifdef os_os2
	%write("I started!\n"),readchar(_),
enddef
	find_startup_path(StartPath),
	
ifdef use_FDIR32	
	fileNamePath(FdirName, StartPath, "FDIR32"),
elsedef
	fileNamePath(FdirName,StartPath, "FDIR"),
enddef
	fileNamePath(Disk1File,StartPath, "DISK_1"),
	mustExist(FdirName),
	mustExist(Disk1File),

% read the directory of selectable groups (FDIR)

	openread(archive,FdirName),
	fileMode(archive,0),


	readdevice(ReadD),
	readdevice(archive),
	readBlock(4,MaxDisksBin),	% read Max Disks
	MaxDisks=getDwordEntry(MaxDisksBin,0),
	DaSize=(MaxDisks+3)*4,

	DaSize1=val(unsigned,DaSize),
	readblock(DaSize1, DiskArray),
	
	SFpos=getDwordEntry(DiskArray,0),
	SSize=getDwordEntry(DiskArray,1),
	SCrc=getDwordEntry(DiskArray,2),

	readDevice(ReadD),
	
	

	filepos(archive,SFpos,0),
ifdef id_debug_FDIR_ISB
	dlg_note("before read ISB"),
enddef    	
	SSize1=val(unsigned,SSize),
	readArcExpanding(SSize1, ScriptBin),

	ExpCrc=init32-crc32binary(ScriptBin,init32),
	test_crc(SCrc, ExpCrc,FdirName),
ifdef id_debug_FDIR_ISB
	dlg_note("ISB expanded and crc ok!"),
enddef

        ScriptTemp = rawBin2Script(ScriptBin),
ifdef id_debug_FDIR_ISB
	term_str(install_script,ScriptTemp,TextScript),
	file_str("D:\\Three.spt",TextScript),
enddef
ifdef id_debug_FDIR_DIR
	dlg_note("before assemble 2"),
enddef
	assemble2(ScriptTemp,ScriptGr),
	
	ScriptGr=[install_group(id_SystemGroupNumber, Setup2FileEntry)],

	!,
	closeFile(archive),
	openread(archive,Disk1File),
	assert(setup2Info(Setup2FileEntry)),

/*********************************************************************
          expand prog and exec
**********************************************************************/
	filepos(archive,0,2),
	filepos(archive,DISK_XSize,0),
	filepos(archive,0,0),
	get_TempDirectory(TargetPath),
	disk(TargetPAth),
	fileNamePath(TMP_Par,TargetPath,"S_info.$$$"),
	save(TMP_Par,install_params),
	setup2Info(Setup2File),
ifdef id_debug_FDIR_DIR
	dlg_note("before expand 2"),
enddef

	expandDirectory(Setup2File,DISK_XSize),
	fileNamePath(TargetLocExec,TargetPath, "setup2.exe"),

ifdef id_debug_FDIR_DIR
	format(RunMSG,"Try To Run\n %s",TargetLocExec),
	dlg_note(RunMSG),
enddef

ifdef ws_win
	system(TargetLocExec,1,_).
elsedef
	system(TargetLocExec).
enddef

%BEGIN_WIN Task Window
/***************************************************************************
		Event handling for Task Window
***************************************************************************/
ifndef os_os2
predicates

  task_win_eh : EHANDLER

constants

%BEGIN Task Window, CreateParms, 17:19:18-24.11.1999, Code automatically updated!
  task_win_Flags = [wsf_SizeBorder,wsf_TitleBar,wsf_Close,wsf_Maximize,wsf_Minimize,wsf_ClipSiblings]
  task_win_Menu  = res_menu(idr_task_menu)
  task_win_Title = "SETUP"
  task_win_Help  = idh_contents
%END Task Window, CreateParms

clauses

%BEGIN Task Window, e_Create
  task_win_eh(_Win,e_Create(_),0):-!,
%BEGIN Task Window, InitControls, 17:19:18-24.11.1999, Code automatically updated!
%END Task Window, InitControls
%BEGIN Task Window, ToolbarCreate, 17:19:18-24.11.1999, Code automatically updated!
%END Task Window, ToolbarCreate
ifdef use_message
	msg_Create(100),
enddef
	!.
%END Task Window, e_Create

%MARK Task Window, new events

%BEGIN Task Window, e_Size
  task_win_eh(_Win,e_Size(_Width,_Height),0):-!,
ifdef use_tbar
	toolbar_Resize(_Win),
enddef
ifdef use_message
	msg_Resize(_Win),
enddef
	!.
%END Task Window, e_Size

%END_WIN Task Window
enddef
