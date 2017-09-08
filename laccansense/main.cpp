#include "headers/sensorlist.h"
#include "headers/micasensor.h"

#include <QQmlApplicationEngine>
#include <QtWidgets/QApplication>

int main(int argc, char *argv[]) {
//    QGuiApplication app(argc, argv);
    QApplication app(argc, argv);

    // register the type DataEntryModel
    // under the url "org.example" in version 1.0
    // under the name "DataEntryModel"
    qmlRegisterType<SensorList>("laccan.sense", 1, 0, "SensorList");
    qmlRegisterType<MicaSensor>("laccan.sense", 1, 0, "MicaSensor");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
