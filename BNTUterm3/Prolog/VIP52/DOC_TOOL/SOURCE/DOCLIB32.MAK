# Microsoft Developer Studio Generated NMAKE File, Format Version 4.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

!IF "$(CFG)" == ""
CFG=Doclib32 - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to Doclib32 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "Doclib32 - Win32 Release" && "$(CFG)" !=\
 "Doclib32 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "Doclib32.mak" CFG="Doclib32 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Doclib32 - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "Doclib32 - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 
################################################################################
# Begin Project
# PROP Target_Last_Scanned "Doclib32 - Win32 Debug"
CPP=cl.exe

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "WinRel"
# PROP BASE Intermediate_Dir "WinRel"
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\lib\win32\msc"
# PROP Intermediate_Dir "0_obj32"
OUTDIR=.\..\lib\win32\msc
INTDIR=.\0_obj32

ALL : "$(OUTDIR)\DOCLIB.lib"

CLEAN : 
	-@erase "..\lib\win32\msc\DOCLIB.lib"
	-@erase ".\0_obj32\ATTS.OBJ"
	-@erase ".\0_obj32\Ipf_tab.obj"
	-@erase ".\0_obj32\RTF_LEX.OBJ"
	-@erase ".\0_obj32\RTF_STMT.OBJ"
	-@erase ".\0_obj32\Ipf_sym.obj"
	-@erase ".\0_obj32\RTF_FOOT.OBJ"
	-@erase ".\0_obj32\RTF_KEY.OBJ"
	-@erase ".\0_obj32\Ipf_p_oo.obj"
	-@erase ".\0_obj32\RTF_PROC.OBJ"
	-@erase ".\0_obj32\Ipf_p_ii.obj"
	-@erase ".\0_obj32\RTF_MEM.OBJ"
	-@erase ".\0_obj32\HTML_PRO.OBJ"
	-@erase ".\0_obj32\HTML_TAG.OBJ"
	-@erase ".\0_obj32\Ipf_mem.obj"
	-@erase ".\0_obj32\MISC.OBJ"
	-@erase ".\0_obj32\Html_oi.obj"
	-@erase ".\0_obj32\html_tab.obj"
	-@erase ".\0_obj32\RTF_FORM.OBJ"
	-@erase ".\0_obj32\RTF_FONT.OBJ"
	-@erase ".\0_obj32\RTF_PRO.OBJ"
	-@erase ".\0_obj32\HTML_LEX.OBJ"
	-@erase ".\0_obj32\Ipf_p_oi.obj"
	-@erase ".\0_obj32\HTML_KEY.OBJ"
	-@erase ".\0_obj32\rtf_tab.obj"
	-@erase ".\0_obj32\Ipf_lex.obj"
	-@erase ".\0_obj32\HTML_MEM.OBJ"
	-@erase ".\0_obj32\Ipf_key.obj"
	-@erase ".\0_obj32\Ipf_pro.obj"
	-@erase ".\0_obj32\Ipf_tag.obj"
	-@erase ".\0_obj32\Html_oo.obj"
	-@erase ".\0_obj32\LIST.OBJ"
	-@erase ".\0_obj32\Html_ii.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /FR /YX /c
# ADD CPP /nologo /Zp4 /W3 /GX /Od /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "MLINEAR" /YX /c
# SUBTRACT CPP /Fr
CPP_PROJ=/nologo /Zp4 /ML /W3 /GX /Od /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D\
 "MLINEAR" /Fp"$(INTDIR)/Doclib32.pch" /YX /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\0_obj32/
