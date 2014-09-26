@echo off

if /i "%1" == "debug" goto :ok
if /i "%1" == "release" goto :ok

echo Builds a few test tools using latest compiler and runtime
echo Usage:
echo    BuildTestTools.cmd debug
echo    BuildTestTools.cmd release
exit /b 1

:ok

msbuild "%~dp0\fsharpqa\testenv\src\ILComparer\ILComparer.fsproj" /p:Configuration=%1 /t:Build
xcopy /Y "%~dp0\fsharpqa\testenv\src\ILComparer\bin\%1\*" "%~dp0\fsharpqa\testenv\bin"

msbuild "%~dp0\fsharpqa\testenv\src\HostedCompilerServer\HostedCompilerServer.fsproj" /p:Configuration=%1 /t:Build
xcopy /Y "%~dp0\fsharpqa\testenv\src\HostedCompilerServer\bin\%1\*" "%~dp0\fsharpqa\testenv\bin"

if exist "%~dp0\..\%1\net40\bin" (
    xcopy /Y "%~dp0\..\%1\net40\bin\FSharp.Core.sigdata" fsharpqa\testenv\bin
    xcopy /Y "%~dp0\..\%1\net40\bin\FSharp.Core.optdata" fsharpqa\testenv\bin
)