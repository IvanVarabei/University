#=============================================================
#
#	DOCLIB.MAK - Makefile for project D:\DEVELOPS\DOC_TOOL\SOURCE\DOCLIB.PRJ
#		Created on 12/24/96 at 23:10
#
#=============================================================

.AUTODEPEND

.PATH.obj = .\0_OBJOS2

#=============================================================
#		Translator Definitions
#=============================================================
CC = bcc +DOCLIB.CFG
TASM = tasm.exe
TLIB = tlib.exe
TLINK = tlink
RC = brcc.exe
RB = rc.exe
LIBPATH = D:\BCOS2\LIB
INCLUDEPATH = D:\BCOS2\INCLUDE;.\COMMON;.\HTML;.\RTF;.\IPF


#=============================================================
#		Implicit Rules
#=============================================================
.c.obj:
  $(CC) -c {$< }

.cpp.obj:
  $(CC) -c {$< }

.asm.obj:
  $(TASM) -Mx $*.asm,$*.obj

.rc.res:
  $(RC) -r $*.rc

#=============================================================
#		List Macros
#=============================================================


LIB_DEPENDENCIES =  \
 rtf_tab.obj \
 rtf_stmt.obj \
 rtf_proc.obj \
 rtf_pro.obj \
 rtf_mem.obj \
 rtf_lex.obj \
 rtf_key.obj \
 rtf_foot.obj \
 rtf_form.obj \
 rtf_font.obj \
 ipf_tag.obj \
 ipf_tab.obj \
 ipf_mem.obj \
 ipf_lex.obj \
 ipf_key.obj \
 ipf_pro.obj \
 ipf_p_oi.obj \
 ipf_p_ii.obj \
 ipf_p_oo.obj \
 ipf_sym.obj \
 html_tag.obj \
 html_tab.obj \
 html_pro.obj \
 html_mem.obj \
 html_lex.obj \
 html_key.obj \
 html_oi.obj \
 html_ii.obj \
 html_oo.obj \
 misc.obj \
 list.obj \
 atts.obj

#=============================================================
#		Explicit Rules
#=============================================================


build: ..\lib\os2_32\bc\doclib.lib

clean:
	del .\0_objos2\*.* /N

all: clean build

..\lib\os2_32\bc\doclib.lib: doclib.cfg $(LIB_DEPENDENCIES)
  - del ..\lib\os2_32\bc\doclib.lib
  $(TLIB) $<  @&&|
-+.\0_objos2\rtf_tab.obj &
-+.\0_objos2\rtf_stmt.obj &
-+.\0_objos2\rtf_proc.obj &
-+.\0_objos2\rtf_pro.obj &
-+.\0_objos2\rtf_mem.obj &
-+.\0_objos2\rtf_lex.obj &
-+.\0_objos2\rtf_key.obj &
-+.\0_objos2\rtf_foot.obj &
-+.\0_objos2\rtf_form.obj &
-+.\0_objos2\rtf_font.obj &
-+.\0_objos2\ipf_tag.obj &
-+.\0_objos2\ipf_tab.obj &
-+.\0_objos2\ipf_mem.obj &
-+.\0_objos2\ipf_lex.obj &
-+.\0_objos2\ipf_key.obj &
-+.\0_objos2\ipf_pro.obj &
-+.\0_OBJOS2\ipf_p_oi.obj &
-+.\0_OBJOS2\ipf_p_ii.obj &
-+.\0_OBJOS2\ipf_p_oo.obj &
-+.\0_OBJOS2\ipf_sym.obj &
-+.\0_objos2\html_tag.obj &
-+.\0_objos2\html_tab.obj &
-+.\0_objos2\html_pro.obj &
-+.\0_objos2\html_mem.obj &
-+.\0_objos2\html_lex.obj &
-+.\0_objos2\html_key.obj &
-+.\0_OBJOS2\html_oi.obj &
-+.\0_OBJOS2\html_ii.obj &
-+.\0_OBJOS2\html_oo.obj &
-+.\0_objos2\misc.obj &
-+.\0_objos2\list.obj &
-+.\0_objos2\atts.obj
|

#=============================================================
#		Individual File Dependencies
#=============================================================
RTF_TAB.obj: doclib.cfg RTF\RTF_TAB.C
	$(CC) -c RTF\RTF_TAB.C

RTF_STMT.obj: doclib.cfg RTF\RTF_STMT.C
	$(CC) -c RTF\RTF_STMT.C

