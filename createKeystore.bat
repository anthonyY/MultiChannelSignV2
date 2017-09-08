
::创建keystore文件的脚本

::读取配置文件
@echo off
for /f "tokens=1,2 delims==" %%i in (ctreateConfig.properties) do (
	if "%%i"=="day" set day=%%j
	if "%%i"=="keyPath" set keyPath=%%j
	if "%%i"=="alias" set alias=%%j
	if "%%i"=="keyPassword" set keyPassword=%%j
	if "%%i"=="storePassword" set storePassword=%%j
	if "%%i"=="name" set name=%%j
	if "%%i"=="organizationalUnit" set organizationalUnit=%%j
	if "%%i"=="organization" set organization=%%j
	if "%%i"=="city" set city=%%j
	if "%%i"=="province" set province=%%j
	if "%%i"=="countryCode" set countryCode=%%j
)
set create=keytool -genkey -alias %alias% -keyalg RSA -validity %day% -keystore %keyPath%  -storepass pass:%storePassword% -keypass pass:%keyPassword% -dname "CN=%name%, OU=%organizationalUnit%, O=%organization%, L=%city%, ST=%province%, C=%countryCode%"
	
if exist %keyPath% (
	echo %keyPath% is exsit
) else (
	call %create%
	echo %create% 
)


if "%errorlevel%"=="0" (echo success,please press any key to exit) else (echo error) 
::rem 程序错会返回1，成功为0
 
pause