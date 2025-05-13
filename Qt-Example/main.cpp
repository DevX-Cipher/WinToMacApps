// Qt-Example/main.cpp
#include <QCoreApplication>
#include <QDebug>

int main(int argc, char *argv[]) {
    QCoreApplication a(argc, argv);

    qDebug() << "Hello, World from Qt Console!";

    return a.exec(); // Even a console app needs the event loop to function correctly in Qt
}