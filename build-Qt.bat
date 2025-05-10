@echo off

:: Check if QT_ENV_VARIABLE is set
if not defined QT_ENV_VARIABLE (
    echo ERROR: QT_ENV_VARIABLE is not set. Please set it before running this script.
    echo Example: setx QT_ENV_VARIABLE F:\Qt\6.7.3\macos
    exit /b 1
)

:: Assign and verify Qt directory
set QT_DIR=%QT_ENV_VARIABLE%
if not exist "%QT_DIR%" (
    echo ERROR: Qt directory %QT_DIR% does not exist!
    exit /b 1
)
echo Using QT_DIR=%QT_DIR%

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

echo [SUCCESS] All necessary directories were successfully created!

:: Set Qt framework path
set QT_FRAMEWORKS=%QT_DIR%\lib

:: Set include paths for macOS Qt
set INCLUDE_FLAGS=-I "%QT_DIR%\lib\QtCore.framework\Versions\A\Headers" ^
                  -I "%QT_DIR%\lib\QtGui.framework\Versions\A\Headers" ^
                  -I "%QT_DIR%\lib\QtWidgets.framework\Versions\A\Headers"

:: Set macOS framework path and link flags
set LIBRARY_FLAGS=-F "%QT_FRAMEWORKS%" ^
                  -framework QtCore ^
                  -framework QtGui ^
                  -framework QtWidgets ^
                  -framework Cocoa ^
                  -lz

:: Add Qt binaries (uic, moc) to PATH
set PATH=%QT_DIR%\bin;%PATH%

:: Set macOS deployment target to match Qt version
set MACOSX_DEPLOYMENT_TARGET=11.0

:: Verify if clang is available in PATH
where clang >nul 2>nul
if errorlevel 1 (
    echo ERROR: clang not found in PATH!
    exit /b 1
)

:: Generate UI header using uic
uic mainwindow.ui -o ui_mainwindow.h
if errorlevel 1 (
    echo ERROR: Failed to generate UI header with uic!
    exit /b 1
)

:: Generate MOC files for Qt classes
moc mainwindow.h -o moc_mainwindow.cpp
if errorlevel 1 (
    echo ERROR: Failed to generate MOC file for mainwindow.h!
    exit /b 1
)

moc extractionworker.h -o moc_extractionworker.cpp
if errorlevel 1 (
    echo ERROR: Failed to generate MOC file for extractionworker.h!
    exit /b 1
)

:: Compile using Clang for macOS
clang++ -target x86_64-apple-darwin ^
        -isysroot %SYSROOT% ^
        -mmacosx-version-min=%MACOSX_DEPLOYMENT_TARGET% ^
        -fuse-ld=lld ^
        %INCLUDE_FLAGS% %LIBRARY_FLAGS% ^
        main.cpp moc_mainwindow.cpp mainwindow.cpp moc_extractionworker.cpp extractionworker.cpp pyinstarchive.cpp ^
        -o HelloWorldApp.app/Contents/MacOS/HelloWorldApp ^
        -Wl,-headerpad_max_install_names
if errorlevel 1 (
    echo ERROR: Compilation failed!
    exit /b 1
)

echo [SUCCESS] Build done!
