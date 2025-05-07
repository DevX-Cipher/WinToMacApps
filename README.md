# Cross Compile macOS Executables on Windows with CMake + Clang

This project demonstrates how to cross-compile a simple macOS executable on Windows using Clang, CMake, and Ninja.

## Requirements

- [LLVM/Clang for Windows](https://releases.llvm.org/)
- [Ninja build system](https://github.com/ninja-build/ninja/releases)
- CMake (version 3.10+)
- A macOS SDK (e.g. `MacOSX10.15.sdk`) placed locally on disk

>**Note:** You must obtain the macOS SDK legally from a Mac. Redistribution is prohibited by Apple’s license.

---

## Project Structure

```
MacCross/
├── CMakeLists.txt
├── C-Example/
├── ObjC-Example/
├── macosx-toolchain.cmake
├── build/        # Generated after configuring
```

---

## File Descriptions

- `C-Example/hello.c` — A simple "Hello, world" C program.
- `ObjC-Example/main.m` — Entry point for the Objective-C example.
- `ObjC-Example/MyClass.m` — An Objective-C class implementation.
- `ObjC-Example/AppDelegate.h` — A header file used in the Objective-C example.
- `CMakeLists.txt` — Standard CMake build file.
- `macosx-toolchain.cmake` — Custom CMake toolchain file for macOS cross-compilation.
- `build/` — Directory where build files and output will be generated.


---

---

## Alternative: Manual Build Without CMake

If you prefer not to use CMake, a `build.bat` script is provided to compile both examples directly using `clang`.

### Usage

1. Open `build.bat` and update the following variables to match your setup:
   - `CLANG_PATH` — Path to your LLVM `bin` directory (e.g. `C:\\Program Files\\LLVM\\bin`)
   - `SDK_PATH` — Path to your macOS SDK (e.g. `C:\\MacOSX10.15.sdk`)

2. Run the script from the root project directory:


## Build Steps

Open a terminal and run:

```bash
mkdir build
cd build
cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=../macosx-toolchain.cmake ..
cmake --build .
```

If everything is set up correctly, you’ll get Mach-O executables that can run on macOS.

---

## Verifying the Output

Transfer the generated binaries to a Mac and run:

```bash
./hello
```

Expected output:

```
Hello, world!
```

---

## License

This project is provided for educational purposes only. macOS SDK usage and cross-compilation involving Apple platforms may be subject to Apple's software license agreements.
