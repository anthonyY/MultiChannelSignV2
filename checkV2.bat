@echo off

:: ��ȡ�����ļ�

set currentPath=%cd%
set libPath=%currentPath%\libs
set checkV2JarFilePath=%libPath%\CheckAndroidV2Signature.jar
set filePath=%1

echo checkV2Path:%checkV2JarFilePath%
echo filePath:%filePath%

::��ȡlibPath�̷�
%libPath:~0,2% 
cd  %libPath%

::���V2ǩ���Ƿ���ȷ

call java -jar %checkV2JarFilePath% %filePath%


if "%errorlevel%"=="0" (echo success,please press any key to exit) else (echo error) 
::rem �����᷵��1���ɹ�Ϊ0

pause>nul