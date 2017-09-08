/* OverviewScreen.qml
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
import laccan.sense 1.0
import "../sense.js" as Sense

Item {

    signal accepted
    signal rejected

    property alias reloadEnabled: ovReloadButton.enabled
    property alias tableVisible: flickArea.visible
    property var sensorList: undefined

    onSensorListChanged: {
        Sense.loadTable()
    }

    SystemPalette {
        id: pallete
        colorGroup: SystemPalette.Active
    }

    Flickable {
        id: flickArea
        anchors.fill: parent
        clip: true
        contentHeight: oviewContainer.height

        Rectangle {
            id: oviewContainer
            width: parent.width
            height: hpercent(root, 115)
            color: pallete.window
            border.color: pallete.dark

            Text {
                id: screenTitle
                text: qsTr("Overall Information")
                font.pixelSize: wpercent(root, 5)
                anchors {
                    top: parent.top
                    topMargin: parent.height * 0.03
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: ovReloadButton
                color: "white"
                border.color: "grey"
                width: wpercent(root, 35)
                height: hpercent(root, 8)
                anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    anchors.centerIn: parent

                    Label {
                        id: reloadButtonLabel
                        text: "Reload "
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: wpercent(root, 4)
                    }

                    Image {
                        id: reloadButtonIcon
                        source: "../images/reload.png"
                        width: ovReloadButton.height * 0.8; height: width
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        busyIndicator.running = true
                        Sense.request()
//                        sensorList.requestData('/' + environmentScreen.targetNode + '/'
//                                               + environmentScreen.environment)
                        ovReloadButton.enabled = false
                    }
                }
            }
        }
    }
}
