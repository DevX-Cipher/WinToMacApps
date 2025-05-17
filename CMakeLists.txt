cmake_minimum_required(VERSION 3.15)

# Set the project name and supported languages
project(MyMultiLangApp LANGUAGES C OBJC CXX)

# Specify the path to the custom macOS toolchain file (for cross-compilation or custom settings)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/macosx-toolchain.cmake)

# Set a common version string for both apps
set(APP_VERSION "1.0.0")
set(APP_SHORT_VERSION "1.0")

# ----------------------------------------------------------------------------
# Objective-C App Bundle Configuration: HelloWorldAppObjC.app
# ----------------------------------------------------------------------------

# Unique identifier for the Objective-C app bundle
set(MACOSX_BUNDLE_GUI_IDENTIFIER_OBJC "com.example.HelloWorldObjC")

add_executable(HelloWorldAppObjC MACOSX_BUNDLE
    ObjC-Example/main.m
    ObjC-Example/AppDelegate.m
)

# Set bundle properties for the Objective-C app
set_target_properties(HelloWorldAppObjC PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER ${MACOSX_BUNDLE_GUI_IDENTIFIER_OBJC}
    MACOSX_BUNDLE_BUNDLE_VERSION ${APP_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${APP_SHORT_VERSION}
    MACOSX_BUNDLE TRUE
    RESOURCE "${CMAKE_CURRENT_SOURCE_DIR}/resources/objc"  # Optional: Add resources if any
)

# Link required macOS frameworks
target_link_libraries(HelloWorldAppObjC
    PRIVATE
    "-framework Cocoa"
    "-framework Foundation"
)

# ----------------------------------------------------------------------------
# C App Bundle Configuration: HelloWorldAppC.app
# ----------------------------------------------------------------------------

# Unique identifier for the C app bundle
set(MACOSX_BUNDLE_GUI_IDENTIFIER_C "com.example.HelloWorldC")

add_executable(HelloWorldAppC MACOSX_BUNDLE
    C-Example/main.c
)

# Set bundle properties for the C app
set_target_properties(HelloWorldAppC PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER ${MACOSX_BUNDLE_GUI_IDENTIFIER_C}
    MACOSX_BUNDLE_BUNDLE_VERSION ${APP_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${APP_SHORT_VERSION}
    MACOSX_BUNDLE TRUE
    RESOURCE "${CMAKE_CURRENT_SOURCE_DIR}/resources/c"  # Optional: Add resources if any
)

# ----------------------------------------------------------------------------
# Qt-based Console Application Bundle: QtHelloWorldApp.app
# ----------------------------------------------------------------------------

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC OFF)
set(CMAKE_AUTORCC OFF)
set(CMAKE_AUTOUIC OFF)

set(Qt6_BUILD_SHARED_LIBS OFF)
find_package(Qt6 REQUIRED COMPONENTS Core CONFIG)

set(QT_SOURCES Qt-Example/main.cpp)
add_executable(QtHelloWorldApp MACOSX_BUNDLE ${QT_SOURCES})

# Configure bundle properties for the Qt application
set_target_properties(QtHelloWorldApp PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER "com.example.QtHelloWorld"
    MACOSX_BUNDLE_BUNDLE_VERSION ${APP_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${APP_SHORT_VERSION}
    MACOSX_BUNDLE TRUE
    # Optional: Add resources specific to the Qt app if any
    # RESOURCE "${CMAKE_CURRENT_SOURCE_DIR}/resources/qt"
)

target_link_libraries(QtHelloWorldApp PRIVATE
    Qt6::Core
    "-framework Foundation"
)