CPP_SBRS=
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/Doclib32.bsc" 
BSC32_SBRS=
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"..\lib\win32\msc\DOCLIB.lib"
LIB32_FLAGS=/nologo /out:"$(OUTDIR)/DOCLIB.lib" 
LIB32_OBJS= \
	"$(INTDIR)/ATTS.OBJ" \
	"$(INTDIR)/Ipf_tab.obj" \
	"$(INTDIR)/RTF_LEX.OBJ" \
	"$(INTDIR)/RTF_STMT.OBJ" \
	"$(INTDIR)/Ipf_sym.obj" \
	"$(INTDIR)/RTF_FOOT.OBJ" \
	"$(INTDIR)/RTF_KEY.OBJ" \
	"$(INTDIR)/Ipf_p_oo.obj" \
	"$(INTDIR)/RTF_PROC.OBJ" \
	"$(INTDIR)/Ipf_p_ii.obj" \
	"$(INTDIR)/RTF_MEM.OBJ" \
	"$(INTDIR)/HTML_PRO.OBJ" \
	"$(INTDIR)/HTML_TAG.OBJ" \
	"$(INTDIR)/Ipf_mem.obj" \
	"$(INTDIR)/MISC.OBJ" \
	"$(INTDIR)/Html_oi.obj" \
	"$(INTDIR)/html_tab.obj" \
	"$(INTDIR)/RTF_FORM.OBJ" \
	"$(INTDIR)/RTF_FONT.OBJ" \
	"$(INTDIR)/RTF_PRO.OBJ" \
	"$(INTDIR)/HTML_LEX.OBJ" \
	"$(INTDIR)/Ipf_p_oi.obj" \
	"$(INTDIR)/HTML_KEY.OBJ" \
	"$(INTDIR)/rtf_tab.obj" \
	"$(INTDIR)/Ipf_lex.obj" \
	"$(INTDIR)/HTML_MEM.OBJ" \
	"$(INTDIR)/Ipf_key.obj" \
	"$(INTDIR)/Ipf_pro.obj" \
	"$(INTDIR)/Ipf_tag.obj" \
	"$(INTDIR)/Html_oo.obj" \
	"$(INTDIR)/LIST.OBJ" \
	"$(INTDIR)/Html_ii.obj"

"$(OUTDIR)\DOCLIB.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "WinDebug"
# PROP BASE Intermediate_Dir "WinDebug"
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\lib\win32\msc"
# PROP Intermediate_Dir "0_obj32"
OUTDIR=.\..\lib\win32\msc
INTDIR=.\0_obj32

ALL : "$(OUTDIR)\DOCLIB.lib" "$(OUTDIR)\Doclib32.bsc"

CLEAN : 
	-@erase "..\lib\win32\msc\Doclib32.bsc"
	-@erase ".\0_obj32\Ipf_p_ii.sbr"
	-@erase ".\0_obj32\RTF_MEM.SBR"
	-@erase ".\0_obj32\HTML_PRO.SBR"
	-@erase ".\0_obj32\HTML_TAG.SBR"
	-@erase ".\0_obj32\Ipf_mem.sbr"
	-@erase ".\0_obj32\MISC.SBR"
	-@erase ".\0_obj32\Html_oi.sbr"
	-@erase ".\0_obj32\html_tab.sbr"
	-@erase ".\0_obj32\RTF_FORM.SBR"
	-@erase ".\0_obj32\RTF_FONT.SBR"
	-@erase ".\0_obj32\RTF_PRO.SBR"
	-@erase ".\0_obj32\HTML_LEX.SBR"
	-@erase ".\0_obj32\Ipf_p_oi.sbr"
	-@erase ".\0_obj32\HTML_KEY.SBR"
	-@erase ".\0_obj32\rtf_tab.sbr"
	-@erase ".\0_obj32\Ipf_lex.sbr"
	-@erase ".\0_obj32\HTML_MEM.SBR"
	-@erase ".\0_obj32\Ipf_key.sbr"
	-@erase ".\0_obj32\Ipf_pro.sbr"
	-@erase ".\0_obj32\Ipf_tag.sbr"
	-@erase ".\0_obj32\Html_oo.sbr"
	-@erase ".\0_obj32\LIST.SBR"
	-@erase ".\0_obj32\Html_ii.sbr"
	-@erase ".\0_obj32\ATTS.SBR"
	-@erase ".\0_obj32\Ipf_tab.sbr"
	-@erase ".\0_obj32\RTF_LEX.SBR"
	-@erase ".\0_obj32\RTF_STMT.SBR"
	-@erase ".\0_obj32\Ipf_sym.sbr"
	-@erase ".\0_obj32\RTF_FOOT.SBR"
	-@erase ".\0_obj32\RTF_KEY.SBR"
	-@erase ".\0_obj32\Ipf_p_oo.sbr"
	-@erase ".\0_obj32\RTF_PROC.SBR"
	-@erase "..\lib\win32\msc\DOCLIB.lib"
	-@erase ".\0_obj32\ATTS.OBJ"
	-@erase ".\0_obj32\Ipf_tab.obj"
	-@erase ".\0_obj32\RTF_LEX.OBJ"
	-@erase ".\0_obj32\RTF_STMT.OBJ"
	-@erase ".\0_obj32\Ipf_sym.obj"
	-@erase ".\0_obj32\RTF_FOOT.OBJ"
	-@erase ".\0_obj32\RTF_KEY.OBJ"
	-@erase ".\0_obj32\Ipf_p_oo.obj"
	-@erase ".\0_obj32\RTF_PROC.OBJ"
	-@erase ".\0_obj32\Ipf_p_ii.obj"
	-@erase ".\0_obj32\RTF_MEM.OBJ"
	-@erase ".\0_obj32\HTML_PRO.OBJ"
	-@erase ".\0_obj32\HTML_TAG.OBJ"
	-@erase ".\0_obj32\Ipf_mem.obj"
	-@erase ".\0_obj32\MISC.OBJ"
	-@erase ".\0_obj32\Html_oi.obj"
	-@erase ".\0_obj32\html_tab.obj"
	-@erase ".\0_obj32\RTF_FORM.OBJ"
	-@erase ".\0_obj32\RTF_FONT.OBJ"
	-@erase ".\0_obj32\RTF_PRO.OBJ"
	-@erase ".\0_obj32\HTML_LEX.OBJ"
	-@erase ".\0_obj32\Ipf_p_oi.obj"
	-@erase ".\0_obj32\HTML_KEY.OBJ"
	-@erase ".\0_obj32\rtf_tab.obj"
	-@erase ".\0_obj32\Ipf_lex.obj"
	-@erase ".\0_obj32\HTML_MEM.OBJ"
	-@erase ".\0_obj32\Ipf_key.obj"
	-@erase ".\0_obj32\Ipf_pro.obj"
	-@erase ".\0_obj32\Ipf_tag.obj"
	-@erase ".\0_obj32\Html_oo.obj"
	-@erase ".\0_obj32\LIST.OBJ"
	-@erase ".\0_obj32\Html_ii.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

