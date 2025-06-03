#include "CMakeGenerator.h"
#include <QFile>
#include <QTextStream>
#include <QDir>

bool CMakeGenerator::writeCMakeLists(const QString &projectName, const QString &sourceDir)
{
    QFile file("CMakeLists.txt");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return false;

    QTextStream out(&file);
    out << "cmake_minimum_required(VERSION 3.16)\n";
    out << "project(" << projectName << ")\n\n";
    out << "set(CMAKE_CXX_STANDARD 17)\n";
    out << "set(CMAKE_TOOLCHAIN_FILE \"${CMAKE_SOURCE_DIR}/toolchain.cmake\")\n\n";
    out << "file(GLOB SOURCES \"" << QDir(sourceDir).absolutePath() << "/*.cpp\")\n";
    out << "add_executable(" << projectName << " ${SOURCES})\n";

    return true;
}
