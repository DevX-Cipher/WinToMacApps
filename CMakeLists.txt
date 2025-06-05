cmake_minimum_required(VERSION 3.16)

project(WinToMacConfig VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Point to your static Qt installation
set(CMAKE_PREFIX_PATH "F:/Qt/6.7.3-static") # Adjust this path

find_package(Qt6 REQUIRED COMPONENTS Widgets Core Gui)

set(PROJECT_SOURCES
    main.cpp
    mainwindow.cpp
    mainwindow.h
    mainwindow.ui
    toolchaingenerator.h toolchaingenerator.cpp
    cmakegenerator.h cmakegenerator.cpp
)

qt_add_executable(WinToMacConfig
    MANUAL_FINALIZATION
    ${PROJECT_SOURCES}
)

target_link_libraries(WinToMacConfig PRIVATE
    Qt6::Widgets
    Qt6::Core
    Qt6::Gui
)

# Include Qt plugins for static builds
qt_import_plugins(WinToMacConfig
    INCLUDE Qt6::QWindowsIntegrationPlugin
    # Add other plugins as needed, e.g., Qt6::QJpegPlugin
)

# Windows-specific libraries for static builds
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    target_link_libraries(WinToMacConfig PRIVATE
        ws2_32 user32 gdi32 imm32 ole32 opengl32 shell32 advapi32
    )
endif()

# Use static runtime for MSVC
if(MSVC)
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
endif()

set_target_properties(WinToMacConfig PROPERTIES
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS WinToMacConfig
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_finalize_executable(WinToMacConfig)
