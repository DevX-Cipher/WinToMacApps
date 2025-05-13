set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_OBJC_COMPILER clang)

# Clear conflicting environment flags
set(ENV{CFLAGS} "")
set(ENV{CXXFLAGS} "")

# Retrieve SDK path dynamically or set as an environment variable
set(MACOSX_SDK "$ENV{MACOSX_SDK}")
set(MACOSX_DEPLOYMENT_TARGET "11.0" CACHE STRING "macOS deployment target") # Match batch script

# Fallback in case SDK environment variable is not set
if(NOT MACOSX_SDK)
    message(FATAL_ERROR "MACOSX_SDK environment variable is not set!")
endif()

# Define target information
set(CMAKE_OSX_ARCHITECTURES "x86_64" CACHE STRING "macOS architectures")
set(CMAKE_OSX_SYSROOT "${MACOSX_SDK}" CACHE STRING "macOS sysroot")
set(CMAKE_OSX_DEPLOYMENT_TARGET "${MACOSX_DEPLOYMENT_TARGET}" CACHE STRING "macOS deployment target")

# Construct the target triple directly
set(target_triple "${CMAKE_OSX_ARCHITECTURES}-apple-darwin${CMAKE_OSX_DEPLOYMENT_TARGET}")

# Set the flags for C and C++
set(CMAKE_C_FLAGS "-target ${target_triple} --sysroot=${CMAKE_OSX_SYSROOT}" CACHE STRING "C flags")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "C++ flags")
set(CMAKE_OBJC_FLAGS "-target ${target_triple} --sysroot=${CMAKE_OSX_SYSROOT}" CACHE STRING "Objective-C flags")

# Set linker flags for macOS, mimicking batch script
set(CMAKE_EXE_LINKER_FLAGS "-target ${target_triple} --sysroot=${CMAKE_OSX_SYSROOT} -L${CMAKE_OSX_SYSROOT}/usr/lib -fuse-ld=lld -framework Foundation -framework Cocoa -Wl,-headerpad_max_install_names" CACHE STRING "Linker flags")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}" CACHE STRING "Shared library linker flags")
set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}" CACHE STRING "Module linker flags")

message(STATUS "Toolchain: C compiler = ${CMAKE_C_COMPILER}")
message(STATUS "Toolchain: C++ compiler = ${CMAKE_CXX_COMPILER}")
message(STATUS "Toolchain: SDK = ${CMAKE_OSX_SDK}")
message(STATUS "Toolchain: Deployment Target = ${CMAKE_OSX_DEPLOYMENT_TARGET}")
message(STATUS "Toolchain: OSX Architectures = ${CMAKE_OSX_ARCHITECTURES}")
message(STATUS "Toolchain: OSX Sysroot = ${CMAKE_OSX_SYSROOT}")
message(STATUS "Toolchain: Target Triple = ${target_triple}")
