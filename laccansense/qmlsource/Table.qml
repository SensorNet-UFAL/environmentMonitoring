/* Table.qml
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


import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Item {
    width: titles.width

    property var tableData: undefined

    TableRow {
        id: titles
        cell1Text: "Environment"
        cell2Text: "Node"
        cell3Text: "Temperature [°C]"
        cell4Text: "Humidity [%]"
        cell5Text: "Pressured [mbar]"
        cell6Text: "Light [lux]"
        cell7Text: "Infrared Light [lux]"
        cell8Text: "Accelerometer X [g]"
        cell9Text: "Accelerometer Y [g]"
        cell10Text: "Voltage [mV]"
        rowColor: "lightblue"
    }

    RowLayout {
        id: dataContainer
        anchors.top: titles.bottom
        width: parent.width
        height: hpercent(root,50)
        ScrollView {
            Layout.preferredHeight: hpercent(root,100)
            Layout.fillHeight: true
            Layout.fillWidth: true

            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            ListView {
                id: view
                model: tableData
                delegate: TableRow {
                    width: ListView.view.width
                    cell1Text: model.env_id === undefined ? "-" : model.env_id
                    cell2Text: model.nodeID === undefined ? "-" : model.nodeID
                    cell3Text: model.sensirion_temp === undefined ? "-" : model.sensirion_temp.toFixed(2)
                    cell4Text: model.sensirion_hum === undefined ? "-" : model.sensirion_hum.toFixed(2)
                    cell5Text: model.intersema_press === undefined ? "-" : model.intersema_press
                    cell6Text: model.light === undefined ? "-" : model.light
                    cell7Text: model.infrared_light === undefined ? "-" : model.infrared_light
                    cell8Text: model.accel_x === undefined ? "-" : model.accel_x
                    cell9Text: model.accel_y === undefined ? "-" : model.accel_y
                    cell10Text: model.voltage === undefined ? "-" : model.voltage
                }
            }
        }
    }
}

