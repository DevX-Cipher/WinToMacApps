# macosx-toolchain.cmake
# Toolchain file for cross-compiling from Windows to macOS using Clang

# Set target system to macOS
set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Find compilers
find_program(CMAKE_C_COMPILER clang)
find_program(CMAKE_CXX_COMPILER clang++)
find_program(CMAKE_OBJC_COMPILER clang)
if(NOT CMAKE_C_COMPILER OR NOT CMAKE_CXX_COMPILER OR NOT CMAKE_OBJC_COMPILER)
    message(FATAL_ERROR "Clang compilers not found. Ensure clang is installed and in PATH.")
endif()

# Clear conflicting environment flags
set(ENV{CFLAGS} "")
set(ENV{CXXFLAGS} "")

# validate MACOSX_SDK environment variable
if(NOT DEFINED ENV{MACOSX_SDK})
    message(FATAL_ERROR "MACOSX_SDK environment variable is not set! Set it to the macOS SDK path (e.g., set MACOSX_SDK=C:\\path\\to\\macos-sdk in Windows CMD).")
endif()
if(NOT EXISTS "$ENV{MACOSX_SDK}")
    message(FATAL_ERROR "MACOSX_SDK path '$ENV{MACOSX_SDK}' does not exist!")
endif()

# Set macOS settings
set(CMAKE_OSX_SYSROOT "$ENV{MACOSX_SDK}")
set(CMAKE_OSX_DEPLOYMENT_TARGET "11.0")
set(CMAKE_OSX_ARCHITECTURES "x86_64")


# Construct the target triple directly
set(target_triple "${CMAKE_OSX_ARCHITECTURES}-apple-darwin${CMAKE_OSX_DEPLOYMENT_TARGET}")

# Set the flags for C and C++
set(CMAKE_C_FLAGS "-target ${target_triple} --sysroot=${CMAKE_OSX_SYSROOT}" CACHE STRING "C flags")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "C++ flags")
set(CMAKE_OBJC_FLAGS "-target ${target_triple} --sysroot=${CMAKE_OSX_SYSROOT}" CACHE STRING "Objective-C flags")

# Set linker flags for macOS
set(CMAKE_EXE_LINKER_FLAGS "-target ${target_triple} --sysroot=${CMAKE_OSX_SYSROOT} -L${CMAKE_OSX_SYSROOT}/usr/lib -fuse-ld=lld -framework Foundation -framework Cocoa -Wl,-headerpad_max_install_names" CACHE STRING "Linker flags")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}" CACHE STRING "Shared library linker flags")
set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}" CACHE STRING "Module linker flags")

# Status messages for debugging
message(STATUS "Toolchain: C compiler = ${CMAKE_C_COMPILER}")
message(STATUS "Toolchain: C++ compiler = ${CMAKE_CXX_COMPILER}")
message(STATUS "Toolchain: Objective-C compiler = ${CMAKE_OBJC_COMPILER}")
message(STATUS "Toolchain: SDK = ${CMAKE_OSX_SYSROOT}")
message(STATUS "Toolchain: Deployment Target = ${CMAKE_OSX_DEPLOYMENT_TARGET}")
message(STATUS "Toolchain: Architectures = ${CMAKE_OSX_ARCHITECTURES}")