# ADD BASE CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /FR /YX /c
# ADD CPP /nologo /Zp4 /W3 /GX /Z7 /Od /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "MLINEAR" /Fr /YX /c
CPP_PROJ=/nologo /Zp4 /MLd /W3 /GX /Z7 /Od /D "_DEBUG" /D "WIN32" /D "_WINDOWS"\
 /D "MLINEAR" /Fr"$(INTDIR)/" /Fp"$(INTDIR)/Doclib32.pch" /YX /Fo"$(INTDIR)/" /c\
 
CPP_OBJS=.\0_obj32/
CPP_SBRS=.\0_obj32/
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/Doclib32.bsc" 
BSC32_SBRS= \
	"$(INTDIR)/Ipf_p_ii.sbr" \
	"$(INTDIR)/RTF_MEM.SBR" \
	"$(INTDIR)/HTML_PRO.SBR" \
	"$(INTDIR)/HTML_TAG.SBR" \
	"$(INTDIR)/Ipf_mem.sbr" \
	"$(INTDIR)/MISC.SBR" \
	"$(INTDIR)/Html_oi.sbr" \
	"$(INTDIR)/html_tab.sbr" \
	"$(INTDIR)/RTF_FORM.SBR" \
	"$(INTDIR)/RTF_FONT.SBR" \
	"$(INTDIR)/RTF_PRO.SBR" \
	"$(INTDIR)/HTML_LEX.SBR" \
	"$(INTDIR)/Ipf_p_oi.sbr" \
	"$(INTDIR)/HTML_KEY.SBR" \
	"$(INTDIR)/rtf_tab.sbr" \
	"$(INTDIR)/Ipf_lex.sbr" \
	"$(INTDIR)/HTML_MEM.SBR" \
	"$(INTDIR)/Ipf_key.sbr" \
	"$(INTDIR)/Ipf_pro.sbr" \
	"$(INTDIR)/Ipf_tag.sbr" \
	"$(INTDIR)/Html_oo.sbr" \
	"$(INTDIR)/LIST.SBR" \
	"$(INTDIR)/Html_ii.sbr" \
	"$(INTDIR)/ATTS.SBR" \
	"$(INTDIR)/Ipf_tab.sbr" \
	"$(INTDIR)/RTF_LEX.SBR" \
	"$(INTDIR)/RTF_STMT.SBR" \
	"$(INTDIR)/Ipf_sym.sbr" \
	"$(INTDIR)/RTF_FOOT.SBR" \
	"$(INTDIR)/RTF_KEY.SBR" \
	"$(INTDIR)/Ipf_p_oo.sbr" \
	"$(INTDIR)/RTF_PROC.SBR"

