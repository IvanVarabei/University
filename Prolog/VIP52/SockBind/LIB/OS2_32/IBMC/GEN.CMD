@echo off

rem Usage: gen [DEB]

set _run_path=..\..\

if exist %_RUN_PATH%_s_gen.bat goto Start
echo File %_RUN_PATH%_s_gen.bat is not found
goto Stop

:Start
if exist %_RUN_PATH%_s_gen.cmd del %_RUN_PATH%_s_gen.cmd
copy %_RUN_PATH%_s_gen.bat %_RUN_PATH%_s_gen.cmd

set _is_debug=NOD

if x%1 == x goto Run
set _is_debug=%1

:Run
call %_RUN_PATH%_s_gen OS32 ICC %_IS_DEBUG%

if exist %_RUN_PATH%_s_gen.cmd del %_RUN_PATH%_s_gen.cmd

set _is_debug=

:Stop
set _run_path=

