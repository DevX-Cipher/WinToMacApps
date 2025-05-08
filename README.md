
#  Build macOS Apps on Windows (CLI + GUI)  
**Cross-compile real macOS executables (C, Objective-C, Cocoa GUI) using Clang, CMake, and Ninja on Windows.**

No Mac needed to build — just to run.

---

## What This Is

This project is a Windows-based toolchain setup that lets you **build native macOS applications** — including **Cocoa-based GUI apps** — using Clang and the macOS SDK.

- Cmpile Objective-C and C source files on Windows  
- Use CMake + Ninja or a standalone script  
- Build Mach-O binaries that run on real macOS  
- Includes a full example of a Cocoa GUI app

---

##  Requirements

To get started, you'll need:

- [LLVM/Clang for Windows](https://releases.llvm.org/)
- [Ninja build system](https://github.com/ninja-build/ninja/releases)
- CMake (v3.10+)
- macOS SDK (e.g. `MacOSX10.15.sdk`) extracted from a Mac

>  You must legally obtain the macOS SDK from a Mac. Redistribution is prohibited by Apple’s license.

---

##  Project Structure

```
MacCross/
├── CMakeLists.txt
├── C-Example/
│   └── hello.c
├── ObjC-Example/
│   ├── main.m
│   ├── AppDelegate.h
│   └── AppDelegate.m
├── macosx-toolchain.cmake
├── build.bat         # Manual build script
├── build/            # Created during build
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

Edit `build.bat` to match your environment:

```bat
set CLANG_PATH=C:\Program Files\LLVM\bin
set SDK_PATH=C:\MacOSX10.15.sdk
```

Then run:

```bat
build.bat
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

##  License & Legal Note

This project is provided for educational use only. Redistribution of the macOS SDK is **not permitted** by Apple’s license. You must extract it yourself from a macOS system or download it.

---

##  Feedback?

If you found this project helpful, consider sharing your thoughts by opening an issue with suggestions or improvements. Contributions are always welcome—feel free to submit a pull request!