"$(OUTDIR)\Doclib32.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"..\lib\win32\msc\DOCLIB.lib"
LIB32_FLAGS=/nologo /out:"$(OUTDIR)/DOCLIB.lib" 
LIB32_OBJS= \
	"$(INTDIR)/ATTS.OBJ" \
	"$(INTDIR)/Ipf_tab.obj" \
	"$(INTDIR)/RTF_LEX.OBJ" \
	"$(INTDIR)/RTF_STMT.OBJ" \
	"$(INTDIR)/Ipf_sym.obj" \
	"$(INTDIR)/RTF_FOOT.OBJ" \
	"$(INTDIR)/RTF_KEY.OBJ" \
	"$(INTDIR)/Ipf_p_oo.obj" \
	"$(INTDIR)/RTF_PROC.OBJ" \
	"$(INTDIR)/Ipf_p_ii.obj" \
	"$(INTDIR)/RTF_MEM.OBJ" \
	"$(INTDIR)/HTML_PRO.OBJ" \
	"$(INTDIR)/HTML_TAG.OBJ" \
	"$(INTDIR)/Ipf_mem.obj" \
	"$(INTDIR)/MISC.OBJ" \
	"$(INTDIR)/Html_oi.obj" \
	"$(INTDIR)/html_tab.obj" \
	"$(INTDIR)/RTF_FORM.OBJ" \
	"$(INTDIR)/RTF_FONT.OBJ" \
	"$(INTDIR)/RTF_PRO.OBJ" \
	"$(INTDIR)/HTML_LEX.OBJ" \
	"$(INTDIR)/Ipf_p_oi.obj" \
	"$(INTDIR)/HTML_KEY.OBJ" \
	"$(INTDIR)/rtf_tab.obj" \
	"$(INTDIR)/Ipf_lex.obj" \
	"$(INTDIR)/HTML_MEM.OBJ" \
	"$(INTDIR)/Ipf_key.obj" \
	"$(INTDIR)/Ipf_pro.obj" \
	"$(INTDIR)/Ipf_tag.obj" \
	"$(INTDIR)/Html_oo.obj" \
	"$(INTDIR)/LIST.OBJ" \
	"$(INTDIR)/Html_ii.obj"

"$(OUTDIR)\DOCLIB.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.c{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Target

# Name "Doclib32 - Win32 Release"
# Name "Doclib32 - Win32 Debug"

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

!ENDIF 

################################################################################
# Begin Source File

SOURCE=.\HTML\HTML_MEM.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_HTML_=\
	".\Html\Html.h"\
	".\Html\Html_tab.h"\
	".\Html\Html_mem.h"\
	".\Common\List.h"\
	".\Config.h"\
	".\Html\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_HTML_=\
	".\Html\html\y_pdcdef.h"\
	

"$(INTDIR)\HTML_MEM.OBJ" : $(SOURCE) $(DEP_CPP_HTML_) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_HTML_=\
	".\Html\Html.h"\
	".\Html\Html_tab.h"\
	".\Html\Html_mem.h"\
	".\Common\List.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\HTML_MEM.OBJ" : $(SOURCE) $(DEP_CPP_HTML_) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\HTML_MEM.SBR" : $(SOURCE) $(DEP_CPP_HTML_) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\RTF_MEM.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_M=\
	".\Common\Ibmmap.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Rtf_pro.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\RTF_MEM.OBJ" : $(SOURCE) $(DEP_CPP_RTF_M) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_M=\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Rtf_pro.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_font.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\RTF_MEM.OBJ" : $(SOURCE) $(DEP_CPP_RTF_M) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\RTF_MEM.SBR" : $(SOURCE) $(DEP_CPP_RTF_M) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\COMMON\MISC.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_MISC_=\
	".\Common\Ibmmap.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\RTF\..\common/y_pdcdef.h"\
	

"$(INTDIR)\MISC.OBJ" : $(SOURCE) $(DEP_CPP_MISC_) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_MISC_=\
	".\Config.h"\
	".\Docstr.h"\
	".\RTF\..\common/y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\MISC.OBJ" : $(SOURCE) $(DEP_CPP_MISC_) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\MISC.SBR" : $(SOURCE) $(DEP_CPP_MISC_) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\RTF_FONT.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_F=\
	".\Common\Ibmmap.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_pro.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\RTF_FONT.OBJ" : $(SOURCE) $(DEP_CPP_RTF_F) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_F=\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_pro.h"\
	".\Common\List.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\RTF_FONT.OBJ" : $(SOURCE) $(DEP_CPP_RTF_F) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\RTF_FONT.SBR" : $(SOURCE) $(DEP_CPP_RTF_F) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\COMMON\ATTS.C
