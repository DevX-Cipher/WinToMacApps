cmake_minimum_required(VERSION 3.15)
project(MyMultiLangApp)

# Link the toolchain file
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/macosx-toolchain.cmake)

# --- Build the Objective-C App ---
add_executable(hello_objc_app
    ObjC-Example/main.m
    ObjC-Example/AppDelegate.m
)

# --- Build the C App ---
add_executable(hello_c_app
    C-Example/main.c 
)