:: 从keystore 获取MD5和sha1
@echo off
setlocal EnableDelayedExpansion 

set currentPath=%cd%
set md5File=%currentPath%\md5AndSha1.txt
set javaPath=%JAVA_HOME%\bin

::for /f "tokens=1,2 delims==" %%i in (%currentPath%\GetMd5Config.properties) do (
::if "%%i"=="keyPath" set keyPath="%%j"
::)


:: 获取字符串长度，将strlen函数内敛到变量_strlen中,测试字符串长度小于4096；入口参数#1，返回变量##
set "_strlen=set $=^!#1^!#&set ##=&(for %%a in (2048 1024 512 256 128 64 32 16)do if ^!$:~%%a^!. NEQ . set/a##+=%%a&set $=^!$:~%%a^!)&set $=^!$^!fedcba9876543210&set/a##+=0x^!$:~16,1^!"


if exist %md5File% del %md5File%

set dropFile=%1
if defined dropFile (set keyPath="%dropFile%") else goto endof

::输入密码
set /p storePassword=please input password
::keytool -list -keystore %keyPath% -alias %alias% -v -storepass %storePassword%>%md5File%
call "%javaPath%\keytool" -list -v -keystore %keyPath% -storepass %storePassword%>%md5File%
set md5=
set sha1=
set sha256=
set line=0
set alias=

for /f "delims=" %%i in (%md5File%) do (
    set /a line+=1
    echo %%i
    ::if %%i|findstr "md5" (echo hasmd5) else (echo has not md5)
    if !line!==4 (set alias=%%i)
    if !line!==14 (set md5=%%i)
    if !line!==15 (set sha1=%%i)
    if !line!==16 (set sha256=%%i)   
)


echo "☆%md5%☆"
echo "☆%sha1%☆"
echo "☆%sha256%☆"
::删除MD5 左空格
:intercept_md5_left
if "%md5:~0,1%"==" " set "md5=%md5:~1%"&goto intercept_md5_left
if "%md5:~0,1%"=="	" set "md5=%md5:~1%"&goto intercept_md5_left

::删除MD5 右空格
:intercept_md5_right
if "%md5:~-1%"==" " set "md5=%md5:~0,-1%"&goto intercept_md5_right

::删除sha1 左空格
:intercept_sha1_left
if "%sha1:~0,1%"==" " set "sha1=%sha1:~1%"&goto intercept_sha1_left
if "%sha1:~0,1%"=="	" set "sha1=%sha1:~1%"&goto intercept_sha1_left

::删除sha1 右空格
:intercept_sha1_right
if "%sha1:~-1%"==" " set "sha1=%sha1:~0,-1%"&goto intercept_sha1_right

::删除sha256 左空格
:intercept_sha256_left
if "%sha256:~0,1%"==" " set "sha256=%sha256:~1%"&goto intercept_sha256_left
if "%sha256:~0,1%"=="	" set "sha256=%sha256:~1%"&goto intercept_sha256_left

::删除sha256 右空格
:intercept_sha256_right
if "%sha256:~-1%"==" " set "sha256=%sha256:~0,-1%"&goto intercept_sha256_right


::去掉冒号
set md5=!md5:^:=!
echo "☆%md5%☆"
set "down=a b c d e f g h i j k l m n o p q r s t u v w x y z"  
::转换成小写
call :downcase "%md5%" result
set md5=%result%   
::set md5=%result:~6%   
::set sha1=%sha1:~8,59%

::删除原来保存的文件，因为原来的内容是全部内容，而现在我们要的只是部分内容，所以先删除，再重新写入新数据
del %md5File%

::把需要的内容写入文件
echo %md5%>>%md5File%
echo %sha1% >>%md5File%
echo %sha256% >>%md5File%
echo alias%alias% >>%md5File%

::用记事本打开
call start notepad %md5File%


::转换成小写
:downcase  
setlocal enabledelayedexpansion   
set $=&set "#=%~1"  
if defined # (  
    for %%a in (%down%) do set #=!#:%%a=%%a!  
)  
endlocal&set "%~2=%#%"&exit/b  

:endof
echo please drop keystore file onto this bat 请以拖动keystore文件到bat上的形式打开，不支持双击打开
echo please put any key to exit 按任意键退出
pause>nul

