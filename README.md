# Cross Compile macOS Executables on Windows with CMake + Clang

This project demonstrates how to cross-compile a simple macOS executable on Windows using Clang, CMake, and Ninja.

## Requirements

- [LLVM/Clang for Windows](https://releases.llvm.org/)
- [Ninja build system](https://github.com/ninja-build/ninja/releases)
- CMake (version 3.10+)
- A macOS SDK (e.g. `MacOSX10.15.sdk`) placed locally on disk

>**Note:** You must obtain the macOS SDK legally from a Mac. Redistribution is prohibited by Apples license.

---

##  Project Structure

```
MacCross/
├── CMakeLists.txt
├── C-Example
├── macosx-toolchain.cmake
├── build/        # Generated after configuring
```

---

##  File Descriptions

- `hello.c` — A simple "Hello, world" C program.
- `CMakeLists.txt` — Standard CMake build file.
- `macosx-toolchain.cmake` — Custom CMake toolchain file for macOS cross-compilation.
- `build/` — Directory where build files and output will be generated.

---

##  Setup Instructions

1. Download and extract [Clang for Windows](https://releases.llvm.org/).
2. Place the macOS SDK (e.g. `MacOSX10.15.sdk`) in a known directory such as `C:/MacOSX10.15.sdk`.
3. Make sure `clang.exe`, `clang++.exe`, and `ld.lld.exe` are in the same LLVM bin directory.
4. Edit `macosx-toolchain.cmake` to set paths for:
   - Clang compiler
   - macOS SDK root

---

## Build Steps

Open a terminal and run:

```bash
mkdir build
cd build
cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=../macosx-toolchain.cmake ..
cmake --build .
```

If everything is set up correctly, you’ll get a Mach-O executable (`hello`) that can run on macOS.

---

## Verifying the Output

Transfer the `hello` binary to a Mac and run:

```bash
./hello
```

Expected output:

```
Hello, world!
```

---

##  License

This project is provided for educational purposes only. macOS SDK usage and cross-compilation involving Apple platforms may be subject to Apple's software license agreements.
