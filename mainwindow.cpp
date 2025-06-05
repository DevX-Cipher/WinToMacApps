#include "mainwindow.h"
#include "ToolchainGenerator.h"
#include <QMessageBox>
#include <QFileDialog>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    ui.setupUi(this);

    // Connect the generate toolchain button
    connect(ui.generateToolchainBtn, &QPushButton::clicked, this, &MainWindow::generateToolchain);

    // Connect browse button for Source Directory
    connect(ui.browseSourceDirBtn, &QPushButton::clicked, this, [this]() {
        QString dir = QFileDialog::getExistingDirectory(this, tr("Select Source Directory"), ui.sourceDirEdit->text());
        if (!dir.isEmpty()) {
            ui.sourceDirEdit->setText(dir);
        }
    });

    // Connect browse button for MacOS SDK Path
    connect(ui.browseSdkBtn, &QPushButton::clicked, this, [this]() {
        QString dir = QFileDialog::getExistingDirectory(this, tr("Select SDK Directory"), ui.sdkPathEdit->text());
        if (!dir.isEmpty()) {
            ui.sdkPathEdit->setText(dir);
        }
    });

    // Connect browse button for Clang Path
    connect(ui.browseClangBtn, &QPushButton::clicked, this, [this]() {
        QString dir = QFileDialog::getExistingDirectory(this, tr("Select Clang Directory"), ui.clangPathEdit->text());
        if (!dir.isEmpty()) {
            ui.clangPathEdit->setText(dir);
        }
    });

    // --- NEW: Connect browse button for Qt6 Installation Path ---
    connect(ui.browseQt6Btn, &QPushButton::clicked, this, [this]() {
        QString dir = QFileDialog::getExistingDirectory(this, tr("Select Qt6 Installation Directory (macOS)"), ui.qt6PathEdit->text());
        if (!dir.isEmpty()) {
            ui.qt6PathEdit->setText(dir);
        }
    });
}

void MainWindow::generateToolchain()
{
    QString sourceDir = ui.sourceDirEdit->text().trimmed();

    if (sourceDir.isEmpty()) {
        QMessageBox::warning(this, "Error", "Please specify a Source Directory first.");
        return;
    }

    // Build full path to toolchain file inside the source dir
    QString toolchainFilePath = QDir(sourceDir).filePath("macosx-toolchain.cmake");

    ToolchainGenerator gen;
    bool success = gen.writeToolchainFile(
        toolchainFilePath,
        ui.sdkPathEdit->text(),       // sdkPath
        ui.clangPathEdit->text(),     // clangPath
        ui.archCombo->currentText(),  // arch
        ui.deployTargetEdit->text(),  // deployTarget
        ui.qt6PathEdit->text()        // qt6Path
        );


    if (success) {
        ui.logOutput->append("Toolchain file created at: " + toolchainFilePath);
    } else {
        ui.logOutput->append("Failed to create toolchain file.");
        QMessageBox::warning(this, "Error", "Could not write toolchain.cmake file.");
    }
}


/*
void MainWindow::generateCMakeLists()
{
    CMakeGenerator gen;
    bool success = gen.writeCMakeLists(
        ui.projectNameEdit->text(),
        ui.sourceDirEdit->text()
        );

    if (success) {
        ui.logOutput->append("CMakeLists.txt created.");
    } else {
        ui.logOutput->append("Failed to create CMakeLists.txt.");
        QMessageBox::warning(this, "Error", "Could not write CMakeLists.txt file.");
    }
}
*/
