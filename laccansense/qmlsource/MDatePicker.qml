import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1


Rectangle {

    id: root
    color: "green"
    width: parent.width
    height: 70

    property bool verifier: true
    property var fromDate: undefined
    property var toDate: undefined
    property var calendarVcenter: undefined
    property alias calendarWidth: datePicker.width
    property alias calendarHeight: datePicker.height

    Grid {
        anchors.horizontalCenter: parent.horizontalCenter
        columns: 2
        spacing: 5

        Label {
            id: fromDateLabel
            text: "From date: "
        }

        Rectangle {
            width: root.width * 0.5;
            height: fromDateLabel.contentHeight * 1.5
            color: "grey"

            Text {
                id: fromDateText
                text: qsTr("dd - mm - yyyy")
                anchors.centerIn: parent
            }

            MouseArea {
                id: fromDateClickArea
                anchors.fill: parent
                onClicked: {
                    datePicker.visible = true
                    verifier = true
                }
            }
        }

        Label {
            id: toDateLabel
            text: "To date: "
        }

        Rectangle {
            width: root.width * 0.5;
            height: fromDateLabel.contentHeight * 1.5
            color: "grey"

            Text {
                id: toDateText
                text: qsTr("dd - mm - yyyy")
                anchors.centerIn: parent
            }

            MouseArea {
                id: toDateClickArea
                anchors.fill: parent
                onClicked: {
                    datePicker.visible = true
                    verifier = false
                }
            }
        }
    }


    Calendar {
        id: datePicker
        width: parent.width * 0.9
        height: parent.height * 0.7
        visible: false
        anchors.verticalCenter: calendarVcenter

        onClicked: {

            if(verifier) {
                fromDate = new Date(datePicker.selectedDate)
                fromDateText.text = fromDate.toDateString()
                minimumDate = fromDate
                console.log(fromDate.toDateString())
            }
            else {
                toDate = new Date(datePicker.selectedDate)
                console.log(toDate.toDateString())
                toDateText.text = toDate.toDateString()
            }
            visible = false
        }
    }
}
