# Microsoft Visual C++ generated build script - Do not modify

PROJ = doclib
PROJPATH =
CFG=
D=0_obj\
CC = cl
!IF "$(CFG)"=="DEBUG"
CFLAGS = /nologo /Zp1 /Zi /Fo0_obj\ /Gs /Gx- /Gt16384 /AL
!ELSE
CFLAGS = /nologo /Zp1 /Fo0_obj\ /Gs /Gx- /Gt16384 /AL
!ENDIF

# ========================================================
#   Inference Rules
# ========================================================
.PRO.OBJ:
        $(PRO) $(PROFLAGS) $<
.C.OBJ:
	$(CC) $(CFLAGS) $<
#
#  Main Rule
#

OBJS=\
0_obj\rtf_font.obj\
0_obj\rtf_foot.obj\
0_obj\rtf_form.obj\
0_obj\rtf_key.obj\
0_obj\rtf_lex.obj\
0_obj\rtf_mem.obj\
0_obj\rtf_pro.obj\
0_obj\rtf_proc.obj\
0_obj\rtf_stmt.obj\
0_obj\rtf_tab.obj\
0_obj\html_key.obj\
0_obj\html_lex.obj\
0_obj\html_mem.obj\
0_obj\html_pro.obj\
0_obj\html_tab.obj\
0_obj\html_tag.obj\
0_obj\html_oi.obj\
0_obj\html_ii.obj\
0_obj\html_oo.obj\
0_obj\ipf_key.obj\
0_obj\ipf_lex.obj\
0_obj\ipf_mem.obj\
0_obj\ipf_pro.obj\
0_obj\ipf_tab.obj\
0_obj\ipf_tag.obj\
0_obj\ipf_sym.obj\
0_obj\ipf_p_oi.obj\
0_obj\ipf_p_ii.obj\
0_obj\ipf_p_oo.obj\
0_obj\atts.obj\
0_obj\list.obj\
0_obj\misc.obj


$(PROJ).lib: $(OBJS)
	@-if exist $@ erase $@
	@echo.
	@echo Creating library: $@
	@lib /PAGESIZE:64 /NOLOGO @<<
$@
y
$(OBJS)
;
<<


all: clean build install

build: $(PROJ).lib

install:
	copy $(PROJ).lib ..\lib\win16
	del $(PROJ).lib

clean:
	del 0_obj\*.obj

#
#  Dependencies
#

0_obj\rtf_font.obj:	rtf\rtf_font.c
	$(CC) $(CFLAGS) /c rtf\rtf_font.c

0_obj\rtf_foot.obj:	rtf\rtf_foot.c
	$(CC) $(CFLAGS) /c rtf\rtf_foot.c

0_obj\rtf_form.obj:	rtf\rtf_form.c
	$(CC) $(CFLAGS) /c rtf\rtf_form.c

0_obj\rtf_key.obj:	rtf\rtf_key.c
	$(CC) $(CFLAGS) /c rtf\rtf_key.c

0_obj\rtf_lex.obj:	rtf\rtf_lex.c
	$(CC) $(CFLAGS) /c rtf\rtf_lex.c

0_obj\rtf_mem.obj:	rtf\rtf_mem.c
	$(CC) $(CFLAGS) /c rtf\rtf_mem.c

0_obj\rtf_pro.obj:	rtf\rtf_pro.c
	$(CC) $(CFLAGS) /c rtf\rtf_pro.c

0_obj\rtf_proc.obj:	rtf\rtf_proc.c
	$(CC) $(CFLAGS) /c rtf\rtf_proc.c

0_obj\rtf_stmt.obj:	rtf\rtf_stmt.c
	$(CC) $(CFLAGS) /c rtf\rtf_stmt.c

0_obj\rtf_tab.obj:	rtf\rtf_tab.c
	$(CC) $(CFLAGS) /c rtf\rtf_tab.c

0_obj\html_key.obj:	html\html_key.c
	$(CC) $(CFLAGS) /c html\html_key.c

0_obj\html_lex.obj:	html\html_lex.c
	$(CC) $(CFLAGS) /c html\html_lex.c

0_obj\html_mem.obj:	html\html_mem.c
	$(CC) $(CFLAGS) /c html\html_mem.c

0_obj\html_pro.obj:	html\html_pro.c
	$(CC) $(CFLAGS) /c html\html_pro.c

0_obj\html_tab.obj:	html\html_tab.c
	$(CC) $(CFLAGS) /c html\html_tab.c

0_obj\html_tag.obj:	html\html_tag.c
	$(CC) $(CFLAGS) /c html\html_tag.c

0_obj\html_oi.obj:	html\html_oi.c
	$(CC) $(CFLAGS) /c html\html_oi.c

0_obj\html_ii.obj:	html\html_ii.c
	$(CC) $(CFLAGS) /c html\html_ii.c

0_obj\html_oo.obj:	html\html_oo.c
	$(CC) $(CFLAGS) /c html\html_oo.c

0_obj\ipf_key.obj:	ipf\ipf_key.c
	$(CC) $(CFLAGS) /c ipf\ipf_key.c

0_obj\ipf_lex.obj:	ipf\ipf_lex.c
	$(CC) $(CFLAGS) /c ipf\ipf_lex.c

0_obj\ipf_mem.obj:	ipf\ipf_mem.c
	$(CC) $(CFLAGS) /c ipf\ipf_mem.c

0_obj\ipf_pro.obj:	ipf\ipf_pro.c
	$(CC) $(CFLAGS) /c ipf\ipf_pro.c

0_obj\ipf_tab.obj:	ipf\ipf_tab.c
	$(CC) $(CFLAGS) /c ipf\ipf_tab.c

0_obj\ipf_tag.obj:	ipf\ipf_tag.c
	$(CC) $(CFLAGS) /c ipf\ipf_tag.c

0_obj\ipf_sym.obj:	ipf\ipf_sym.c
	$(CC) $(CFLAGS) /c ipf\ipf_sym.c

0_obj\ipf_p_oi.obj:	ipf\ipf_p_oi.c
	$(CC) $(CFLAGS) /c ipf\ipf_p_oi.c

0_obj\ipf_p_ii.obj:	ipf\ipf_p_ii.c
	$(CC) $(CFLAGS) /c ipf\ipf_p_ii.c

0_obj\ipf_p_oo.obj:	ipf\ipf_p_oo.c
	$(CC) $(CFLAGS) /c ipf\ipf_p_oo.c

0_obj\atts.obj:	common\atts.c
	$(CC) $(CFLAGS) /c common\atts.c

0_obj\list.obj:	common\list.c
	$(CC) $(CFLAGS) /c common\list.c

0_obj\misc.obj:	common\misc.c
	$(CC) $(CFLAGS) /c common\misc.c


html\html_lex.c: html\html.l
	flex -Sprolog.skl -L -Phtml_yy -ohtml\html_lex.c html\html.l

html\html_tab.c: html\html.y
	yacc -d -b html html\\html.y
	move html_tab.* html

ipf\ipf_lex.c: ipf\ipf.l
	flex -Sprolog.skl -L -Pipf_yy -oipf\ipf_lex.c ipf\ipf.l

ipf\ipf_tab.c: ipf\ipf.y
	yacc -d -b ipf ipf\\ipf.y
	move ipf_tab.* ipf

rtf\rtf_lex.c: rtf\rtf.l
        flex -Sprolog.skl -L -Prtf_yy -ortf\rtf_lex.c rtf\rtf.l

rtf\rtf_tab.c: rtf\rtf.y
        yacc -d -b rtf rtf\\rtf.y
	move rtf_tab.* rtf


