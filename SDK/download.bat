@echo off
setlocal

:: Get the directory where the script is located
set "SCRIPT_DIR=%~dp0"

:: Define the base GitHub release URL with specific tags
set "BASE_URL=https://github.com/joseluisq/macosx-sdks/releases/download"

:: Prompt user for SDK version
echo Available macOS SDK versions:
echo 1. MacOSX13.0 (macOS Ventura)
echo 2. MacOSX14.5 (macOS Sonoma)
echo 3. MacOSX10.15 (macOS Catalina)
set /p "SDK_CHOICE=Enter the number corresponding to the SDK version you want: "

:: Determine the selected SDK with correct tag references
if "%SDK_CHOICE%"=="1" set "SDK_VERSION=13.0" & set "SDK_FILE=MacOSX13.0.sdk.tar.xz"
if "%SDK_CHOICE%"=="2" set "SDK_VERSION=14.5" & set "SDK_FILE=MacOSX14.5.sdk.tar.xz"
if "%SDK_CHOICE%"=="3" set "SDK_VERSION=10.15" & set "SDK_FILE=MacOSX10.15.sdk.tar.xz"

:: Validate selection
if not defined SDK_FILE (
    echo Invalid selection. Exiting.
    exit /b 1
)

:: Set destination directory to the script's location
set "DEST_DIR=%SCRIPT_DIR%"

:: Download the selected SDK using its specific tag
echo Downloading %SDK_FILE%...
curl -L "%BASE_URL%/%SDK_VERSION%/%SDK_FILE%" -o "%DEST_DIR%%SDK_FILE%"

:: Verify download success
if not exist "%DEST_DIR%%SDK_FILE%" (
    echo Failed to download SDK. Please check the URL.
    exit /b 1
)

:: Extract the SDK in the same directory as the script
echo Extracting %SDK_FILE%...
cd /d "%DEST_DIR%" && tar -xJf "%SDK_FILE%"

:: Delete the original downloaded file after extraction
echo Cleaning up...
del "%DEST_DIR%%SDK_FILE%"

echo Done!.

endlocal
