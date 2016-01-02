@echo off

set ARG=%1%
set BIT_FLAG=64
if /i "%PROCESSOR_IDENTIFIER:~0,3%"=="X86" set BIT_FLAG=32
echo "start build window exe os bit is %BIT_FLAG%"

if not exist bin mkdir bin

set port=8081
set curpath=%CD%
set cmdtitle=czplb
set outpath=%CD%\bin
set luavm=luacore.exe
if [%ARG%] neq [] set luavm=luacore_x64.exe
set main=%luavm%  main.lua  %port% 
set pack_exe="F:\Program Files (x86)\Inno Setup 5\Compil32.exe"


cd util\luajit
luajit204 -e "print('ljit version:',jit.version)"
for /f "delims==" %%i in ('dir ..\..\src\*.lua /b /s') do (
   echo  Compile  %%i
   luajit204 -b %%i %outpath%\%%~nxi
)   

echo "Compile success,copy %luavm%"

if not exist %outpath%\web mkdir %outpath%\web

copy  %curpath%\make.iss     %outpath%
copy  %curpath%\%luavm%      %outpath%
copy  %curpath%\sqlite3.dll  %outpath%
xcopy /e /y %curpath%\web\*  %outpath%\web

set dircmd=if not exist data  mkdir data 
set runcmd=start "%cmdtitle%" %main% 
set httpcmd=start http:\\127.0.0.1:%port%
set exitcmd=exit

@rem >> is append ^ is escape char

echo ^@echo off >%outpath%\run.bat
echo ^cd ^%%~dp0 >> %outpath%\run.bat
echo %dircmd%  >> %outpath%\run.bat
echo %runcmd%  >> %outpath%\run.bat
echo %httpcmd% >> %outpath%\run.bat

echo "copy success ,next will package"

@rem if is 64bit create temp file
if [%ARG%] neq [] echo "os64">%curpath%\os_64.txt
call %pack_exe% /cc %curpath%\make.iss
if [%ARG%] neq [] del /a /f /s /q  %curpath%\os_64.txt
    
cd %outpath%
del /a /f /s /q %outpath%\web
del /a /f /s /q %outpath%\*.lua
del /a /f /s /q %outpath%\*.bat
del /a /f /s /q %outpath%\*.dll
del /a /f /s /q %outpath%\*.iss
del /a /f /s /q %outpath%\%luavm%
rd /s/q         %outpath%\web

cd %curpath%

:END
