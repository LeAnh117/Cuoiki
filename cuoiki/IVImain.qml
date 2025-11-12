import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import QtQuick.Layouts 1.15
import "." 1.0

Window {
    id: root
    width: 500
    height: 700
    x: 900
    visible: true
    title: "IVI HMI"

    property string currentTheme: "dark" // or "light"

    // --- Ngôn ngữ hiện tại ---
    property string currentLanguage: "vi"  // default

    // --- Dictionary bản dịch ---
    property var dict: {
        "vi": {
            "Cài đặt": "Cài đặt",
            "Ngôn ngữ": "Ngôn ngữ",
            "Cuộc gọi": "Cuộc gọi",
            "Tin nhắn": "Tin nhắn",
            "Âm nhạc": "Âm nhạc",
            "Bản đồ": "Bản đồ",
            "Thời tiết": "Thời tiết"
        },
        "en": {
            "Cài đặt": "Settings",
            "Ngôn ngữ": "Language",
            "Cuộc gọi": "Calls",
            "Tin nhắn": "Messages",
            "Âm nhạc": "Music",
            "Bản đồ": "Maps",
            "Thời tiết": "Weather"
        }
    }

    // --- Hàm dịch ---
    function tr(key) {
        if(dict[currentLanguage] && dict[currentLanguage][key])
            return dict[currentLanguage][key]
        return key
    }
    function loadLanguage(lang) {
        currentLanguage = lang
        console.log("Language changed to:", lang)
    }



    // --- Màn hình khởi động ---
    Rectangle {
        id: splashScreen
        anchors.fill: parent
        color: "#4D4D4D"
        visible: true

        Rectangle {
            id: logoContainer
            anchors.centerIn: parent
            width: 100
            height: 100
            radius: 15
            clip: true
            Image {
                id: logo
                source: "qrc:/imgIVI/startLogo.jpeg"    // Thay đường dẫn bằng logo của bạn
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                opacity: 0.0

                SequentialAnimation {
                    id: fadeAnim
                    NumberAnimation { target: logo; property: "opacity"; from: 0.0; to: 1.0; duration: 2000; easing.type: Easing.InOutQuad }
                    PauseAnimation { duration: 1000 }
                    NumberAnimation { target: logo; property: "opacity"; from: 1.0; to: 0.0; duration: 2000; easing.type: Easing.InOutQuad }

                    onStopped: {
                        splashScreen.visible = false
                        mainScreen.visible = true
                    }
                }

                Component.onCompleted: fadeAnim.start()
            }
        }
    }

    // --- Màn hình chính (ẩn ban đầu) ---
    Rectangle {
        id: mainScreen
        anchors.fill: parent
        visible: false
        // color: currentTheme === "dark" ? "#121212" : "#EDEDED"

        Rectangle {
            id: background
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: root.currentTheme === "dark" ? Theme.bgDark : Theme.bgLight }
                GradientStop { position: 1.0; color: root.currentTheme === "dark" ? Theme.bgDark : Theme.bgLight }
            }
            Behavior on gradient { ColorAnimation { duration: 500 } }
        }
        // Ánh sáng neon mờ trung tâm
        Rectangle {
            id: neonGlow
            width: parent.width * 0.9
            height: parent.height * 0.9
            anchors.centerIn: parent
            radius: width / 2
            color: Theme.neon   // neon xanh lá
            opacity: 0.08       // rất nhẹ, không gây chói
        }

        GridLayout {
            id: appGrid
            anchors.centerIn: parent
            anchors.leftMargin: 30
            anchors.rightMargin: 30
            columns: 3           // 🔹 3 cột
            rows: 3              // 🔹 3 hàng
            columnSpacing: 60
            rowSpacing: 30

            Repeater {
                model: appModel

                Item {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100

                    Rectangle {
                        id: iconContainer
                        width: 70
                        height: 70
                        radius: 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        color: "transparent"

                        property bool pressed: false

                        border.color: pressed
                                      ? Theme.textDark
                                      : (root.currentTheme === "dark" ? Theme.borderDark : Theme.borderLight)
                        border.width: 3

                        Behavior on border.color { ColorAnimation { duration: 300 } } // hiệu ứng mượt

                        Image {
                            id: iconSetting
                            anchors.centerIn: parent
                            width: parent.width / 1.2
                            height: parent.height /1.2
                            z: -1
                            fillMode: Image.PreserveAspectFit
                            source: root.currentTheme === "dark" ? iconD : iconL

                            opacity: 1.0

                            Behavior on opacity {
                                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onPressed: iconContainer.pressed = true
                            onReleased: iconContainer.pressed = false
                            onClicked: {
                                console.log("Clicked on " + root.tr(name))
                                switch(root.tr(name)) {
                                case "Cài đặt":
                                    settingsWin.visible = true
                                    break
                                case "Ngôn ngữ":
                                    languageDialog.open()
                                    break
                                case "Language":
                                    languageDialog.open()
                                    break
                                case "Cuộc gọi":

                                case "Tin nhắn":

                                }
                            }
                        }
                    }

                    Text {
                        text: root.tr(name)
                        color: root.currentTheme === "dark" ? Theme.textDark : Theme.textLight
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        anchors.top: iconContainer.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 8
                    }
                }
            }
        }

        // --- Model dữ liệu ứng dụng ---
        ListModel {
            id: appModel
            ListElement { name: "Cài đặt"; iconD: "qrc:/imgIVI/setting.svg"; iconL: "qrc:/imgIVI/settingL.svg" }
            ListElement { name: "Ngôn ngữ"; iconD: "qrc:/imgIVI/language_D1.svg"; iconL: "qrc:/imgIVI/language-L.svg" }
            ListElement { name: "Cuộc gọi"; iconD: "qrc:/imgIVI/setting.svg"; iconL: "qrc:/imgIVI/settingL.svg" }
            ListElement { name: "Tin nhắn"; iconD: "qrc:/imgIVI/setting.svg"; iconL: "qrc:/imgIVI/settingL.svg" }
            ListElement { name: "Âm nhạc"; iconD: "qrc:/imgIVI/setting.svg"; iconL: "qrc:/imgIVI/settingL.svg" }
            ListElement { name: "Bản đồ"; iconD: "qrc:/imgIVI/setting.svg"; iconL: "qrc:/imgIVI/settingL.svg" }
            ListElement { name: "Thời tiết"; iconD: "qrc:/imgIVI/setting.svg"; iconL: "qrc:/imgIVI/settingL.svg" }
        }
        // --- Gọi cửa sổ Cài đặt ---
        SettingWindow {
            id: settingsWin
            onThemeChanged: {
                root.currentTheme = newTheme
                console.log("Theme changed to:", newTheme)
            }
        }
        LanguageWindow {
            id: languageDialog
            onLanguageSelected: (lang) => loadLanguage(lang)  // <-- nhận signal và gọi hàm
        }

    }



}
