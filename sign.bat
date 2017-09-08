@echo off

:: ��ȡ�����ļ�

set currentPath=%cd%
set libPath=%currentPath%\libs
set checkV2JarFilePath=%libPath%\CheckAndroidV2Signature.jar
set walleJarFilePath=%libPath%\walle-cli-all.jar
set outputFilePath=%currentPath%\channels
set channelFilePath=%currentPath%\channel


for /f "tokens=1,2 delims==" %%i in (signConfig.properties) do (
if "%%i"=="sdkPath" set sdkPath=%%j
if "%%i"=="keyPath" set keyPath=%%j
if "%%i"=="alias" set alias=%%j
if "%%i"=="keyPassword" set keyPassword=%%j
if "%%i"=="storePassword" set storePassword=%%j
if "%%i"=="filePath" set filePath=%%j
if "%%i"=="isWriteChannel" set isWriteChannel=%%j
if "%%i"=="isZipalign" set isZipalign=%%j
)
::echo ��ȡǰ5���ַ���
::echo %ifo:~0,5%
::echo ��ȡ���5���ַ���
::echo %ifo:~-5%
::echo ��ȡ��һ����������6���ַ���
::echo %ifo:~0,-5%
::echo �ӵ�4���ַ���ʼ����ȡ5���ַ���
::echo %ifo:~3,5%
::echo �ӵ�����14���ַ���ʼ����ȡ5���ַ���
::echo %ifo:~-14,5%

set zipalignFilePath=%filePath:~0,-4%_zipalign.apk
if "%isZipalign%"=="true" (
	set signedFilePath=%filePath:~0,-4%_zipalign_signed.apk
) else (
	set signedFilePath=%filePath:~0,-4%_signed.apk
)

echo libPath:%libPath%
echo checkV2Path:%checkV2JarFilePath%
echo wallePath:%walleJarFilePath%
echo sdkPath:%sdkPath%
echo keyPath:%keyPath%
echo alias:%alias%
echo keyPassword:%keyPassword%
echo storePassword:%storePassword%
echo filePath:%filePath%
echo signedFilePath:%signedFilePath%
echo zipalignFilePath:%zipalignFilePath%
echo outputFilePath:%outputFilePath%
echo channelFilePath:%channelFilePath%
echo isWriteChannel:%isWriteChannel%
echo isZipalign:%isZipalign% 

::��ȡ�̷�
%sdkPath:~0,2% 
cd  %sdkPath%
::����
if "%isZipalign%"=="true" (
	::������ڶ����ļ���ɾ��
	if exist %zipalignFilePath% del %zipalignFilePath%
	call zipalign -v 4 %filePath% %zipalignFilePath%
)

::�������ǩ���ļ���ɾ��
if exist %signedFilePath% del %signedFilePath%
::ǩ��
if "%isZipalign%"=="true" (
	call apksigner sign --ks %keyPath% --ks-key-alias %alias% --ks-pass pass:%storePassword% --key-pass pass:%keyPassword% --out %signedFilePath% %zipalignFilePath%  
	::ɾ�������ļ�����Ϊ����ļ��������������ǩ���ģ�ǩ����ɾ�������
	del %zipalignFilePath%
) else (
	call apksigner sign --ks %keyPath% --ks-key-alias %alias% --ks-pass pass:%storePassword% --key-pass pass:%keyPassword% --out %signedFilePath% %filePath%
)


::��ȡlibPath�̷�
%libPath:~0,2% 
cd  %libPath%

::���V2ǩ���Ƿ���ȷ

call java -jar %checkV2JarFilePath% %signedFilePath%

:: ��������ļ���
if not exist %outputFilePath% md %outputFilePath%


::д������
if "%isWriteChannel%"=="true" ( 
	call java -jar %walleJarFilePath% batch -f %channelFilePath% %signedFilePath% %outputFilePath%
)

if "%errorlevel%"=="0" (echo success,please press any key to exit�밴������˳�) else (echo error) 
::rem �����᷵��1���ɹ�Ϊ0

pause>nul