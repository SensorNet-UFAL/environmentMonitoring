/* sensorlist.h
 *
 * An header for a list o micaz sensors
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

#ifndef SENSORLIST_H
#define SENSORLIST_H

#include <QUrl>
#include <QDebug>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QNetworkAccessManager>
#include <QNetworkConfigurationManager>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QQmlEngine>
#include <QtCore>
#include "micasensor.h"

class SensorList : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)

public:
    enum RoleNames {
        NodeIDRole = Qt::UserRole,
        SensirionTempRole = Qt::UserRole+2,
        SensirionHumRole = Qt::UserRole+3,
        IntersemaTempRole = Qt::UserRole+4,
        IntersemaPressRole = Qt::UserRole+5,
        InfraredLightRole = Qt::UserRole+6,
        LightRole = Qt::UserRole+7,
        AccelXRole = Qt::UserRole+8,
        AccelYRole = Qt::UserRole+9,
        VoltageRole = Qt::UserRole+10,
        StateRole = Qt::UserRole+11,
        CityRole = Qt::UserRole+12,
        LatitudeRole = Qt::UserRole+13,
        LongitudeRole = Qt::UserRole+14,
        DateRole = Qt::UserRole+15,
        EnvIDRole = Qt::UserRole+16
    };

    explicit SensorList(QObject *parent = 0);
    ~SensorList();

    Q_INVOKABLE void insert(int index, MicaSensor *sensor);
    Q_INVOKABLE void append(MicaSensor *sensor);
    Q_INVOKABLE void remove(int index);
    Q_INVOKABLE void clear();
    Q_INVOKABLE MicaSensor* get(int index);
    Q_INVOKABLE void requestData();
    Q_INVOKABLE void requestData(QString querry);
    Q_INVOKABLE bool isConnected();

public: // interface QAbstractListModel
    virtual int rowCount(const QModelIndex &parent) const;
    virtual QVariant data(const QModelIndex &index, int role) const;
    int count() const;
    bool userRequest() const;

signals:
    void countChanged(int arg);
    void downloadFinished();

public slots:
    void requestFinished(QNetworkReply *request);

protected: // interface QAbstractListModel
    virtual QHash<int, QByteArray> roleNames() const;
private:
    QList<MicaSensor*> m_data;
    QHash<int, QByteArray> m_roleNames;
    QNetworkAccessManager *m_manager;
    QNetworkConfigurationManager m_confManager;
    int m_count;
};

#endif // SENSORLIST_H
