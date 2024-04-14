import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import Device 1.0

Window {
    width: 410
    height: 960
    visible: true
    id: mainWindow
    title: "gymAppTest2"

    Device {
        id: device
    }

    TestRegPage {
        id: mainPage
        visible: true
    }
}