DEP_CPP_ATTS_=\
	".\Common\Atts.h"\
	".\Common\Misc.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\RTF\..\common/y_pdcdef.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_ATTS_=\
	".\COMMON\config.h"\
	".\COMMON\docstr.h"\
	".\COMMON\common\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\ATTS.OBJ" : $(SOURCE) $(DEP_CPP_ATTS_) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\ATTS.OBJ" : $(SOURCE) $(DEP_CPP_ATTS_) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\ATTS.SBR" : $(SOURCE) $(DEP_CPP_ATTS_) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\RTF_STMT.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_S=\
	".\Common\Ibmmap.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_foot.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Rtf_pro.h"\
	".\Rtf\Rtf_stmt.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\RTF_STMT.OBJ" : $(SOURCE) $(DEP_CPP_RTF_S) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_S=\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_stmt.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_foot.h"\
	".\Rtf\Rtf_pro.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\RTF_STMT.OBJ" : $(SOURCE) $(DEP_CPP_RTF_S) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\RTF_STMT.SBR" : $(SOURCE) $(DEP_CPP_RTF_S) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\COMMON\LIST.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_LIST_=\
	".\Common\Ibmmap.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\RTF\..\common/y_pdcdef.h"\
	

"$(INTDIR)\LIST.OBJ" : $(SOURCE) $(DEP_CPP_LIST_) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_LIST_=\
	".\Config.h"\
	".\RTF\..\common/y_pdcdef.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\LIST.OBJ" : $(SOURCE) $(DEP_CPP_LIST_) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\LIST.SBR" : $(SOURCE) $(DEP_CPP_LIST_) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\RTF_PROC.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_P=\
	".\Common\Ibmmap.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_foot.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_key.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Rtf_pro.h"\
	".\Rtf\Rtf_proc.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\RTF_PROC.OBJ" : $(SOURCE) $(DEP_CPP_RTF_P) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_P=\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Rtf_key.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_foot.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_proc.h"\
	".\Rtf\Rtf_pro.h"\
	".\Common\List.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\RTF_PROC.OBJ" : $(SOURCE) $(DEP_CPP_RTF_P) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\RTF_PROC.SBR" : $(SOURCE) $(DEP_CPP_RTF_P) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\RTF_FORM.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_FO=\
	".\Common\Ibmmap.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_pro.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\RTF_FORM.OBJ" : $(SOURCE) $(DEP_CPP_RTF_FO) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_FO=\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_pro.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\RTF_FORM.OBJ" : $(SOURCE) $(DEP_CPP_RTF_FO) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\RTF_FORM.SBR" : $(SOURCE) $(DEP_CPP_RTF_FO) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\HTML\html_tab.c

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_HTML_T=\
	".\Html\Html.h"\
	".\Html\Html_tag.h"\
	".\Config.h"\
	".\Html\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_HTML_T=\
	".\Html\html\y_pdcdef.h"\
	

"$(INTDIR)\html_tab.obj" : $(SOURCE) $(DEP_CPP_HTML_T) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_HTML_T=\
	".\Html\Html.h"\
	".\Html\Html_tag.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\html_tab.obj" : $(SOURCE) $(DEP_CPP_HTML_T) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\html_tab.sbr" : $(SOURCE) $(DEP_CPP_HTML_T) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\HTML\HTML_LEX.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_HTML_L=\
	".\Html\Html.h"\
	".\Html\Html_tab.h"\
	".\Config.h"\
	".\Html\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_HTML_L=\
	".\Html\html\y_pdcdef.h"\
	

