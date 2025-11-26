import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    anchors.fill: parent
    color: "#202020"

    property string callerName: "Huỳnh Công Vinh"
    signal acceptCall()
    signal rejectCall()

    Column {
        anchors.centerIn: parent
        spacing: 30

        Text {
            text: "Cuộc gọi đến"
            font.pixelSize: 28
            color: "white"
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            text: callerName
            font.pixelSize: 22
            color: "lime"
            horizontalAlignment: Text.AlignHCenter
        }

        Row {
            spacing: 60
            Button {
                text: "Từ chối"
                background: Rectangle { color: "red"; radius: 10 }
                onClicked: root.rejectCall()
            }
            Button {
                text: "Chấp nhận"
                background: Rectangle { color: "green"; radius: 10 }
                onClicked: root.acceptCall()
            }
        }
    }
}
