set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Use system environment variables for compiler paths
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

# Retrieve SDK path dynamically or set as an environment variable
set(MACOSX_SDK $ENV{MACOSX_SDK})
set(MACOSX_DEPLOYMENT_TARGET $ENV{MACOSX_DEPLOYMENT_TARGET})

# Fallback in case environment variables are not set
if(NOT MACOSX_SDK)
    message(FATAL_ERROR "MACOSX_SDK environment variable is not set!")
endif()

if(NOT MACOSX_DEPLOYMENT_TARGET)
    set(MACOSX_DEPLOYMENT_TARGET "10.13")  # Default value
endif()

# Compiler flags
set(CMAKE_C_FLAGS "--target=x86_64-apple-darwin -mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET} --sysroot=${MACOSX_SDK}" CACHE STRING "C flags")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "C++ flags")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "-target x86_64-apple-darwin --sysroot=${MACOSX_SDK} -mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET} -L${MACOSX_SDK}/usr/lib -fuse-ld=lld" CACHE STRING "Linker flags")

message(STATUS "Toolchain: C compiler = ${CMAKE_C_COMPILER}")
message(STATUS "Toolchain: C++ compiler = ${CMAKE_CXX_COMPILER}")
message(STATUS "Toolchain: SDK = ${MACOSX_SDK}")
message(STATUS "Toolchain: Deployment Target = ${MACOSX_DEPLOYMENT_TARGET}")
