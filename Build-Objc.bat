@echo off
:: Check if MACOSX_SDK_PATH is set
if not defined MACOSX_SDK_PATH (
    echo ERROR: MACOSX_SDK_PATH is not set. Please set it before running this script.
    echo Example: setx MACOSX_SDK_PATH F:\MacOs-Stuff\MacOSX14.5.sdk
    exit /b 1
)

:: Assign and verify macOS SDK path
set SYSROOT=%MACOSX_SDK_PATH%
if not exist "%SYSROOT%" (
    echo ERROR: macOS SDK path %SYSROOT% does not exist!
    exit /b 1
)
echo Using SYSROOT=%SYSROOT%

:: Create necessary folders
mkdir HelloWorldApp.app
mkdir HelloWorldApp.app\Contents
mkdir HelloWorldApp.app\Contents\MacOS

:: Verify folder creation
if not exist "HelloWorldApp.app" (
    echo ERROR: Failed to create HelloWorldApp.app directory!
    exit /b 1
)
if not exist "HelloWorldApp.app\Contents" (
    echo ERROR: Failed to create Contents directory!
    exit /b 1
)
if not exist "HelloWorldApp.app\Contents\MacOS" (
    echo ERROR: Failed to create MacOS directory!
    exit /b 1
)

set MACOSX_DEPLOYMENT_TARGET=11.0
echo [SUCCESS] All necessary directories were successfully created!

:: Compile using Clang for macOS
clang -target x86_64-apple-darwin ^
        -isysroot %SYSROOT% ^
        -mmacosx-version-min=%MACOSX_DEPLOYMENT_TARGET% ^
        -fuse-ld=lld ^
		-framework Cocoa ^
		ObjC-Example\AppDelegate.m ObjC-Example\main.m ^
		-o HelloWorldApp.app/Contents/MacOS/HelloWorldApp

if errorlevel 1 (
    echo ERROR: Compilation failed!
    exit /b 1
)

echo [SUCCESS] Build done!
