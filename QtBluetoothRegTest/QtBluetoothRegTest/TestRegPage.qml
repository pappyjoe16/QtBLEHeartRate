import QtQuick 2.15
import QtQuick.Window 2.15

//import Device 1.0
Item {
    id: name
    visible: true
    width: Screen.width / 2
    height: Screen.height / 2

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
        id: connectButton
        width: parent.width
        height: parent.height / 2
        visible: false
        anchors.bottom: parent.bottom
        color: "grey"

        Text {
            id: address
            anchors.centerIn: parent
            color: "red"
            font.pixelSize: 20
            visible: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                connectButton.color = "lightred"

                console.log(address.text)
                var newAddressText = removePrefix(address.text)
                console.log(newAddressText)
                device.connectDevice(newAddressText)
            }
        }
    }

    Connections {
        target: device
        function onSendAddress(bleAddress) {
            connectButton.visible = true
            console.log("Address: " + bleAddress)
            address.text = "Address:" + bleAddress
        }

        function onMeasuringChanged(hrVal) {
            console.log("HR Value:" + hrVal)
            hrValue.text = "HrValue: " + hrVal
        }
    }
}
