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

:: 删除sdk路径右边的空格
:delSdkPathRightSpace
if "%sdkPath:~-1%"==" " set sdkPath=%abc:~0,-1%&&goto delSdkPathRightSpace

:: 删除lib路径右边的空格
:delLibPathRightSpace
if "%libPath:~-1%"==" " set libPath=%abc:~0,-1%&&goto delLibPathRightSpace


set dropFile=%1
if defined dropFile (set filePath=%dropFile%) 
::echo 截取前5个字符：
::echo %ifo:~0,5%
::echo 截取最后5个字符：
::echo %ifo:~-5%
::echo 截取第一个到倒数第6个字符：
::echo %ifo:~0,-5%
::echo 从第4个字符开始，截取5个字符：
::echo %ifo:~3,5%
::echo 从倒数第14个字符开始，截取5个字符：
::echo %ifo:~-14,5%
set outputPath=%currentPath%\output\
if not exist %outputPath% md %outputPath%
for %%a in (%filePath%) do set fineName=%%~nxa
set zipalignFilePath=%outputPath%%fineName:~0,-4%_zipalign.apk
if "%isZipalign%"=="true" (
	set signedFilePath=%outputPath%%fineName:~0,-4%_signed.apk
) else (
	set signedFilePath=%outputPath%%fineName:~0,-4%_signed.apk
)


if "%isZipalign%"=="true" (
	
	if exist %zipalignFilePath% del %zipalignFilePath%
	call %sdkPath%\zipalign -v 4 %filePath% %zipalignFilePath%
)

::如果存在签名文件就删除
if exist %signedFilePath% del %signedFilePath%
::签名
if "%isZipalign%"=="true" (
	call %sdkPath%\apksigner sign --ks %keyPath% --ks-key-alias %alias% --ks-pass pass:%storePassword% --key-pass pass:%keyPassword% --out %signedFilePath% %zipalignFilePath% 
	::删除对齐文件，因为这个文件是用来对齐后再签名的，签名完成就没有用了
	del %zipalignFilePath%
) else (
	call %sdkPath%\apksigner sign --ks %keyPath% --ks-key-alias %alias% --ks-pass pass:%storePassword% --key-pass pass:%keyPassword% --out %signedFilePath% %filePath%
)



::获取libPath盘符
::%libPath:~0,2% 
::cd  %libPath%

::检查V2签名是否正确
call java -jar %checkV2JarFilePath% %signedFilePath%

::写入渠道
if "%isWriteChannel%"=="true" ( 
	:: 创建输出文件夹
	if not exist %outputFilePath% md %outputFilePath%

	call java -jar %walleJarFilePath% batch -f %channelFilePath% %signedFilePath% %outputFilePath%
)

if "%errorlevel%"=="0" (echo success,please press any key to exit) else (echo error) 
::rem 程序错会返回1，成功为0

::pause>nul

