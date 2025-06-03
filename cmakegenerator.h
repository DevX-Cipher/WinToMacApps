#ifndef CMAKEGENERATOR_H
#define CMAKEGENERATOR_H

#include <QString>

class CMakeGenerator {
public:
    bool writeCMakeLists(const QString &projectName, const QString &sourceDir);
};

#endif // CMAKEGENERATOR_H
