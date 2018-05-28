@echo off

:: 读取配置文件

set currentPath=%cd%
set libPath=%currentPath%\libs
set checkV2JarFilePath=%libPath%\CheckAndroidV2Signature.jar
set walleJarFilePath=%libPath%\walle-cli-all.jar
set outputFilePath=%currentPath%\channels
set channelFilePath=%currentPath%\channel
set filePath=currentPath\app_signed.apk

:: 删除lib路径右边的空格
:delLibPathRightSpace
if "%libPath:~-1%"==" " set libPath=%abc:~0,-1%&&goto delLibPathRightSpace


set dropFile=%1
if defined dropFile (set filePath=%dropFile%) 

set outputPath=%currentPath%\output\
if not exist %outputPath% md %outputPath%


::获取libPath盘符
::%libPath:~0,2% 
::cd  %libPath%

::检查V2签名是否正确
call java -jar %checkV2JarFilePath% %filePath%


::写入渠道

:: 创建输出文件夹
if not exist %outputFilePath% md %outputFilePath%

call java -jar %walleJarFilePath% batch -f %channelFilePath% %filePath% %outputFilePath%


if "%errorlevel%"=="0" (echo success,please press any key to exit) else (echo error) 
::rem 程序错会返回1，成功为0

::pause>nul