RTF_PROC.obj: doclib.cfg RTF\RTF_PROC.C
	$(CC) -c RTF\RTF_PROC.C

RTF_PRO.obj: doclib.cfg RTF\RTF_PRO.C
	$(CC) -c RTF\RTF_PRO.C

RTF_MEM.obj: doclib.cfg RTF\RTF_MEM.C
	$(CC) -c RTF\RTF_MEM.C

RTF_LEX.obj: doclib.cfg RTF\RTF_LEX.C
	$(CC) -c RTF\RTF_LEX.C

RTF_KEY.obj: doclib.cfg RTF\RTF_KEY.C
	$(CC) -c RTF\RTF_KEY.C

RTF_FOOT.obj: doclib.cfg RTF\RTF_FOOT.C
	$(CC) -c RTF\RTF_FOOT.C

RTF_FORM.obj: doclib.cfg RTF\RTF_FORM.C
	$(CC) -c RTF\RTF_FORM.C

RTF_FONT.obj: doclib.cfg RTF\RTF_FONT.C
	$(CC) -c RTF\RTF_FONT.C

IPF_TAG.obj: doclib.cfg IPF\IPF_TAG.C
	$(CC) -c IPF\IPF_TAG.C

IPF_TAB.obj: doclib.cfg IPF\IPF_TAB.C
	$(CC) -c IPF\IPF_TAB.C

IPF_PRO.obj: doclib.cfg IPF\IPF_PRO.C
	$(CC) -c IPF\IPF_PRO.C

IPF_MEM.obj: doclib.cfg IPF\IPF_MEM.C
	$(CC) -c IPF\IPF_MEM.C

IPF_LEX.obj: doclib.cfg IPF\IPF_LEX.C
	$(CC) -c IPF\IPF_LEX.C

IPF_KEY.obj: doclib.cfg IPF\IPF_KEY.C
	$(CC) -c IPF\IPF_KEY.C


IPF_P_OI.obj: doclib.cfg IPF\IPF_P_OI.C
        $(CC) -c IPF\IPF_P_OI.C

IPF_P_II.obj: doclib.cfg IPF\IPF_P_II.C
        $(CC) -c IPF\IPF_P_II.C

IPF_P_OO.obj: doclib.cfg IPF\IPF_P_OO.C
        $(CC) -c IPF\IPF_P_OO.C

IPF_SYM.obj: doclib.cfg IPF\IPF_SYM.C
        $(CC) -c IPF\IPF_SYM.C

HTML_TAG.obj: doclib.cfg HTML\HTML_TAG.C
	$(CC) -c HTML\HTML_TAG.C

HTML_TAB.obj: doclib.cfg HTML\HTML_TAB.C
	$(CC) -c HTML\HTML_TAB.C

HTML_PRO.obj: doclib.cfg HTML\HTML_PRO.C
	$(CC) -c HTML\HTML_PRO.C

HTML_MEM.obj: doclib.cfg HTML\HTML_MEM.C
	$(CC) -c HTML\HTML_MEM.C

HTML_LEX.obj: doclib.cfg HTML\HTML_LEX.C
	$(CC) -c HTML\HTML_LEX.C

HTML_KEY.obj: doclib.cfg HTML\HTML_KEY.C
	$(CC) -c HTML\HTML_KEY.C

HTML_OI.obj: doclib.cfg  HTML\HTML_OI.C
        $(CC) -c HTML\HTML_OI.C

HTML_II.obj: doclib.cfg  HTML\HTML_II.C
        $(CC) -c HTML\HTML_II.C

HTML_OO.obj: doclib.cfg  HTML\HTML_OO.C
        $(CC) -c HTML\HTML_OO.C

MISC.obj: doclib.cfg COMMON\MISC.C
	$(CC) -c COMMON\MISC.C

LIST.obj: doclib.cfg COMMON\LIST.C
	$(CC) -c COMMON\LIST.C

ATTS.obj: doclib.cfg COMMON\ATTS.C
	$(CC) -c COMMON\ATTS.C

#=============================================================
#		Compiler Configuration File
#=============================================================
doclib.cfg: doclib.mak
  copy &&|
-DMLINEAR
-L$(LIBPATH)
-I$(INCLUDEPATH)
-n.\0_OBJOS2
-pc
-vi
-d
-Od
-r-
-K
-a4
| doclib.cfg



