:: ��keystore ��ȡMD5��sha1
@echo off
setlocal EnableDelayedExpansion 

set currentPath=%cd%
set md5File=%currentPath%\md5AndSha1.txt
set javaPath=%JAVA_HOME%\bin

::for /f "tokens=1,2 delims==" %%i in (%currentPath%\GetMd5Config.properties) do (
::if "%%i"=="keyPath" set keyPath="%%j"
::)


:: ��ȡ�ַ������ȣ���strlen��������������_strlen��,�����ַ�������С��4096����ڲ���#1�����ر���##
set "_strlen=set $=^!#1^!#&set ##=&(for %%a in (2048 1024 512 256 128 64 32 16)do if ^!$:~%%a^!. NEQ . set/a##+=%%a&set $=^!$:~%%a^!)&set $=^!$^!fedcba9876543210&set/a##+=0x^!$:~16,1^!"


if exist %md5File% del %md5File%

set dropFile=%1
if defined dropFile (set keyPath="%dropFile%") else goto endof

::��������
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


echo "��%md5%��"
echo "��%sha1%��"
echo "��%sha256%��"
::ɾ��MD5 ��ո�
:intercept_md5_left
if "%md5:~0,1%"==" " set "md5=%md5:~1%"&goto intercept_md5_left
if "%md5:~0,1%"=="	" set "md5=%md5:~1%"&goto intercept_md5_left

::ɾ��MD5 �ҿո�
:intercept_md5_right
if "%md5:~-1%"==" " set "md5=%md5:~0,-1%"&goto intercept_md5_right

::ɾ��sha1 ��ո�
:intercept_sha1_left
if "%sha1:~0,1%"==" " set "sha1=%sha1:~1%"&goto intercept_sha1_left
if "%sha1:~0,1%"=="	" set "sha1=%sha1:~1%"&goto intercept_sha1_left

::ɾ��sha1 �ҿո�
:intercept_sha1_right
if "%sha1:~-1%"==" " set "sha1=%sha1:~0,-1%"&goto intercept_sha1_right

::ɾ��sha256 ��ո�
:intercept_sha256_left
if "%sha256:~0,1%"==" " set "sha256=%sha256:~1%"&goto intercept_sha256_left
if "%sha256:~0,1%"=="	" set "sha256=%sha256:~1%"&goto intercept_sha256_left

::ɾ��sha256 �ҿո�
:intercept_sha256_right
if "%sha256:~-1%"==" " set "sha256=%sha256:~0,-1%"&goto intercept_sha256_right


::ȥ��ð��
set md5=!md5:^:=!
echo "��%md5%��"
set "down=a b c d e f g h i j k l m n o p q r s t u v w x y z"  
::ת����Сд
call :downcase "%md5%" result
set md5=%result%   
::set md5=%result:~6%   
::set sha1=%sha1:~8,59%

::ɾ��ԭ��������ļ�����Ϊԭ����������ȫ�����ݣ�����������Ҫ��ֻ�ǲ������ݣ�������ɾ����������д��������
del %md5File%

::����Ҫ������д���ļ�
echo %md5%>>%md5File%
echo %sha1% >>%md5File%
echo %sha256% >>%md5File%
echo alias%alias% >>%md5File%

::�ü��±���
call start notepad %md5File%


::ת����Сд
:downcase  
setlocal enabledelayedexpansion   
set $=&set "#=%~1"  
if defined # (  
    for %%a in (%down%) do set #=!#:%%a=%%a!  
)  
endlocal&set "%~2=%#%"&exit/b  

:endof
echo please drop keystore file onto this bat �����϶�keystore�ļ���bat�ϵ���ʽ�򿪣���֧��˫����
echo please put any key to exit ��������˳�
pause>nul

