import QtQuick 2.15
import QtQuick.Window 2.15

//import Device 1.0
Item {
    id: name
    visible: true
    width: 410
    height: 860

    function removePrefix(str) {
        var index = str.indexOf(":")
        if (index !== -1) {
            return str.substring(index + 1) // Extract substring after ":"
        }
        return str // Return original string if ":" is not found
    }

    Rectangle {
        visible: true
        id: button
        color: "lightsteelblue"
        width: parent.width
        height: parent.height / 2
        anchors.top: parent.top

        Text {
            id: hrValue
            anchors.centerIn: parent
            color: "red"
            font.pixelSize: 20
            visible: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                button.color = "lightgreen"
                device.startDeviceDiscovery()
            }
        }
    }

    Rectangle {

        id: viewContainer
        color: "#e6e6e6"
        radius: 14
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: button.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 12
        anchors.rightMargin: 13
        anchors.topMargin: 6
        anchors.bottomMargin: 10

        ListView {
            id: bleListView
            anchors.fill: parent
            model: bleModel

            //clip: true
            delegate: Rectangle {

                //required property int index
                width: parent.width
                height: 50

                color: index % 2 === 0 ? "#262626" : "#404040"
                radius: 14
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        device.connectDevice(bleAddress)
                        console.log(bleName + ": " + bleAddress)
                    }
                }

                Text {
                    text: bleName // Display the BLE name
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    leftPadding: 10
                    font.pixelSize: 20
                    color: "white"
                }
                Text {
                    text: bleAddress // Display the BLE address
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    rightPadding: 10
                    font.pixelSize: 20
                    color: "white"
                }
            }
        }

        function addBleDevice(bleName, bleAddress) {
            bleModel.append({
                                "bleName": bleName,
                                "bleAddress": bleAddress
                            })
        }

        ListModel {
            id: bleModel
        }
    }

    Connections {
        target: device
        function onSendAddress(bleName, bleAddress) {
            viewContainer.visible = true
            console.log(bleName + ": " + bleAddress)
            viewContainer.addBleDevice(bleName, bleAddress)
        }

        function onMeasuringChanged(hrVal) {
            console.log("HR Value:" + hrVal)
            hrValue.text = "HrValue: " + hrVal
        }
    }
}
