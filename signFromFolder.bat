@echo off

:: 读取配置文件

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
set dropFile=%1
if defined dropFile (set filePath=%dropFile%) 
for %%a in (%filePath%) do set "b=%%~aa"
	if defined b (
		if %b:~0,1%==d (set isDir=true) else ( set isDir=false)
	)
)
echo %isDir% %filePath%

if defined isDir (echo defined isDir true  ) else ( echo  defined isDir false)
echo "%isDir%"

if "%isDir%"=="true" (
	%filePath:~0,2% 
	cd  %filePath%
	for /R %%s in (*.apk) do ( 
		echo %%s 
		::又要回到sign.bat的目录去执行sagn.bat
		%currentPath:~0,2% 
		cd  %currentPath%
		call sign.bat %%s

	) 
) else (
	call sign.bat %filePath%
)

if "%errorlevel%"=="0" (echo success,please press any key to exit) else (echo error) 
::rem 程序错会返回1，成功为0

pause>nul