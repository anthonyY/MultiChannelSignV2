@echo off

:: ��ȡ�����ļ�

set currentPath=%cd%
set libPath=%currentPath%\libs
set checkV2JarFilePath=%libPath%\CheckAndroidV2Signature.jar


for /f "tokens=1,2 delims==" %%i in (checkV2Config.properties) do (
	if "%%i"=="filePath" set filePath=%%j
)

echo checkV2Path:%checkV2JarFilePath%
echo signedFilePath:%signedFilePath%


::��ȡlibPath�̷�
%libPath:~0,2% 
cd  %libPath%

::���V2ǩ���Ƿ���ȷ

call java -jar %checkV2JarFilePath% %filePath%


if "%errorlevel%"=="0" (echo success,please press any key to exit) else (echo error) 
::rem �����᷵��1���ɹ�Ϊ0

pause>nul