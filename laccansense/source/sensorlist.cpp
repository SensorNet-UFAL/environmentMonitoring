/* sensorlist.cpp
 *
 * sensorlist.h's implementation
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

#include "headers/sensorlist.h"

SensorList::SensorList(QObject *parent)
    : QAbstractListModel(parent) {

    m_roleNames[NodeIDRole] = "nodeID";
    m_roleNames[SensirionTempRole] = "sensirion_temp";
    m_roleNames[SensirionHumRole] = "sensirion_hum";
    m_roleNames[IntersemaTempRole] = "intersema_temp";
    m_roleNames[IntersemaPressRole] = "intersema_press";
    m_roleNames[InfraredLightRole] = "infrared_light";
    m_roleNames[LightRole] = "light";
    m_roleNames[AccelXRole] = "accel_x";
    m_roleNames[AccelYRole] = "accel_y";
    m_roleNames[VoltageRole] = "voltage";
    m_roleNames[StateRole] = "state";
    m_roleNames[CityRole] = "city";
    m_roleNames[LatitudeRole] = "latitude";
    m_roleNames[LongitudeRole] = "longitude";
    m_roleNames[DateRole] = "date";
    m_roleNames[EnvIDRole] = "env_id";

    m_manager = new QNetworkAccessManager(this);

    connect(m_manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(requestFinished(QNetworkReply*)));
}

SensorList::~SensorList() {

}

bool SensorList::isConnected() {
    if(!m_confManager.isOnline()) {
        qDebug() << "No connection found, please, connect your device.";
        return false;
    }
    qDebug() << "Connected.";
    return true;
}

void SensorList::requestData() {
    // replace server URL with an request address such as
    // http://myaddress/request/example
    m_manager->get(QNetworkRequest(QUrl("server URL")));
    qDebug() << "Downloading data...";
}

void SensorList::requestData(QString query) {
    qDebug() << "Starting user request download.";
    QString urlRequest("server URL"+query);
    m_manager->get(QNetworkRequest(QUrl(urlRequest)));
}

void SensorList::requestFinished(QNetworkReply *request) {
    if(request->error()) {
        qDebug() << "ERROR!";
        qDebug() << request->errorString().toUtf8();
    }
    else {
        m_data.clear();

        /** DO NOT EXCLUDE, YOU'VE BEEN WARNED!!! **/
        //        qDebug() << request->header(QNetworkRequest::ContentTypeHeader).toString();
        //        qDebug() << request->header(QNetworkRequest::LastModifiedHeader).toDateTime().toString();;
        //        qDebug() << request->header(QNetworkRequest::ContentLengthHeader).toULongLong();
        //        qDebug() << request->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
//                qDebug() << request->attribute(QNetworkRequest::HttpReasonPhraseAttribute).toString();

        //QString receivedData = (QString)request->readAll();
        QByteArray receivedData = request->readAll();
        QJsonDocument jsonResponse = QJsonDocument::fromJson(receivedData);       
        QJsonArray jsonArray = jsonResponse.array();


        //Create a sensor instance and save it inside a list
        foreach (const QJsonValue & value, jsonArray) {
            QJsonObject obj = value.toObject();
            MicaSensor *sensor = new MicaSensor();            

            sensor->setNodeID(obj["nodeID"].toString().toInt());
            sensor->setSensirionTemp(obj["sensirion_temp"].toString().toDouble());
            sensor->setSensirionHum(obj["sensirion_hum"].toString().toDouble());
            sensor->setIntersemaTemp(obj["intersema_temp"].toString().toDouble());
            sensor->setIntersemaPress(obj["intersema_press"].toString().toDouble());
            sensor->setInfraredLight(obj["infrared_light"].toString().toInt());
            sensor->setLight(obj["light"].toString().toInt());
            sensor->setAccelX(obj["accel_x"].toString().toInt());
            sensor->setAccelY(obj["accel_y"].toString().toInt());
            sensor->setVoltage(obj["voltage"].toString().toInt());
            sensor->setCountry(obj["country"].toString());
            sensor->setState(obj["state"].toString());
            sensor->setCity(obj["city"].toString());
            sensor->setLatitude(obj["latitude"].toString());
            sensor->setLongitude(obj["longitude"].toString());
            sensor->setEnvID(obj["env_id"].toString());
            sensor->setDate(obj["date"].toString());
            m_data.append(sensor);
        }
    }

    emit downloadFinished();
    qDebug() << "Download has finished";
    request->deleteLater();
}

void SensorList::insert(int index, MicaSensor *sensor) {
    if(index < 0 || index > m_data.count()) {
        return;
    }

    emit beginInsertRows(QModelIndex(), index, index);
    m_data.insert(index, sensor);
    emit endInsertRows();
    emit countChanged(m_data.count());
}

void SensorList::append(MicaSensor *sensor) {
    insert(count(), sensor);
}

void SensorList::remove(int index) {
    if(index < 0 || index >= m_data.count()) {
        return;
    }
    emit beginRemoveRows(QModelIndex(), index, index);
    m_data.removeAt(index);
    emit endRemoveRows();
    emit countChanged(m_data.count());
}

void SensorList::clear() {
    emit beginResetModel();
    m_data.clear();
    emit endResetModel();
}

MicaSensor* SensorList::get(int index) {
    if(index < 0 || index >= m_data.count()) {
        qDebug() << "Empty list access.";
        return NULL;
    }
    return m_data.at(index);
}

int SensorList::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant SensorList::data(const QModelIndex &index, int role) const {
    int row = index.row();
    if(row < 0 || row >= m_data.count()) {
        return QVariant();
    }
    MicaSensor *sensor = m_data.at(row);
    switch(role) {
    case NodeIDRole:
        // return sensor's ID as a string (model.nodeID)
        return sensor->nodeID();

    case SensirionHumRole:
        // return sensor's sensirion humudity (model.sensirion_hum)
        return sensor->sensirionHum();

    case SensirionTempRole:
        // return sensor's sensirion temperature (model.sensirion_temp)
        return sensor->sensirionTemp();

    case IntersemaTempRole:
        // return sensor's intersema temperature (model.intersema_temp)
        return sensor->intersemaTemp();

    case IntersemaPressRole:
        // return sensor's intersema pressure (model.intersema_press)
        return sensor->intersemaPress();

    case EnvIDRole:
        return sensor->envID();

    case InfraredLightRole:
        return sensor->infraredLight();

    case LightRole:
        return sensor->light();

    case AccelXRole:
        return sensor->accelX();

    case AccelYRole:
        return sensor->accelY();

    case VoltageRole:
        return sensor->voltage();

    case StateRole:
        return sensor->state();

    case CityRole:
        return sensor->city();

    case LatitudeRole:
        return sensor->latitude();

    case LongitudeRole:
        return sensor->longitude();

    case DateRole:
        return sensor->date();
    }
    return QVariant();
}

int SensorList::count() const {
    return rowCount(QModelIndex());
}

QHash<int, QByteArray> SensorList::roleNames() const {
    return m_roleNames;
}
