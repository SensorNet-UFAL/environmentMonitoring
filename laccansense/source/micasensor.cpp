/* micasensor.cpp
 *
 * micasensor.h's implementation
 *
 * @author: Geymerson Ramos
 * @email: geymerson@laccan.ufal.br
 * Last-Updated:
 *           By: Geymerson Ramos
 *     Update #:
 */

/* Change Log:
 *
 */

#include "headers/micasensor.h"

MicaSensor::MicaSensor(QObject *parent) : QObject(parent) {
    QQmlEngine::setObjectOwnership(this, QQmlEngine::CppOwnership);
}

QString MicaSensor::country() const {
    return m_country;
}

void MicaSensor::setCountry(const QString &country) {
    m_country = country;
}

QString MicaSensor::state() const {
    return m_state;
}

void MicaSensor::setState(const QString &state) {
    m_state = state;
}

QString MicaSensor::city() const {
    return m_city;
}

void MicaSensor::setCity(const QString &city) {
    m_city = city;
}

QString MicaSensor::date() const {
    return m_date;
}

void MicaSensor::setDate(const QString &date) {
    m_date = date;
}

QString MicaSensor::latitude() const {
    return m_latitude;
}

void MicaSensor::setLatitude(const QString &latitude) {
    m_latitude = latitude;
}

QString MicaSensor::longitude() const {
    return m_longitude;
}

void MicaSensor::setLongitude(const QString &longitude) {
    m_longitude = longitude;
}

int MicaSensor::nodeID() const {
    return m_nodeID;
}

void MicaSensor::setNodeID(int nodeID) {
    m_nodeID = nodeID;
}

int MicaSensor::light() const {
    return m_light;
}

void MicaSensor::setLight(int light) {
    m_light = light;
}

int MicaSensor::accelX() const {
    return m_accelX;
}

void MicaSensor::setAccelX(int accelX) {
    m_accelX = accelX;
}

int MicaSensor::voltage() const {
    return m_voltage;
}

void MicaSensor::setVoltage(int voltage) {
    m_voltage = voltage;
}

float MicaSensor::sensirionTemp() const {
    return m_sensirionTemp;
}

void MicaSensor::setSensirionTemp(float sensirionTemp) {
    m_sensirionTemp = sensirionTemp;
}

float MicaSensor::sensirionHum() const {
    return m_sensirionHum;
}

void MicaSensor::setSensirionHum(float sensirionHum) {
    m_sensirionHum = sensirionHum;
}

float MicaSensor::intersemaTemp() const {
    return m_intersemaTemp;
}

void MicaSensor::setIntersemaTemp(float intersemaTemp) {
    m_intersemaTemp = intersemaTemp;
}

float MicaSensor::intersemaPress() const {
    return m_intersemaPress;
}

void MicaSensor::setIntersemaPress(float intersemaPress) {
    m_intersemaPress = intersemaPress;
}

int MicaSensor::infraredLight() const {
    return m_infraredLight;
}

void MicaSensor::setInfraredLight(int infraredLight) {
    m_infraredLight = infraredLight;
}

QString MicaSensor::envID() const {
    return m_envID;
}

void MicaSensor::setEnvID(const QString &envID) {
    m_envID = envID;
}

int MicaSensor::accelY() const {
    return m_accelY;
}

void MicaSensor::setAccelY(int accelY) {
    m_accelY = accelY;
}

QString MicaSensor::_id() const {
    return m__id;
}

void MicaSensor::set_id(const QString &_id) {
    m__id = _id;
}

