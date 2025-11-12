import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import "." 1.0  // để dùng Theme.qml

Window {
    id: settingsWindow
    width: 350
    height: 250
    title: "Cài đặt"
    visible: false
    property string currentTheme: "dark"

    color: currentTheme === "dark" ? Theme.bgDark2 : Theme.bgLight

    signal themeChanged(string newTheme)

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Chuyển chế độ hiển thị"
            font.pixelSize: 20
            color: settingsWindow.currentTheme === "dark" ? Theme.textDark : Theme.textLight
            horizontalAlignment: Text.AlignHCenter
        }

        RowLayout {
            spacing: 10
            Layout.alignment: Qt.AlignHCenter

            Text {
                text: "Chế độ tối:"
                color: settingsWindow.currentTheme === "dark" ? Theme.textDark : Theme.textLight
            }

            Switch {
                id: themeSwitch
                checked: settingsWindow.currentTheme === "dark"
                onToggled: settingsWindow.themeChanged(checked ? "dark" : "light")
            }
        }
    }
}
