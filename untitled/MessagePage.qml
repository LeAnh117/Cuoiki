import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: messagePageRoot
    anchors.fill: parent            //  Quan trọng!
    color: "#1E1E1E"
    visible: false

    property var messageModel
    signal backRequested()

    Rectangle {
        id: header
        height: 50
        anchors.top: parent.top     //  thêm để header cố định trên cùng
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#2E2E2E"

        Text {
            text: "< Quay lại"
            anchors.centerIn: parent
            font.pixelSize: 20
            color: "white"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: messagePageRoot.backRequested()
        }
    }

    ListView {
        id: messageList
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: 10

        model: messagePageRoot.messageModel

        delegate: Item {
            width: messageList.width
            implicitHeight: bubble.implicitHeight + 10

            Rectangle {
                id: bubble
                width: parent.width * 0.7
                implicitHeight: textItem.implicitHeight + 20
                radius: 10
                color: sender === "me" ? "#DCF8C6" : "#FFFFFF"
                border.width: 1
                border.color: "#CCCCCC"

                anchors.left: sender === "me" ? undefined : parent.left
                anchors.right: sender === "me" ? parent.right : undefined
                anchors.margins: 10

                Text {
                    id: textItem
                    text: content
                    wrapMode: Text.WordWrap
                    anchors.fill: parent
                    anchors.margins: 10
                    color: "black"
                }
            }
        }

    }
}