"$(INTDIR)\HTML_LEX.OBJ" : $(SOURCE) $(DEP_CPP_HTML_L) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_HTML_L=\
	".\Html\Html.h"\
	".\Html\Html_tab.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\HTML_LEX.OBJ" : $(SOURCE) $(DEP_CPP_HTML_L) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\HTML_LEX.SBR" : $(SOURCE) $(DEP_CPP_HTML_L) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\rtf_tab.c

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_T=\
	".\Common\Ibmmap.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Rtf_proc.h"\
	".\Rtf\Rtf_stmt.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\rtf_tab.obj" : $(SOURCE) $(DEP_CPP_RTF_T) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_T=\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Rtf_stmt.h"\
	".\Rtf\Rtf_proc.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\rtf_tab.obj" : $(SOURCE) $(DEP_CPP_RTF_T) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\rtf_tab.sbr" : $(SOURCE) $(DEP_CPP_RTF_T) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\RTF_LEX.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_L=\
	".\Common\Ibmmap.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\RTF\..\common/y_pdcdef.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_tab.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\RTF_LEX.OBJ" : $(SOURCE) $(DEP_CPP_RTF_L) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_L=\
	".\Rtf\Rtf_tab.h"\
	".\Rtf\Rtf.h"\
	".\RTF\..\common/y_pdcdef.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\RTF_LEX.OBJ" : $(SOURCE) $(DEP_CPP_RTF_L) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\RTF_LEX.SBR" : $(SOURCE) $(DEP_CPP_RTF_L) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\RTF_FOOT.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_FOO=\
	".\Common\Ibmmap.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_foot.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\RTF_FOOT.OBJ" : $(SOURCE) $(DEP_CPP_RTF_FOO) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_FOO=\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_foot.h"\
	".\Rtf\Rtf_mem.h"\
	".\Common\List.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\RTF_FOOT.OBJ" : $(SOURCE) $(DEP_CPP_RTF_FOO) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\RTF_FOOT.SBR" : $(SOURCE) $(DEP_CPP_RTF_FOO) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\HTML\HTML_TAG.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_HTML_TA=\
	".\Html\Html.h"\
	".\Html\Html_tag.h"\
	".\Html\Html_key.h"\
	".\Html\Html_mem.h"\
	".\Html\Html_pro.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Atts.h"\
	".\Config.h"\
	".\Html\Y_pdcdef.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_HTML_TA=\
	".\Html\html\y_pdcdef.h"\
	

"$(INTDIR)\HTML_TAG.OBJ" : $(SOURCE) $(DEP_CPP_HTML_TA) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_HTML_TA=\
	".\Html\Html.h"\
	".\Html\Html_tag.h"\
	".\Html\Html_key.h"\
	".\Html\Html_mem.h"\
	".\Html\Html_pro.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Atts.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\HTML_TAG.OBJ" : $(SOURCE) $(DEP_CPP_HTML_TA) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\HTML_TAG.SBR" : $(SOURCE) $(DEP_CPP_HTML_TA) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\HTML\HTML_PRO.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_HTML_P=\
	".\Html\Html.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Atts.h"\
	".\Html\Html_key.h"\
	".\Html\Html_tag.h"\
	".\Html\Html_pro.h"\
	".\Html\Html_mem.h"\
	".\Config.h"\
	".\Html\Y_pdcdef.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_HTML_P=\
	".\Html\html\y_pdcdef.h"\
	

"$(INTDIR)\HTML_PRO.OBJ" : $(SOURCE) $(DEP_CPP_HTML_P) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_HTML_P=\
	".\Html\Html.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Atts.h"\
	".\Html\Html_key.h"\
	".\Html\Html_tag.h"\
	".\Html\Html_pro.h"\
	".\Html\Html_mem.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\HTML_PRO.OBJ" : $(SOURCE) $(DEP_CPP_HTML_P) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\HTML_PRO.SBR" : $(SOURCE) $(DEP_CPP_HTML_P) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\HTML\HTML_KEY.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_HTML_K=\
	".\Html\Html.h"\
	".\Html\Html_key.h"\
	".\Common\Misc.h"\
	".\Config.h"\
	".\Html\Y_pdcdef.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_HTML_K=\
	".\Html\html\y_pdcdef.h"\
	

