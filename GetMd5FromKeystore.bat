:: 从keystore 获取MD5和sha1
@echo off
setlocal EnableDelayedExpansion 

set currentPath=%cd%
set md5File=%currentPath%\md5AndSha1.txt
set javaPath=%JAVA_HOME%\bin

for /f "tokens=1,2 delims==" %%i in (%currentPath%\GetMd5Config.properties) do (
if "%%i"=="keyPath" set keyPath=%%j
if "%%i"=="alias" set alias=%%j
if "%%i"=="storePassword" set storePassword=%%j
)

::获取盘符
%javaPath:~0,2% 
cd %javaPath%
keytool -list -keystore %keyPath% -alias %alias% -v -storepass %storePassword%>%md5File%

set md5=
set sha1=
set sha256=
set line=0


for /f "delims=" %%i in (%md5File%) do (
    set /a line+=1
    echo %%i
    ::if %%i|findstr "md5" (echo hasmd5) else (echo has not md5)
    if !line!==11 (set md5=%%i)
    if !line!==12 (set sha1=%%i)
    if !line!==13 (set sha256=%%i)   
)

del %md5File%

::去掉冒号
set md5=!md5:^:=!

set "down=a b c d e f g h i j k l m n o p q r s t u v w x y z"  
::转换成小写
call :downcase "%md5%" result
set md5=%result%   
::set md5=%result:~6,32%   
::set sha1=%sha1:~8,59%
echo %md5%>>%md5File%
echo %sha1% >>%md5File%
echo %sha256% >>%md5File%

::转换成小写
:downcase  
setlocal enabledelayedexpansion   
set $=&set "#=%~1"  
if defined # (  
    for %%a in (%down%) do set #=!#:%%a=%%a!  
)  
endlocal&set "%~2=%#%"&exit/b  
