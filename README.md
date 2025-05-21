# 🧰 Cross-Compile macOS Apps on Windows — C, Objective-C, Qt, Cocoa (No Mac Needed)

![Platform: Windows](https://img.shields.io/badge/platform-Windows-blue)
![Builds macOS Apps](https://img.shields.io/badge/builds-macOS-brightgreen)
![License: MIT (Non-Commercial)](https://img.shields.io/badge/license-MIT--NC-yellow)

Build native macOS applications — including Cocoa and Qt-based GUI apps — **entirely on Windows**, using Clang, CMake, and Ninja.

✅ **No Mac required to build.** Just transfer and run the output on a real Mac.

---

## ✨ Features

- Build real macOS `.app` and CLI binaries from Windows
- Full support for C, Objective-C, and Qt (QtWidgets)
- Cocoa GUI support (AppDelegate, XIB-style)
- Works with CMake + Ninja or Visual Studio
- **Automatically detects macOS SDK from `SDK/` folder**
- Includes working examples: CLI, Cocoa, and Qt GUI
- No VM or Hackintosh required

---

## 📦 Overview

This project provides a cross-compilation toolchain that allows you to build native **macOS** executables — including GUI apps — from a **Windows** system. It supports:

- Clang + macOS SDK
- Objective-C, C, and C++ (Qt)
- Cocoa GUI (with AppDelegate)
- Qt Widgets-based GUI

---

## 📁 Project Structure

```
MacCross/
├── CMakeLists.txt
├── SDK/
│   └── MacOSX14.5.sdk/             # <--- Place SDK here
├── C-Example/
│   └── hello.c
├── ObjC-Example/
│   ├── main.m
│   ├── AppDelegate.h
│   └── AppDelegate.m
├── Qt-Example/
│   ├── main.cpp
├── macosx-toolchain.cmake
├── build-Qt.bat                    # Optional manual script
├── build/
```

---

## 🔧 Requirements

- [LLVM/Clang for Windows](https://releases.llvm.org/)
- [Ninja build system](https://github.com/ninja-build/ninja/releases)
- [CMake (v3.10+)](https://cmake.org/download/)
- [macOS SDK](https://github.com/phracker/MacOSX-SDKs/releases/tag/11.3) (place in `SDK/` folder)
- [QtMacos-SDK](https://github.com/LongSoft/qt-6-static-universal-macos)
- [Qt Example on GitHub](https://github.com/pyinstxtractor/Pyextract/tree/PyInstaller-Archive-Viewer)

---

## 🛠️ How to Build

You can build using either CMake + Ninja (CLI) or Visual Studio (GUI). Both methods work with this project.

### 🔧 Option 1: CMake + Ninja (Recommended for automation or scripting)

```bash
mkdir build
cd build
cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=../macosx-toolchain.cmake ..
cmake --build .
```

### 🖥️ Option 2: Visual Studio (Recommended for GUI users)

1. Open **Visual Studio**
2. Select **"Open a local folder"**
3. Choose the project root (where `CMakeLists.txt` is located)
4. When prompted, select a **CMake configuration** (e.g., `x64-Release`)
5. Visual Studio will detect the CMake project and automatically configure it
6. Ensure `macosx-toolchain.cmake` is being used:
   - Go to **CMake Settings** or `CMakePresets.json`
   - Set the toolchain file path under `CMake toolchain file`
7. Build via **Build > Build All**

> ✅ Make sure the toolchain file is set, or builds will fail.

---

## 📌 Environment Variables (Static Qt Builds Only)

If you're using Qt (especially static builds), set the following environment variables before building:

```cmd
set QT_DIR=F:\Qt\6.7.3\macos
set QT_FRAMEWORKS=%QT_DIR%\lib
```

> ✅ MACOSX_SDK_PATH and MACOSX_DEPLOYMENT_TARGET are automatically handled by the toolchain (SDK is detected from the SDK/ folder, deployment target is set to 11.0 by default).

---

## ✅ Verifying the Output

Transfer the built binaries to a Mac and run:

```bash
./hello         # From C-Example
./ObjCExample   # From Cocoa app
./QtExample     # From Qt app
```

Expected output:

```
Hello, world!
```

> ⚠️ Note: Binaries are unsigned. You may need to bypass Gatekeeper to run them.

---

## 📚 Examples Included

- ✅ CLI C Hello World
- ✅ Cocoa GUI App (Objective-C + AppDelegate)
- ✅ Qt Widgets GUI App

> Want Swift support? Coming soon.

---

## 📜 License & Legal Note

This project is licensed under the MIT License (with a non-commercial use clause).  
See the LICENSE file for more details.

---

## 💬 Feedback

If you found this project helpful, please open an issue with suggestions or improvements.  
Contributions are welcome — feel free to submit a pull request!

---

## 🔍 Keywords

macOS cross-compile • build macOS apps on Windows • Cocoa from Windows • Qt macOS SDK Windows • Clang CMake macOS • create macOS .app without Xcode • Ninja toolchain • Objective-C on Windows