"$(INTDIR)\HTML_KEY.OBJ" : $(SOURCE) $(DEP_CPP_HTML_K) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_HTML_K=\
	".\Html\Html.h"\
	".\Html\Html_key.h"\
	".\Common\Misc.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\HTML_KEY.OBJ" : $(SOURCE) $(DEP_CPP_HTML_K) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\HTML_KEY.SBR" : $(SOURCE) $(DEP_CPP_HTML_K) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\RTF_PRO.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_PR=\
	".\Common\Atts.h"\
	".\Common\Ibmmap.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_mem.h"\
	".\Rtf\Rtf_pro.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\RTF_PRO.OBJ" : $(SOURCE) $(DEP_CPP_RTF_PR) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_PR=\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_pro.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_form.h"\
	".\Rtf\Rtf_mem.h"\
	".\Common\List.h"\
	".\Common\Atts.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\RTF_PRO.OBJ" : $(SOURCE) $(DEP_CPP_RTF_PR) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\RTF_PRO.SBR" : $(SOURCE) $(DEP_CPP_RTF_PR) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\RTF\RTF_KEY.C

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_RTF_K=\
	".\Common\Ibmmap.h"\
	".\Common\Misc.h"\
	".\Common\Pdcrunt.h"\
	".\Config.h"\
	".\Docstr.h"\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_font.h"\
	".\Rtf\Rtf_key.h"\
	".\Rtf\Rtf_pro.h"\
	".\Rtf\Y_pdcdef.h"\
	

"$(INTDIR)\RTF_KEY.OBJ" : $(SOURCE) $(DEP_CPP_RTF_K) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_RTF_K=\
	".\Rtf\Rtf.h"\
	".\Rtf\Rtf_key.h"\
	".\Rtf\Rtf_font.h"\
	".\Common\Misc.h"\
	".\Rtf\Rtf_pro.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\RTF_KEY.OBJ" : $(SOURCE) $(DEP_CPP_RTF_K) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\RTF_KEY.SBR" : $(SOURCE) $(DEP_CPP_RTF_K) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_tag.c
DEP_CPP_IPF_T=\
	".\Ipf\Ipf.h"\
	".\Ipf\Ipf_tag.h"\
	".\Ipf\Ipf_key.h"\
	".\Ipf\Ipf_mem.h"\
	".\Ipf\Ipf_pro.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Atts.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_T=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_tag.obj" : $(SOURCE) $(DEP_CPP_IPF_T) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_tag.obj" : $(SOURCE) $(DEP_CPP_IPF_T) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_tag.sbr" : $(SOURCE) $(DEP_CPP_IPF_T) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_lex.c
DEP_CPP_IPF_L=\
	".\Ipf\Ipf.h"\
	".\Ipf\Ipf_tab.h"\
	".\Ipf\Ipf_key.h"\
	".\Ipf\Ipf_tag.h"\
	".\Ipf\Ipf_sym.h"\
	".\Common\Misc.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_L=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_lex.obj" : $(SOURCE) $(DEP_CPP_IPF_L) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_lex.obj" : $(SOURCE) $(DEP_CPP_IPF_L) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_lex.sbr" : $(SOURCE) $(DEP_CPP_IPF_L) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_mem.c
DEP_CPP_IPF_M=\
	".\Ipf\Ipf.h"\
	".\Ipf\Ipf_tab.h"\
	".\Ipf\Ipf_mem.h"\
	".\Common\List.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_M=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_mem.obj" : $(SOURCE) $(DEP_CPP_IPF_M) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_mem.obj" : $(SOURCE) $(DEP_CPP_IPF_M) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_mem.sbr" : $(SOURCE) $(DEP_CPP_IPF_M) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_pro.c
DEP_CPP_IPF_P=\
	".\Ipf\Ipf.h"\
	".\Common\List.h"\
	".\Common\Misc.h"\
	".\Common\Atts.h"\
	".\Ipf\Ipf_key.h"\
	".\Ipf\Ipf_tag.h"\
	".\Ipf\Ipf_pro.h"\
	".\Ipf\Ipf_mem.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_P=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_pro.obj" : $(SOURCE) $(DEP_CPP_IPF_P) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_pro.obj" : $(SOURCE) $(DEP_CPP_IPF_P) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_pro.sbr" : $(SOURCE) $(DEP_CPP_IPF_P) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_tab.c
DEP_CPP_IPF_TA=\
	".\Ipf\Ipf.h"\
	".\Ipf\Ipf_tag.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_TA=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_tab.obj" : $(SOURCE) $(DEP_CPP_IPF_TA) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_tab.obj" : $(SOURCE) $(DEP_CPP_IPF_TA) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_tab.sbr" : $(SOURCE) $(DEP_CPP_IPF_TA) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_key.c
DEP_CPP_IPF_K=\
	".\Ipf\Ipf.h"\
	".\Ipf\Ipf_key.h"\
	".\Common\Misc.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_K=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_key.obj" : $(SOURCE) $(DEP_CPP_IPF_K) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_key.obj" : $(SOURCE) $(DEP_CPP_IPF_K) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_key.sbr" : $(SOURCE) $(DEP_CPP_IPF_K) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Html\Html_oo.c

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_HTML_O=\
	".\Html\Html.h"\
	".\Config.h"\
	".\Html\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_HTML_O=\
	".\Html\html\y_pdcdef.h"\
	

