@echo off
echo.
echo DOCTOOL Grammar Build
echo Copyright (C) 1984-98, Prolog Development Center A/S
echo.

if "%1"=="" goto Usage
if "%1"=="/?" goto Usage
if "%1"=="?" goto Usage
if "%1"=="-?" goto Usage
if "%1"=="/h" goto Usage
if "%1"=="-h" goto Usage
if "%1"=="/H" goto Usage
if "%1"=="-H" goto Usage
if "%1"=="HELP" goto Usage
if "%1"=="Help" goto Usage
if "%1"=="help" goto Usage
if "%1"=="/help" goto Usage
if "%1"=="/HELP" goto Usage
if "%1"=="/Help" goto Usage

if "%1"=="all" goto HTML

:Loop
if "%1"=="" goto End
if "%1"=="html" goto HTML
if "%1"=="rtf" goto RTF
if "%1"=="ipf" goto IPF
goto End

:HTML
echo Build grammar for HTML
echo.
c:\lex-yacc\bin\flex -Sprolog.skl -L -Phtml_yy -ohtml\html_lex.c html\html.l
c:\lex-yacc\bin\yacc -d -b html html\\html.y
move html_tab.* html

if "%1"=="all" goto IPF
shift
goto Loop


:IPF
echo.
echo Build grammar for IPF
echo.
flex -Sprolog.skl -L -Pipf_yy -oipf\ipf_lex.c ipf\ipf.l
yacc -d -b ipf ipf\\ipf.y
move ipf_tab.* ipf

if "%1"=="all" goto RTF
shift
goto Loop

:RTF
echo.
echo Build grammar for RTF
echo.
flex -Sprolog.skl -L -Prtf_yy -ortf\rtf_lex.c rtf\rtf.l
yacc -d -b rtf rtf\\rtf.y
move rtf_tab.* rtf

if "%1"=="all" goto End
shift
goto Loop


:Usage
echo Usage: gram [html [rtf [ipf]] [all] [help]
echo.
echo        html - build HTML grammar
echo        rtf  - build RTF grammar
echo        ipf  - build IPF grammar
echo        all  - build all
echo        help - display this message
echo.
:End
