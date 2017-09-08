/* micasensor.h
 *
 * A header definition for micaz sensors
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

#ifndef MICASENSOR_H
#define MICASENSOR_H

#include <QObject>
#include <QString>
#include <QQmlEngine>

class MicaSensor : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _id READ _id)
    Q_PROPERTY(QString country READ country)
    Q_PROPERTY(QString state READ state)
    Q_PROPERTY(QString city READ city)
    Q_PROPERTY(QString date READ date)
    Q_PROPERTY(QString latitude READ latitude)
    Q_PROPERTY(QString longitude READ longitude)
    Q_PROPERTY(QString envID READ envID)
    Q_PROPERTY(int nodeID READ nodeID)
    Q_PROPERTY(float sensirionTemp READ sensirionTemp)
    Q_PROPERTY(float sensirionHum READ sensirionHum)
    Q_PROPERTY(int intersemaTemp READ intersemaPress)
    Q_PROPERTY(int intersemaPress READ intersemaPress)
    Q_PROPERTY(int infraredLight READ infraredLight)
    Q_PROPERTY(int light READ light)
    Q_PROPERTY(int accelX READ accelX)
    Q_PROPERTY(int accelY READ accelY)
    Q_PROPERTY(int voltage READ voltage)    

public:
    explicit MicaSensor(QObject *parent = 0);

    QString _id() const;
    void set_id(const QString &_id);

    QString country() const;
    void setCountry(const QString &country);

    QString state() const;
    void setState(const QString &state);

    QString city() const;
    void setCity(const QString &city);

    QString date() const;
    void setDate(const QString &date);

    QString latitude() const;
    void setLatitude(const QString &latitude);

    QString longitude() const;
    void setLongitude(const QString &longitude);

    QString envID() const;
    void setEnvID(const QString &envID);

    int nodeID() const;
    void setNodeID(int nodeID);

    int light() const;
    void setLight(int light);

    int accelX() const;
    void setAccelX(int accelX);

    int accelY() const;
    void setAccelY(int accelY);

    int voltage() const;
    void setVoltage(int voltage);

    float sensirionTemp() const;
    void setSensirionTemp(float sensirionTemp);

    float sensirionHum() const;
    void setSensirionHum(float sensirionHum);

    float intersemaTemp() const;
    void setIntersemaTemp(float intersemaTemp);

    float intersemaPress() const;
    void setIntersemaPress(float intersemaPress);

    int infraredLight() const;
    void setInfraredLight(int infraredLight);

signals:

public slots:

private:
    QString m__id;
    QString m_country;
    QString m_state;
    QString m_city;
    QString m_date;
    QString m_latitude;
    QString m_longitude;
    QString m_envID;
    int m_nodeID;
    float m_sensirionTemp;
    float m_sensirionHum;
    float m_intersemaTemp;
    float m_intersemaPress;
    int m_infraredLight;
    int m_light;
    int m_accelX;
    int m_accelY;
    int m_voltage;
};

#endif // MICASENSOR_H
