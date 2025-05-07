set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Specify Clang compilers (using your exact installation path)
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

# macOS SDK path
set(MACOSX_SDK "C:/MacOSX10.15.sdk")
set(MACOSX_DEPLOYMENT_TARGET "10.13")

# Compiler flags
set(CMAKE_C_FLAGS "--target=x86_64-apple-darwin --sysroot=${MACOSX_SDK} -mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "-L${MACOSX_SDK}/usr/lib")
