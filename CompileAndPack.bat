@echo off
set source_list=build_source_list.txt
set jar_list=build_jar_list.txt
set android_sdk=F:\Android\android\platforms\android-25\android.jar
set root_path="%cd%"
set lib_path=%root_path%\lib
set class_path=bin\classes
set source_path=
set jar_path=%android_sdk%;
set load_info=Loading source file information, please wait...
set compile_info=Compile the source file, please wait...
set result_info=Compile the source file successfully.

::删除文件夹再创建
rd /s /Q %class_path%
md %class_path%

::if not exist %class_path% md %class_path%
if exist %source_list% del %source_list%
echo %load_info%
::遍历整个Java源码目录，将各个Java文件信息保存到txt文件中
::cd component
setlocal EnableDelayedExpansion
for /R %%s in (*.java) do (
  echo %%s>>%root_path%\%source_list%
)

for /R %%s in (*.jar) do (
  echo %%s>>%root_path%\%jar_list%
)
::cd %root_path%

::读取txt文件内容，将所有内容传给一个变量
::setlocal EnableDelayedExpansion
for /f %%i in ('type %source_list%') do (
  set source_path=!source_path! "%%i"
)

for /f %%i in ('type %jar_list%') do (
  set jar_path=!jar_path!;"%%i"
)
::pause

::对Java文件进行编译
echo %compile_info%
::-D java.ext.dirs=%lib_path% 
javac  -classpath %jar_path% -d %class_path% %source_path% -encoding UTF-8 
echo %result_info%

for %%a in (%root_path%) do echo %%~nxa&set name=%%~nxa
if exist %source_list% del %source_list%
if exist %jar_list% del %jar_list%

call jar cvf  %name%.jar %class_path% -encoding UTF-8 

pause