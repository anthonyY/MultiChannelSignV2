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

)


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


::获取libPath盘符
::%libPath:~0,2% 
::cd  %libPath%

::检查V2签名是否正确
call java -jar %checkV2JarFilePath% %dropFile%


::写入渠道

:: 创建输出文件夹
if not exist %outputFilePath% md %outputFilePath%

call java -jar %walleJarFilePath% batch -f %channelFilePath% %dropFile% %outputFilePath%


if "%errorlevel%"=="0" (echo success,please press any key to exit) else (echo error) 
::rem 程序错会返回1，成功为0

::pause>nul

