@echo off

set port=8080
set arch=x86_64
set curpath=%CD%
set main=main.lua
set outpath=%CD%\bin
set luavm=luacore_x84_64
set dest=centos_%arch%_czplb

@rem compile lua file
cd    util\luajit
luajit204 -e "print('ljit version:',jit.version)"
for /f "delims==" %%i in ('dir ..\..\src\*.lua /b/s') do (
   echo  Compile  %%i
   luajit204 -b %%i %outpath%\%%~nxi
)
 
copy /y %curpath%\%luavm%  %outpath%\
xcopy /e /y %curpath%\web\*  %outpath%\web\

echo chmod 777 ./%luavm%;./%luavm% %main% %port%>%outpath%\run.sh

cd %outpath%
tar -cvf %dest%.tar.gz ./*.lua ./lu* ./web*
@rem copy %dest%.tar.gz  I:\vm_win7_share

del /a /f /s /q    %outpath%\web
del /a /f /s /q    %outpath%\*.sh
del /a /f /s /q    %outpath%\*.lua
del /a /f /s /q    %outpath%\%luavm%
rd /s/q  %outpath%\web

cd %curpath%
echo "finished"
:END