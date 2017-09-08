/* MMessageBox.qml
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

import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: rMessageBox
    color: "black"

    property alias message: message.text
    property alias iconSource: icon.source

    Item {
        anchors.fill: parent
        anchors.margins: 1

        Rectangle {
            border.color: rMessageBox.color
            color: "yellow"
            anchors.top: parent.top
            width: parent.width
            height: parent.height * 0.3

            Image {
                id: icon
                height: parent.height
                width: height
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        TextArea {
            id: message
            anchors.bottom: parent.bottom
            width: parent.width
            height: parent.height * 0.7
            wrapMode: TextEdit.WrapAnywhere
            readOnly: true
            verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
            font.pixelSize: wpercent(root, 7.5)
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.visible = false
            parent.z = 0
        }
    }
}
