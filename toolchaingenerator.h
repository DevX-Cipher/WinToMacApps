#ifndef TOOLCHAINGENERATOR_H
#define TOOLCHAINGENERATOR_H

#include <QString>

class ToolchainGenerator
{
public:
    ToolchainGenerator() = default;

    // Generates the toolchain.cmake content and writes it to the given file path
    bool writeToolchainFile(const QString &filePath,
                            const QString &sdkPath,
                            const QString &clangPath,
                            const QString &arch,
                            const QString &deployTarget);
};

#endif // TOOLCHAINGENERATOR_H
