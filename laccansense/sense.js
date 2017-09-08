/**
    laccansense: An application for environmental monitoring through the use
    of wireless sensor networks.
    Copyright (C) 2016,  @author: Geymerson Ramos <geymerson.r@gmail.com>

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

.import "jbQuick/QChart.js" as Charts
.import "jbQuick/QChartGallery.js" as ChartsData
.import QtQuick 2.5 as QtQuickModuleImportedInJS

var component;

function setChartLabels() {
    for(var i = 0; i < graphData.count; i++) {
        if(i % 15 == 0) {
            ChartsData.ChartLineData.labels[i] = i;
        }
        else if(i == graphData.count - 1) {
            ChartsData.ChartLineData.labels[i] = i + 1;
        }
        else {
            ChartsData.ChartLineData.labels[i] = "";
        }
    }
}

function dataMeasuredValue(measuredData, pos) {
    switch (measuredData) {
        //Temperature
    case 0:
        rEnvironmentScreen.measuredEvent = "Temperature [°C]"
        return graphData.get(pos).sensirionTemp; //y values

        //Humidity
    case 1:
        rEnvironmentScreen.measuredEvent = "Humidity [%]"
        return graphData.get(pos).sensirionHum;

        //Pressure
    case 2:
        rEnvironmentScreen.measuredEvent = "Pressure [mbar]"
        return graphData.get(pos).intersemaPress;

        //Light
    case 3:
        rEnvironmentScreen.measuredEvent = "Light [lux]"
        return graphData.get(pos).light;

        //Infrared Light
    case 4:
        rEnvironmentScreen.measuredEvent = "Infrared Light [lux]"
        return graphData.get(pos).infraredLight;

        //AccelX
    case 5:
        rEnvironmentScreen.measuredEvent = "Acceleration X [g]"
        return graphData.get(pos).accelX;

        //AccelY
    case 6:
        rEnvironmentScreen.measuredEvent = "Acceleration Y [g]"
        return graphData.get(pos).accelY;
    }
}

function loadChartData(measuredData) {

    var min = 999999999999;
    var max = 0;
    if(graphData != undefined) {

        for(var i = 0; i < graphData.count; ++i) { //graphData.count = 30
            if(dataMeasuredValue(measuredData, i) > max) {
                max = dataMeasuredValue(measuredData, i);
            }
            else if(dataMeasuredValue(measuredData, i) < min) {
                min = dataMeasuredValue(measuredData, i);
            }

            lineChart.insert(i, i, dataMeasuredValue(measuredData, (graphData.count - 1) - i));
        }
        xAxis.min = 0
        xAxis.max = 29
        yAxis.min = min - min*0.0005;
        yAxis.max = max + max*0.0005;
    }
}

function loadTable() {

    if (component == null) {
        component = Qt.createComponent("qmlsource/MTableFlickArea.qml");
    }

    if (component.status == QtQuickModuleImportedInJS.Component.Ready) {
        var dynamicObject = component.createObject(oviewContainer);
        if (dynamicObject == null) {
            console.log("error loading table content");
            console.log(component.errorString());
            return false;
        }
        dynamicObject.width = oviewContainer.width - oviewContainer.width * 0.1;
        dynamicObject.height = oviewContainer.height * 0.6;
        dynamicObject.clip = true;
        dynamicObject.anchors.top = screenTitle.bottom;
        dynamicObject.anchors.topMargin = dynamicObject.height * 0.06;
        dynamicObject.anchors.horizontalCenter = oviewContainer.horizontalCenter;
        ovReloadButton.anchors.top = dynamicObject.bottom
    }
    else {
        console.log("error loading table contente");
        console.log(component.errorString());
        return false;
    }
    return true;
}

function request() {
    if(sensorList.isConnected()) {
        sensorList.requestData();
    }
    else {
        busyIndicator.running = false
        messageBox.message = "No connection has been found, please, connect your device."
        messageBox.iconSource = "./images/connectionOff.png"
        messageBox.visible = true
        messageBox.z = 1000
    }
}

function request(query) {
    if(sensorList.isConnected()) {
        sensorList.requestData(query);
    }
    else {
        busyIndicator.running = false
        messageBox.message = "No connection has been found, please, connect your device."
        messageBox.iconSource = "./images/connectionOff.png"
        messageBox.visible = true
        messageBox.z = 1000
    }
}

function createRequestString() {
    if(fromDate == undefined || toDate == undefined) {
        console.log("Error, the values of the dates are not properly configured.")
        requestString = "error"
        return;
    }

    //Search's initial date
    fromDate.setHours(fromDateTime.substr(0,2));
    fromDate.setMinutes(fromDateTime.substr(3,2));
    fromDate.setSeconds(fromDateTime.substr(6,2));

    //Search's final date
    toDate.setHours(toDateTime.substr(0,2));
    toDate.setMinutes(toDateTime.substr(3,2));
    toDate.setSeconds(toDateTime.substr(6,2));

    if(fromDate > toDate) {
        var x = fromDate;
        fromDate = toDate;
        toDate = x;
    }

    requestString = "";

//    requestString = '/' + fromDate.getTime() + '/' + toDate.getTime() + '/';
    requestString = '/' + fromDate + '/' + toDate + '/';
    requestString += roomComboBox.currentText + '/';
    requestString += emailTextField.text + '/';


    //Set search variables
    if(temperatureCheckBox.checked) {
        requestString += "sensirion_temp ";
    }
    if(humidityCheckBox.checked) {
        requestString += "sensirion_hum ";
    }
    if(pressureCheckBox.checked) {
        requestString += "intersema_press ";
    }
    if(lightCheckBox.checked) {
        requestString += "light ";
    }
    if(infraredLightCheckBox.checked) {
        requestString += "infrared_light ";
    }
    if(accelXCheckBox.checked) {
        requestString += "accel_x ";
    }
    if(accelYCheckBox.checked) {
        requestString += "accel_y ";
    }
    if(allTheFieldsCheckBox.checked) {
        requestString += "allFields"
    }
}
