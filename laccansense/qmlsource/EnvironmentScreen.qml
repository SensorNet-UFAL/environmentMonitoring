/* EnvironmentScreen.qml
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
//import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtCharts 2.1

import "../jbQuick/QChart.js"        as Charts
import "../jbQuick/QChartGallery.js" as ChartsData
import "../sense.js" as Sense
import laccan.sense 1.0

Item {
    id: rEnvironmentScreen

    property var graphData: undefined
    property alias checked: realTimeCheckBox.checked
    property alias reloadEnabled: reloadButton.enabled
    property int targetNode: 1
    property string environment: "lab_15"
    property string measuredEvent: "Temperature [°C]"

    onGraphDataChanged: {
        lineChart.clear();
        Sense.loadChartData(measuredEventComboBox.currentIndex)
//        chart_line.update()
    }

    SystemPalette {
        id: palette
        colorGroup: SystemPalette.Active
    }

    Flickable {
        anchors.fill: parent
        contentHeight: root.height * 1.4
        contentWidth: root.width
        clip: true

        Rectangle {
            id: container
            anchors.fill: parent
            color: palette.window

            Text {
                id: screenTitle
                text: qsTr("Environment Information")
                font.pixelSize: wpercent(root, 5)
                anchors {
                    top: parent.top
                    topMargin: parent.height * 0.03
                    horizontalCenter: parent.horizontalCenter
                }
            }

            GridLayout {
                id: row
                width: parent.width
                columnSpacing: 2
                columns: 4

                anchors {
                    top: screenTitle.bottom
                    topMargin: parent.height * 0.03
                    horizontalCenter: parent.horizontalCenter
                }

                Label {
                    id: environmentLabel
                    text: "Environment: "
                    font.pixelSize: wpercent(root, 4)
                    Layout.leftMargin: 20
                    Layout.columnSpan: 2
                }

                MPickBox {
                    id: roomComboBox
                    model: ["lab_15", "lab_16", "lab_17", "reun"]
                    fontPixelSize: environmentLabel.font.pixelSize
                    Layout.columnSpan: 2
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: wpercent(root, 3)

                    onCurrentIndexChanged: {
                        environment = model[currentIndex].toLowerCase()
                    }

                    onClicked: realTimeCheckBox.checked = false

                }

                Label {
                    id: meansuredEventLabel
                    text: "Measured\nevent: "
                    font.pixelSize: environmentLabel.font.pixelSize
                    Layout.leftMargin: 20
                    Layout.columnSpan: 2
                }

                MPickBox {
                    id: measuredEventComboBox
                    Layout.columnSpan: 2
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: wpercent(root, 3)
                    model: [
                        "Temperature", "Humidity", "Pressure",
                        "Light", "Infrared light", "Acceleration X",
                        "Acceleration Y"
                    ]
                    fontPixelSize: environmentLabel.font.pixelSize
                    onCurrentIndexChanged: {
                        Sense.loadChartData(currentIndex)
//                        chart_line.update()
                    }
                    onClicked: realTimeCheckBox.checked = false
                }

                Label {
                    id: nodeLabel
                    text: "Node: "
                    font.pixelSize: environmentLabel.font.pixelSize
                    Layout.leftMargin: 20
                    Layout.columnSpan: 2
                }

                MPickBox {
                    id: nodeComboBox
                    fontPixelSize: environmentLabel.font.pixelSize
                    Layout.columnSpan: 2
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: wpercent(root, 3)

                    model: {
                        roomComboBox.currentText == 0 ?
                                    ['1','2','3','4','5'] :

                        [(roomComboBox.currentIndex * 5) + 1,
                         (roomComboBox.currentIndex * 5) + 2,
                         (roomComboBox.currentIndex * 5) + 3,
                         (roomComboBox.currentIndex * 5) + 4,
                         (roomComboBox.currentIndex * 5) + 5]
                    }

                    onCurrentTextChanged: {
//                        targetNode = currentText == "all" ? 0 : parseInt(currentText)
                        targetNode = parseInt(currentText)                        
                    }

                    onClicked: realTimeCheckBox.checked = false
                }

//                QChart {
//                    id: chart_line
//                    Layout.columnSpan: 4
//                    Layout.preferredWidth: container.width * 0.95
//                    Layout.preferredHeight: container.height * 0.4
//                    chartAnimated: true
//                    chartAnimationEasing: Easing.InOutElastic
//                    chartAnimationDuration: 2000
//                    chartData: ChartsData.ChartLineData
//                    chartType: Charts.ChartType.LINE
//                }

                ChartView {
                    id: chartView
                    Layout.columnSpan: 4
                    Layout.preferredWidth: container.width * 0.95
                    Layout.preferredHeight: container.height * 0.4
                    Layout.alignment: Qt.AlignHCenter

                    ValueAxis {
                        id: xAxis
                        min: 0
                        max: 2
                        tickCount: 2
                        titleVisible: true
                        titleText: "Last 30 measurements"
                    }

                    ValueAxis {
                        id: yAxis
                        min: 0
                        max: 2
                    }

//                    CategoryAxis {
//                        id: catXAxis

//                        CategoryRange {
//                            label: "t1"
//                        }
//                    }

                    SplineSeries {
                        id: lineChart
                        name: measuredEvent
                        axisX: xAxis
                        axisY: yAxis
                    }

                    Component.onCompleted: {
                        for(var i = 0; i < 29; i++) {
                            lineChart.append(0,0);
                        }
                    }
                }

                Rectangle {
                    id: reloadButton
                    color: "white"
                    border.color: "grey"
                    opacity: realTimeCheckBox.checked ? 0.5 : 1
                    Layout.preferredWidth: wpercent(root, 35)
                    Layout.preferredHeight: hpercent(root, 8)
                    Layout.columnSpan: 4
                    Layout.alignment: Qt.AlignHCenter

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
                            width: reloadButton.height * 0.8; height: width
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            busyIndicator.running = true
                            reloadButton.enabled = false
                            Sense.request('/' + environmentScreen.targetNode + '/'
                                          + environmentScreen.environment)
                        }
                    }
                }

                CheckBox {
                    id: realTimeCheckBox
                    text: "Real time monitoring"
                    Layout.columnSpan: 4
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}

