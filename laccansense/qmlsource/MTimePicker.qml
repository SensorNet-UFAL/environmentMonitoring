/* MTimePicker.qml
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
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

Item {
    id: rTimePicker
    property int hour: 0
    property int minutes: 0
    property int seconds: 0
    signal timePicked

    width: wpercent(root, 70)
    height: hpercent(root, 40)

    SystemPalette {
        id: pallete
        colorGroup: SystemPalette.Active
    }

    Rectangle {
        color: Qt.lighter(pallete.window, 0.9)
        border.color: pallete.highlight
        height: rTimePicker.height
        width: rTimePicker.width

        GridLayout {
            z: 10
            columns: 4
            anchors.fill: parent
            anchors.centerIn: parent

            Label {
                id: hourLabel
                text: "Hour: "
                font.pixelSize: wpercent(root, 4)
                Layout.columnSpan: 2
            }

            MPickBox {
                id: hourPickBox
                model: 24
                fontPixelSize: wpercent(root, 4)
                Layout.columnSpan: 2
                onCurrentIndexChanged: {
                    hour = currentIndex
                }
            }

            Label {
                id: minutesLabel
                text: "Minutes: "
                font.pixelSize: wpercent(root, 4)
                Layout.columnSpan: 2
            }

            MPickBox {
                id: minutesPickBox
                model: 60
                fontPixelSize: wpercent(root, 4)
                Layout.columnSpan: 2
                onCurrentIndexChanged: {
                    minutes = currentIndex
                }
            }

            Label {
                id: secondsLabel
                text: "Seconds: "
                font.pixelSize: wpercent(root, 4)
                Layout.columnSpan: 2
            }

            MPickBox {
                id: secondsPickBox
                model: 60
                fontPixelSize: wpercent(root, 4)
                Layout.columnSpan: 2
                onCurrentIndexChanged: {
                    seconds = currentIndex
                }
            }

            MButton {
                id: confirmButton
                source: "../images/confirm.png"
                Layout.preferredHeight:  hpercent(root, 8)
                Layout.preferredWidth: Layout.preferredHeight
                Layout.columnSpan: 4
                Layout.alignment: Qt.AlignHCenter

                onClicked: {
                    rTimePicker.z = 0
                    rTimePicker.visible = false
                    rTimePicker.timePicked()
                }
            }
        }
    }
}
