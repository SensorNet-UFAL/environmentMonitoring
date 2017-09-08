/* SearchScreen.qml
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
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
//import QtQuick.Controls 2.0
import "../sense.js" as Sense

Item {
    id: rSearchScreen

    signal accepted
    signal rejected
    signal requestData

    property bool dateVerifier: true
    property bool emailRequest: false
    property var fromDate: undefined
    property string fromDateTime: "00:00:00"
    property var toDate: undefined
    property string toDateTime: "00:00:00"
    property int labelFontPixelSize: wpercent(root, 3)
    property string requestString: ""

    SystemPalette {
        id: pallete
        colorGroup: SystemPalette.Active
    }

    Flickable {
        anchors.fill: parent
        clip: true
        contentHeight: root.height * 1.4
        contentWidth: root.width

        Rectangle {
            id: container
            color: pallete.window
            border.color: pallete.dark
            anchors.fill: parent

            Text {
                id: title
                text: qsTr("Data search")
                font.pixelSize: wpercent(root, 5)
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: wpercent(root, 2)
                }
            }

            GridLayout {
                id: environment
                columns: 4
                columnSpacing: 2
                width: parent.width

                anchors {
                    top: title.bottom
                    topMargin: hpercent(root, 5)
                    horizontalCenter: parent.horizontalCenter
                }

                Label {
                    id: environmentLabel
                    text: "Environment: "
                    font.pixelSize: wpercent(root, 4)
                    Layout.columnSpan: 2
                    Layout.leftMargin:  wpercent(root, 4)
                }

                MPickBox {
                    id: roomComboBox
                    model: ["lab_16", "lab_17", "lab_18", "reun", "All"]
                    Layout.preferredWidth: wpercent(root, 35)
                    fontPixelSize: environmentLabel.font.pixelSize
                    Layout.columnSpan: 2
                    Layout.rightMargin:  wpercent(root, 4)
                    Layout.alignment: Qt.AlignRight
                }

                Label {
                    id: fromDateLabel
                    text: "From date: "
                    font.pixelSize: wpercent(root, 4)
                    Layout.columnSpan: 4
                    Layout.leftMargin:  wpercent(root, 4)
                }

                Rectangle {
                    Layout.columnSpan: 4
                    Layout.fillWidth: true
                    Layout.preferredHeight: hpercent(root, 11)
                    Layout.leftMargin: wpercent(root, 4)
                    Layout.rightMargin: wpercent(root, 4)
                    color: container.color
                    border.color: Qt.lighter(color, 0.9)
                    radius: 3

                    GridLayout {
                        columns: 2
                        width: parent.width
                        rowSpacing: 3

                        Label {
                            id: fromDateDayLabel
                            text: "Day "
                            font.pixelSize: wpercent(root, 4)
                        }

                        Rectangle {
                            width: wpercent(root, 20)
                            Layout.preferredWidth: wpercent(root, 35)
                            Layout.preferredHeight: hpercent(root, 5)
                            color: "white"
                            border.color: "black"
                            Layout.alignment: Qt.AlignRight

                            Text {
                                id: fromDateText
                                text: qsTr("mm:dd:yyyy")
                                anchors.centerIn: parent
                                font.pixelSize: environmentLabel.font.pixelSize
                            }

                            MouseArea {
                                id: fromDateClickArea
                                anchors.fill: parent
                                onClicked: {
                                    dateVerifier = true
                                    datePicker.visible = true
                                }
                            }
                        }

                        Label {
                            id: fromDateTimeLabel
                            text: "Time "
                            font.pixelSize: wpercent(root, 4)
                        }

                        Rectangle {
                            Layout.preferredWidth: wpercent(root, 35)
                            Layout.preferredHeight: hpercent(root, 5)
                            color: "white"
                            border.color: "black"
                            Layout.alignment: Qt.AlignRight

                            Text {
                                id: fromDateTimeText
                                text: qsTr("00:00:00")
                                anchors.centerIn: parent
                                font.pixelSize: environmentLabel.font.pixelSize
                            }

                            MouseArea {
                                id: fromDateTimeClickArea
                                anchors.fill: parent
                                onClicked: {
                                    dateVerifier = true
                                    timePicker.visible = true
                                }
                            }
                        }
                    }
                }

                Label {
                    id: toDateLabel
                    text: "To date: "
                    font.pixelSize: wpercent(root, 4)
                    Layout.columnSpan: 4
                    Layout.leftMargin: 20
                }

                Rectangle {
                    Layout.columnSpan: 4
                    Layout.fillWidth: true
                    Layout.preferredHeight: hpercent(root, 11)
                    Layout.leftMargin: wpercent(root, 4)
                    Layout.rightMargin: wpercent(root, 4)
                    color: container.color
                    border.color: Qt.lighter(color, 0.9)
                    radius: 3

                    GridLayout {
                        columns: 2
                        width: parent.width
                        rowSpacing: 3

                        Label {
                            id: toDateDayLabel
                            text: "Day "
                            font.pixelSize: wpercent(root, 4)
                        }

                        Rectangle {
                            Layout.preferredWidth: wpercent(root, 35)
                            Layout.preferredHeight: hpercent(root, 5)
                            color: "white"
                            border.color: "black"
                            Layout.alignment: Qt.AlignRight

                            Text {
                                id: toDateText
                                text: qsTr("mm:dd:yyyy")
                                anchors.centerIn: parent
                                font.pixelSize: environmentLabel.font.pixelSize
                            }

                            MouseArea {
                                id: toDateClickArea
                                anchors.fill: parent
                                onClicked: {
                                    dateVerifier = false
                                    datePicker.visible = true
                                }
                            }
                        }

                        Label {
                            id: toDateTimeLabel
                            text: "Time "
                            font.pixelSize: wpercent(root, 4)
                        }

                        Rectangle {
                            Layout.preferredWidth: wpercent(root, 35)
                            Layout.preferredHeight: hpercent(root, 5)
                            color: "white"
                            border.color: "black"
                            Layout.alignment: Qt.AlignRight

                            Text {
                                id: toDateTimeText
                                text: qsTr("00:00:00")
                                anchors.centerIn: parent
                                font.pixelSize: environmentLabel.font.pixelSize
                            }

                            MouseArea {
                                id: toDateTimeClickArea
                                anchors.fill: parent
                                onClicked: {
                                    dateVerifier = false
                                    timePicker.visible = true
                                }
                            }
                        }
                    }
                }

                Label {
                    id: dataLabel
                    text: "Get data of: "
                    font.pixelSize: wpercent(root, 4)
                    Layout.columnSpan: 4
                    Layout.leftMargin: 20
                }

                GroupBox {
                    id: dataGroupBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: hpercent(root, 15)
                    Layout.columnSpan: 4
                    Layout.rightMargin: wpercent(root, 4)
                    Layout.leftMargin: wpercent(root, 4)

                    Grid {
                        id: checkBoxes
                        anchors.fill: parent
                        columns: 4

                        CheckBox {
                            id: temperatureCheckBox
                            onCheckedChanged: {
                                if(checked) {
                                    allTheFieldsCheckBox.checked = false;
                                }
                            }
                        }

                        Label {
                            id: temperatureLabel
                            text: "Temperature"
                            font.pixelSize: labelFontPixelSize
//                            Layout.column: 2
                        }

                        CheckBox {
                            id: humidityCheckBox
                            onCheckedChanged: {
                                if(checked) {
                                    allTheFieldsCheckBox.checked = false;
                                }
                            }
                        }

                        Label {
                            id: humidityLabel
                            text: "Humidity"
                            font.pixelSize: labelFontPixelSize
                        }

                        CheckBox {
                            id: pressureCheckBox
                            onCheckedChanged: {
                                if(checked) {
                                    allTheFieldsCheckBox.checked = false;
                                }
                            }
                        }

                        Label {
                            id: pressureLabel
                            text: "Pressure"
                            font.pixelSize: labelFontPixelSize
                        }

                        CheckBox {
                            id: lightCheckBox
                            onCheckedChanged: {
                                if(checked) {
                                    allTheFieldsCheckBox.checked = false;
                                }
                            }
                        }

                        Label {
                            id: lightLabel
                            text: "Light"
                            font.pixelSize: labelFontPixelSize
                        }

                        CheckBox {
                            id: infraredLightCheckBox
                            onCheckedChanged: {
                                if(checked) {
                                    allTheFieldsCheckBox.checked = false;
                                }
                            }
                        }

                        Label {

                            id: infraredLightLabel
                            text: "Infrared Light"
                            font.pixelSize: labelFontPixelSize
                        }

                        CheckBox {
                            id: accelXCheckBox
                            onCheckedChanged: {
                                if(checked) {
                                    allTheFieldsCheckBox.checked = false;
                                }
                            }
                        }

                        Label {
                            id: accelXLabel
                            text: "Acceleration X"
                            font.pixelSize: labelFontPixelSize
                        }

                        CheckBox {
                            id: accelYCheckBox
                            onCheckedChanged: {
                                if(checked) {
                                    allTheFieldsCheckBox.checked = false;
                                }
                            }
                        }

                        Label {
                            id: accelYLabel
                            text: "Acceleration Y"
                            font.pixelSize: labelFontPixelSize
                        }

                        CheckBox {
                            id: allTheFieldsCheckBox
                            onCheckedChanged: {
                                if(checked) {
                                    temperatureCheckBox.checked = false;
                                    humidityCheckBox.checked = false;
                                    pressureCheckBox.checked = false;
                                    lightCheckBox.checked = false;
                                    infraredLightCheckBox.checked = false;
                                    accelXCheckBox.checked = false;
                                    accelYCheckBox.checked = false;
                                }
                            }
                        }

                        Label {
                            id: allTheFieldsLabel
                            text: "All the fields"
                            font.pixelSize: labelFontPixelSize
                        }
                    }
                }


                Label {
                    id: emailLabel
                    text: "Send a download link\nto my e-mail"
                    font.pixelSize: wpercent(root, 4)
                    Layout.columnSpan: 4
                    Layout.alignment: Qt.AlignHCenter
                }

                TextField {
                    id: emailTextField
                    Layout.columnSpan: 4
                    Layout.preferredHeight: wpercent(root, 11)
                    Layout.fillWidth: true
                    Layout.leftMargin: 20
                    Layout.rightMargin: 20
                    validator: RegExpValidator { regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }
                }

                Rectangle {
                    id: downloadButton
                    color: "white"
                    border.color: "grey"
                    Layout.preferredWidth: wpercent(root, 35)
                    Layout.preferredHeight: hpercent(root, 8)
                    Layout.columnSpan: 4
                    Layout.alignment: Qt.AlignHCenter
                    enabled: emailTextField.acceptableInput == true ? true : false

                    Row {
                        anchors.centerIn: parent

                        Label {
                            id: downloadButtonLabel
                            text: "E-mail me "
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Image {
                            id: downloadButtonIcon
                            source: "../images/email.png"
                            width: 35; height: 35
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            emailRequest = true
                            Sense.createRequestString()
                            console.log(requestString)
                            Sense.request(requestString)
                        }
                        onEntered: {
                            downloadButton.color = "grey"
                            downloadButton.border.color = "white"
                        }
                        onExited: {
                            downloadButton.color = "white"
                            downloadButton.border.color = "grey"
                        }
                    }
                }

//                Rectangle {
//                    Layout.columnSpan: 4
//                    Layout.fillWidth: true
//                    Layout.preferredHeight: hpercent(root, 11)
//                    Layout.leftMargin: 20
//                    Layout.rightMargin: 20
//                    color: container.color
//                    border.color: Qt.lighter(color, 0.9)
//                    radius: 3

//                    GridLayout {
//                        columns: 2
//                        width: parent.width
//                        rowSpacing: 3

//                        Label {
//                            id: folderLabel
//                            text: "Folder "
//                            font.pixelSize: wpercent(root, 4)
//                        }
//                    }
//                }
            }

            Calendar {
                id: datePicker
                width: parent.width * 0.9
                height: parent.height * 0.7
                visible: false
                anchors.centerIn: parent

                onClicked: {
                    var x;
                    if(dateVerifier) {
                        fromDate = new Date(datePicker.selectedDate)
//                        console.log(fromDate)
                        if(!(toDate === undefined) && fromDate > toDate) { //Switch if fromDate is lesser than toDate
                            x = fromDate;
                            fromDate = toDate;
                            toDate = x;
                            toDateText.text = toDate.toDateString()
                        }
                        fromDateText.text = fromDate.toDateString()
                    }
                    else {
                        toDate = new Date(datePicker.selectedDate)
                        if(!(fromDate === undefined) && fromDate > toDate) {
                            x = fromDate;
                            fromDate = toDate;
                            toDate = x;
                            fromDateText.text = fromDate.toDateString()
                        }
                        toDateText.text = toDate.toDateString()
                    }
                    visible = false
                }
            }

            MTimePicker {
                id: timePicker
                visible: false
                anchors.centerIn: parent
                onTimePicked: {
                    if(dateVerifier) {

                        //hours
                        fromDateTime =
                                hour.toString().length == 1 ?
                                    '0' + hour.toString():
                                    hour.toString()
                        //minutes
                        fromDateTime = minutes.toString().length == 1 ?
                                    fromDateTime + ':' + '0' + minutes.toString() :
                                    fromDateTime + ':' + minutes.toString()
                        //seconds
                        fromDateTime = seconds.toString().length == 1 ?
                                    fromDateTime + ':' + '0' + seconds.toString() :
                                    fromDateTime + ':' + seconds.toString()

                        //Time display
                        fromDateTimeText.text = fromDateTime
                    }
                    else {

                        //hours
                        toDateTime =
                                hour.toString().length == 1 ?
                                    '0' + hour.toString():
                                    hour.toString()
                        //minutes
                        toDateTime = minutes.toString().length == 1 ?
                                    toDateTime + ':' + '0' + minutes.toString() :
                                    toDateTime + ':' + minutes.toString()
                        //seconds
                        toDateTime = seconds.toString().length == 1 ?
                                    toDateTime + ':' + '0' + seconds.toString() :
                                    toDateTime + ':' + seconds.toString()

                        //Time display
                        toDateTimeText.text = toDateTime
                    }
                }
            }

            /** Implement to desktop **/
            //    FileDialog {
            //        id: fileDialog
            //        title: "Saving directory"
            //        folder: shortcuts.home
            //        selectFolder: true

            //        onAccepted: {
            //            querryString = new String;
            //            querryString = '/' + fromDate
            //                    + '/' + toDate

            //            //            if(temperatureCheckBox.checked) {
            //            //                 querryString =  querryString + "/temperature"
            //            //            }
            //            //            if(humidityCheckBox.checked) {
            //            //                querryString =  querryString + "/humidity"
            //            //            }
            //            //            if(pressureCheckBox.checked) {
            //            //                querryString =  querryString + "/pressure"
            //            //            }
            //            //            if(lightCheckBox.checked) {
            //            //                querryString =  querryString + "/light"
            //            //            }
            //            //            if(infLightCheckBox.checked) {
            //            //                querryString =  querryString + "/infraredLight"
            //            //            }
            //            //            if(accelXCheckBox.checked) {
            //            //                querryString =  querryString + "/accelX"
            //            //            }
            //            //            if(accelYCheckBox.checked) {
            //            //                querryString =  querryString + "/accelY"
            //            //            }


            //            //            console.log(querryString);
            //            //            console.log("You chose: " + fileDialog.fileUrls)
            //            rSearchScreen.accepted();
            //            rSearchScreen.visible = false
            //            rSearchScreen.z = 0
            //        }

            //        onRejected: {
            //            rSearchScreen.rejected()
            //            console.log("Canceled.")
            //        }
        }
    }
}
