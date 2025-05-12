# Build macOS Apps on Windows (CLI + GUI + Qt)

**Cross-compile real macOS executables (C, Objective-C, Qt, Cocoa GUI) using Clang, CMake, and Ninja on Windows.**

No Mac needed to build — just to run.

---

## What This Is

This project is a Windows-based toolchain setup that lets you **build native macOS applications** — including **Cocoa- and Qt-based GUI apps** — using Clang and the macOS SDK.

- Compile Objective-C, C, and Qt source files on Windows  
- Use CMake + Ninja or a standalone script  
- Build Mach-O binaries that run on real macOS  
- Includes a full example of a Cocoa GUI app and Qt GUI app

---

## Requirements

To get started, you'll need:

- [LLVM/Clang for Windows](https://releases.llvm.org/)
- [Ninja build system](https://github.com/ninja-build/ninja/releases)
- [CMake (v3.10+)](https://cmake.org/download/)
- [macOS SDK](https://github.com/phracker/MacOSX-SDKs/releases/tag/11.3)
- [QtMacos-SDK](https://github.com/qt-creator/qt-creator/releases/tag/v17.0.0-beta1)
- [Qt Example on GitHub](https://github.com/pyinstxtractor/Pyextract/tree/PyInstaller-Archive-Viewer)
---

## Project Structure

```
MacCross/
├── CMakeLists.txt
├── C-Example/
│   └── hello.c
├── ObjC-Example/
│   ├── main.m
│   ├── AppDelegate.h
│   └── AppDelegate.m
├── Qt-Example/
│   ├── main.cpp
│   ├── mainwindow.cpp
│   ├── mainwindow.h
│   └── mainwindow.ui
├── macosx-toolchain.cmake
├── build-Objc.bat         # Manual build script (Objective-C)
├── build-Qt.bat	  # Manual build script (Qt-aware)
├── build/            # Created during build
```

---

## Example: Environment Variables Setup (Required for Qt)

Before using the Qt manual build script, set the following environment variables example:

```cmd
set QT_DIR=F:\Qt\6.7.3\macos
set QT_FRAMEWORKS=%QT_DIR%\lib
set MACOSX_SDK_PATH=F:\MacOs-Stuff\MacOSX14.5.sdk
set MACOSX_DEPLOYMENT_TARGET=11.0
```
---

##  How to Use

### Option 1: Build with CMake + Ninja (Recommended)

```bash
mkdir build
cd build
cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=../macosx-toolchain.cmake ..
cmake --build .
```

### Option 2: Manual Build Script (No CMake Required)

Edit `build-Objc.bat` or `build-Qt.bat` to match your environment, or ensure the necessary environment variables are set.

Then run the appropriate script:

```cmd
build-Objc.bat   :: for Cocoa apps
build-Qt.bat     :: for Qt apps
```

---

## Verifying the Output

Transfer the output files to a Mac and run:

```sh
./hello       # From C-Example
./ObjCExample # From Cocoa app
```

Expected output (CLI):

```
Hello, world!
```

---

##  Why Use This?

- Build macOS-native apps without a Mac
- Automate macOS builds from a Windows development environment
- Learn how cross-compilation and Apple’s toolchains work under the hood

---

##  Examples Included

- C "Hello, World"
- Cocoa GUI App with Objective-C and AppDelegate

Want Swift? Coming soon 

---

# License & Legal Note

This project is licensed under the **MIT License** (with a non-commercial use clause).  
See the [LICENSE](./LICENSE) file for more details.

---

##  Feedback?

If you found this project helpful, please feel free to share your thoughts by opening an issue with suggestions or improvements. Contributions are always welcome—feel free to submit a pull request!
