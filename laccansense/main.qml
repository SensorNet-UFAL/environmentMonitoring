/**
    laccansense: an application for environment monitoring.
    This app anables users to query and visualize stored
    sensor data.

    Copyright (C) 2016,  @author: <Geymerson Ramos>
    @email: <geymerson@laccan.ufal.br>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
**/

import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

import "qmlsource"
import "jbQuick/QChart.js"        as Charts
import "jbQuick/QChartGallery.js" as ChartsData
import "sense.js" as Sense
import laccan.sense 1.0

ApplicationWindow {
    id: root
    visible: true
    height: 800
    width: 480

    function hpercent(ref,percent) { return (ref.height/100)*percent; }
    function wpercent(ref,percent) { return (ref.width/100)*percent; }   

    MMessageBox {
        id: messageBox
        width: wpercent(root, 80)
        height: hpercent(root, 40)
        visible: false
        anchors.centerIn: parent
    }

    SensorList {
        id: sensorList

        Component.onCompleted: {
            Sense.request()
        }

        onDownloadFinished: {
            busyIndicator.running = false;

            if(sensorList.count == 0 && !searchScreen.emailRequest) {
                messageBox.message = "No data found."
                messageBox.iconSource = "./images/noData.png"
                messageBox.visible = true
                messageBox.z = 1000
                overviewScreen.reloadEnabled = true
                environmentScreen.reloadEnabled = true
            }
            else {

                if(swipeView.currentIndex == 0) {
                    overviewScreen.sensorList = sensorList
                    overviewScreen.reloadEnabled = true
                }
                else if(swipeView.currentIndex == 1) {
                    environmentScreen.graphData = sensorList
                    environmentScreen.reloadEnabled = true

                    if(environmentScreen.checked == true) {
                        busyIndicator.running = true
                        Sense.request('/' + environmentScreen.targetNode + '/'
                                      + environmentScreen.environment)

                        environmentScreen.reloadEnabled = false
                        overviewScreen.reloadEnabled = false
                    }
                }
            }
            searchScreen.emailRequest = false;
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent

        currentIndex: {
            if(tabBar.currentIndex == 0)
                return 0
            return tabBar.currentIndex - 1
        }

        onCurrentIndexChanged: {
            tabBar.currentIndex = currentIndex + 1
        }

        OverviewScreen {
            id: overviewScreen
            tableVisible: tabBar.currentIndex == 1 ? true : false
        }

        EnvironmentScreen {
            id: environmentScreen

            onCheckedChanged: {
                if(checked == true) {
                    reloadEnabled = false
                    overviewScreen.reloadEnabled = false
                    busyIndicator.running = true
                    Sense.request('/' + environmentScreen.targetNode + '/'
                                  + environmentScreen.environment)

                }
                else {
                    reloadEnabled = true
                    overviewScreen.reloadEnabled = true
                }
            }
        }

        SearchScreen {
            id: searchScreen
            onRequestData: {
                if(requestString !== "error") {
                    Sense.request(requestString)
                }
            }
        }
    }

    footer: TabBar {
        id: tabBar
        height: root.height * 0.09

        onCurrentIndexChanged: {
            if(currentIndex == 1) {
                overviewScreen.tableVisible = true
            } else {
                overviewScreen.tableVisible = false
            }

        }

        TabButton {
            height: parent.height
            Image {
                id: exitIcon
                source: "images/exit.png"
                height: parent.height
                width: height
                anchors.centerIn: parent
            }
            onClicked: Qt.quit()
        }

        TabButton {
            height: parent.height
            Image {
                id: overViewIcon
                source: "images/overView.png"
                height: parent.height
                width: height
                anchors.centerIn: parent
            }

        }

        TabButton {
            height: parent.height
            Image {
                id: envIcon
                source: "images/env_info.png"
                height: parent.height
                width: height
                anchors.centerIn: parent
            }
        }

        TabButton {
            height: parent.height
            Image {
                id: searchIcon
                source: "images/searchButton.png"
                height: parent.height
                width: height
                anchors.centerIn: parent
            }
        }

        Component.onCompleted: {
            currentIndex = 1
        }
    }

    BusyIndicator {
        id: busyIndicator
        width: wpercent(root, 9)
        height: width
        anchors {
            top: parent.top
            right: parent.right
            topMargin: hpercent(root, 2)
            rightMargin: wpercent(root, 5)
        }
    }
}
