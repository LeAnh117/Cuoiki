import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#101010"

    property string callerName: ""
    property int callSeconds: 0
    signal endCall()

    Timer {
        id: callTimer
        interval: 1000
        repeat: true
        onTriggered: root.callSeconds += 1
    }

    function startCall(name) {
        callerName = name
        callSeconds = 0
        callTimer.start()
        root.visible = true
    }

    Column {
        anchors.centerIn: parent
        spacing: 30

        Text {
            text: callerName
            font.pixelSize: 26
            color: "white"
        }

        Text {
            text: Qt.formatTime(new Date(callSeconds * 1000), "mm:ss")
            font.pixelSize: 22
            color: "lime"
        }

        Button {
            text: "Kết thúc"
            background: Rectangle { color: "red"; radius: 10 }
            onClicked: {
                callTimer.stop()
                root.endCall()
            }
        }
    }
}
