/* MPickBox.qml
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

Item {
    id: pickBox
    height: hpercent(root, 10)
    width: wpercent(root, 35)

    signal clicked

    property alias model: listView.model
    property alias textColor: boxContent.color
    property alias fontPixelSize: boxContent.font.pixelSize
    property alias fontBold: boxContent.font.bold
    property int currentIndex: 0
    property int indexInc: 0
    property string currentText: ""
    property color color: "white"
    property color borderColor: "black"

    Rectangle {
        id: currentItemDisplay
        height: pickBox.height
        width: pickBox.width
        color: pickBox.color
        border.color: pickBox.borderColor
        anchors.centerIn: parent

        Text {
            id: boxContent
            text: currentText
            anchors.centerIn: parent
            font.pixelSize: wpercent(root, 3)
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                currentItemDisplay.visible = false
                itemList.visible = true
                pickBox.z = 1000
                pickBox.clicked()
            }
        }
    }

    Item {
        id: itemList
//        width: parent.width
        width: 200
        height: 150
        visible: false
        anchors.left: parent.left

        ListView {
            id: listView
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            delegate: componentDelegate
            spacing: 2
            focus: true
        }

        Component {
            id: componentDelegate

            Rectangle {
                width: ListView.view.width
                height: hpercent(root, 10)
                color: pickBox.color
                border.color: pickBox.borderColor

                Text {
                    anchors.centerIn: parent
                    font.pixelSize: wpercent(root, 3)
                    color: pickBox.textColor
                    font.bold: true
                    Component.onCompleted: {
                        if(typeof modelData === "string" || modelData instanceof String) {
                            text = modelData.substr(0, 8);
                        }
                        else {
                            text = modelData
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pickBox.currentIndex = index
                        if(typeof modelData === "string" || modelData instanceof String) {
                            pickBox.currentText = modelData.substr(0, 8);
                        }
                        else {
                            pickBox.currentText = modelData
                        }
//                        pickBox.currentText = modelData.substr(0, 8)
                        itemList.visible = false
                        pickBox.z = 0
                        currentItemDisplay.visible = true
                    }
                }

                Component.onCompleted: {
                    if(index == 0) {
                        if(typeof modelData === "string" || modelData instanceof String) {
                            pickBox.currentText = modelData.substr(0, 8);
                        }
                        else {
                            pickBox.currentText = modelData
                        }
                    }
                }
            }
        }
    }
}
