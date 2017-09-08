TEMPLATE = app

QT += qml quick \
    charts

CONFIG += c++11

SOURCES += main.cpp \
    source/micasensor.cpp \
    source/sensorlist.cpp

RESOURCES += qml.qrc \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    headers/micasensor.h \
    headers/sensorlist.h

DISTFILES +=
