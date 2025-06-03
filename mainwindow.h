#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "ui_mainwindow.h" 

class MainWindow : public QMainWindow {
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);

private slots:
    void generateToolchain();
   // void generateCMakeLists();


private:
    Ui::MainWindow ui;
};

#endif // MAINWINDOW_H