"$(INTDIR)\Html_oo.obj" : $(SOURCE) $(DEP_CPP_HTML_O) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_HTML_O=\
	".\Html\Html.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Html_oo.obj" : $(SOURCE) $(DEP_CPP_HTML_O) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Html_oo.sbr" : $(SOURCE) $(DEP_CPP_HTML_O) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Html\Html_oi.c

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_HTML_OI=\
	".\Html\Html.h"\
	".\Config.h"\
	".\Html\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_HTML_OI=\
	".\Html\html\y_pdcdef.h"\
	

"$(INTDIR)\Html_oi.obj" : $(SOURCE) $(DEP_CPP_HTML_OI) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_HTML_OI=\
	".\Html\Html.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Html_oi.obj" : $(SOURCE) $(DEP_CPP_HTML_OI) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Html_oi.sbr" : $(SOURCE) $(DEP_CPP_HTML_OI) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Html\Html_ii.c

!IF  "$(CFG)" == "Doclib32 - Win32 Release"

DEP_CPP_HTML_I=\
	".\Html\Html.h"\
	".\Config.h"\
	".\Html\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_HTML_I=\
	".\Html\html\y_pdcdef.h"\
	

"$(INTDIR)\Html_ii.obj" : $(SOURCE) $(DEP_CPP_HTML_I) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"

DEP_CPP_HTML_I=\
	".\Html\Html.h"\
	

BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Html_ii.obj" : $(SOURCE) $(DEP_CPP_HTML_I) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Html_ii.sbr" : $(SOURCE) $(DEP_CPP_HTML_I) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_sym.c
DEP_CPP_IPF_S=\
	".\Ipf\Ipf.h"\
	".\Ipf\Ipf_sym.h"\
	".\Ipf\Ipf_tag.h"\
	".\Common\Misc.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_S=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_sym.obj" : $(SOURCE) $(DEP_CPP_IPF_S) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_sym.obj" : $(SOURCE) $(DEP_CPP_IPF_S) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_sym.sbr" : $(SOURCE) $(DEP_CPP_IPF_S) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_p_oi.c
DEP_CPP_IPF_P_=\
	".\Ipf\Ipf.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_P_=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_p_oi.obj" : $(SOURCE) $(DEP_CPP_IPF_P_) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_p_oi.obj" : $(SOURCE) $(DEP_CPP_IPF_P_) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_p_oi.sbr" : $(SOURCE) $(DEP_CPP_IPF_P_) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_p_oo.c
DEP_CPP_IPF_P_O=\
	".\Ipf\Ipf.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_P_O=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_p_oo.obj" : $(SOURCE) $(DEP_CPP_IPF_P_O) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_p_oo.obj" : $(SOURCE) $(DEP_CPP_IPF_P_O) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_p_oo.sbr" : $(SOURCE) $(DEP_CPP_IPF_P_O) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\Ipf\Ipf_p_ii.c
DEP_CPP_IPF_P_I=\
	".\Ipf\Ipf.h"\
	".\Config.h"\
	".\Ipf\Y_pdcdef.h"\
	".\Common\Misc.h"\
	".\Docstr.h"\
	".\Common\Pdcrunt.h"\
	".\Common\Ibmmap.h"\
	
NODEP_CPP_IPF_P_I=\
	".\Ipf\ipf\y_pdcdef.h"\
	

!IF  "$(CFG)" == "Doclib32 - Win32 Release"


"$(INTDIR)\Ipf_p_ii.obj" : $(SOURCE) $(DEP_CPP_IPF_P_I) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "Doclib32 - Win32 Debug"


BuildCmds= \
	$(CPP) $(CPP_PROJ) $(SOURCE) \
	

"$(INTDIR)\Ipf_p_ii.obj" : $(SOURCE) $(DEP_CPP_IPF_P_I) "$(INTDIR)"
   $(BuildCmds)

"$(INTDIR)\Ipf_p_ii.sbr" : $(SOURCE) $(DEP_CPP_IPF_P_I) "$(INTDIR)"
   $(BuildCmds)

!ENDIF 

# End Source File
# End Target
# End Project
################################################################################
