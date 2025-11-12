import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id: languageDialog
    modal: true
    focus: true
    width: 300
    height: 200
    background: Rectangle {
        color: "#222"
        radius: 10
        border.color: "#00FF66"
    }
    onClosed: focus = false
    signal languageSelected(string lang)

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: qsTr("Chọn ngôn ngữ / Select Language")
            color: "white"
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Row {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: "Tiếng Việt 🇻🇳"
                onClicked: {
                    languageSelected("vi");
                    languageDialog.close()
                }
            }
            Button {
                text: "English 🇬🇧"
                onClicked: {
                    languageSelected("en");
                    languageDialog.close()
                }
            }
        }
    }
}
