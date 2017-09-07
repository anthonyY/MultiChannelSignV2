@echo off

:: 读取配置文件

set currentPath=%cd%
set libPath=%currentPath%\libs
set checkV2JarFilePath=%libPath%\CheckAndroidV2Signature.jar


for /f "tokens=1,2 delims==" %%i in (checkV2Config.properties) do (
	if "%%i"=="filePath" set filePath=%%j
)

echo checkV2Path:%checkV2JarFilePath%
echo signedFilePath:%signedFilePath%


::获取libPath盘符
%libPath:~0,2% 
cd  %libPath%

::检查V2签名是否正确

call java -jar %checkV2JarFilePath% %filePath%


if "%errorlevel%"=="0" (echo success,please press any key to exit) else (echo error) 
::rem 程序错会返回1，成功为0

pause>nul