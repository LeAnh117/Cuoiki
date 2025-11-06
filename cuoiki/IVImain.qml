import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Window {
    id: ivi
    width: 1280
    height: 720
    visible: true
    title: "IVI HMI"

    Rectangle {
        anchors.fill: parent
        color: "#1e1e1e"

        Text {
            text: "Welcome to IVI System"
            anchors.centerIn: parent
            font.pixelSize: 32
            color: "white"
        }
    }
}
