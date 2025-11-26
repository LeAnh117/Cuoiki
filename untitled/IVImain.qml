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

    property int unreadMessageCount: 0

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
        visible: true
        color: "#000000"

        // Nền gradient đẹp
        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0A0A0A" }
                GradientStop { position: 1.0; color: "#1A1A1A" }
            }
        }

        // Vầng sáng lan rộng (glow)
        Rectangle {
            id: glow
            width: 300
            height: 300
            radius: 200
            color: "#00FFAA"
            opacity: 0.0
            anchors.centerIn: parent

            SequentialAnimation {
                running: true

                // Lan sáng nhẹ
                NumberAnimation { target: glow; property: "opacity"; from: 0.0; to: 0.25; duration: 2500; easing.type: Easing.InOutQuad }
                NumberAnimation { target: glow; property: "opacity"; from: 0.25; to: 0.0; duration: 2500; easing.type: Easing.InOutQuad }
            }
        }

        // Logo zoom-in + fade-in + fade-out
        Image {
            id: logo
            source: "qrc:/imgIVI/car.svg"
            anchors.centerIn: parent
            width: 130
            height: 130
            opacity: 0.0
            scale: 0.7
            smooth: true
            antialiasing: true

            SequentialAnimation {
                id: logoAnim

                // Zoom in + fade in
                ParallelAnimation {
                    NumberAnimation { target: logo; property: "opacity"; from: 0.0; to: 1.0; duration: 2500; easing.type: Easing.OutCubic }
                    NumberAnimation { target: logo; property: "scale"; from: 0.7; to: 1.0; duration: 2500; easing.type: Easing.OutBack }
                }

                PauseAnimation { duration: 800 }

                // Fade out + zoom out nhẹ
                ParallelAnimation {
                    NumberAnimation { target: logo; property: "opacity"; from: 1.0; to: 0.0; duration: 2000; easing.type: Easing.InCubic }
                    NumberAnimation { target: logo; property: "scale"; from: 1.0; to: 1.2; duration: 2000; easing.type: Easing.InOutQuad }
                }

                onStopped: {
                    splashScreen.visible = false
                    mainScreen.visible = true
                }
            }

            Component.onCompleted: logoAnim.start()
        }
    }

    // --- Màn hình chính (ẩn ban đầu) ---
    Rectangle {
        id: mainScreen
        anchors.fill: parent
        visible: false

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

                        Rectangle {
                            id: messageBadge
                            visible: name === "Tin nhắn" && root.unreadMessageCount > 0
                            width: 24
                            height: 24
                            radius: 12
                            color: "red"
                            border.color: "white"
                            border.width: 2
                            anchors.top: iconContainer.top
                            anchors.right: iconContainer.right
                            anchors.margins: -5

                            Text {
                                anchors.centerIn: parent
                                text: root.unreadMessageCount
                                color: "white"
                                font.bold: true
                                font.pixelSize: 14
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
                                case "Settings":
                                    settingsWin.visible = true
                                    break
                                case "Ngôn ngữ":
                                case "Language":
                                    languageDialog.open()
                                    break
                                case "Cuộc gọi":
                                case "Calls":
                                    incomingCall.visible = true
                                    break
                                case "Tin nhắn":
                                case "Messages":
                                    unreadMessageCount = 0      // reset badge khi mở
                                    messagePage.visible = true  // mở màn hình tin nhắn
                                    break
                                case "Thời tiết":
                                case "Weather":
                                    root.unreadMessageCount++
                                    messageModel.append({
                                        sender: "ESP32",
                                        content: "Tin nhắn test " + root.unreadMessageCount
                                    })
                                    break
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
            ListElement { name: "Cuộc gọi"; iconD: "qrc:/imgIVI/call_D.svg"; iconL: "qrc:/imgIVI/call_L.svg" }
            ListElement { name: "Tin nhắn"; iconD: "qrc:/imgIVI/message_D.svg"; iconL: "qrc:/imgIVI/message_L.svg" }
            ListElement { name: "Âm nhạc"; iconD: "qrc:/imgIVI/music_D.svg"; iconL: "qrc:/imgIVI/music_L.svg" }
            ListElement { name: "Bản đồ"; iconD: "qrc:/imgIVI/map_D.svg"; iconL: "qrc:/imgIVI/map_L.svg" }
            ListElement { name: "Thời tiết"; iconD: "qrc:/imgIVI/weather_D.svg"; iconL: "qrc:/imgIVI/weather_L.svg" }
        }

        // --- Model tin nhắn ---
        ListModel {
            id: messageModel
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
            onLanguageSelected: (lang) => loadLanguage(lang)
        }

        IncomingCallScreen {
            id: incomingCall
            visible: false

            onAcceptCall: {
                visible = false
                activeCall.startCall(callerName)
            }
            onRejectCall: {
                visible = false
                mainScreen.visible = true
            }
        }

        ActiveCallScreen {
            id: activeCall
            visible: false
            onEndCall: {
                visible = false
                mainScreen.visible = true
            }
        }

        // KẾT NỐI VỚI SerialHandler từ C++
        Connections {
            target: serialHandler
            //cuoc goi den
            function onIncomingCall(callerName) {
                console.log("📞 Cuộc gọi đến từ:", callerName)
                incomingCall.callerName = callerName
                incomingCall.visible = true
            }
            function onEndCall() {
                console.log("📴 Kết thúc cuộc gọi từ ESP32")
                incomingCall.visible = false
                activeCall.visible = false
                mainScreen.visible = true
            }
            //tin nhan den
            function onMessageReceived(sender, content) {
                console.log("📨 Tin nhắn đến từ ESP32:", content)

                root.unreadMessageCount++

                messageModel.append({
                    sender: sender,
                    content: content
                })
            }
        }

        MessagePage {
            id: messagePage
            anchors.fill: parent
            visible: false
            messageModel: messageModel

            onBackRequested: {
                messagePage.visible = false
            }
        }
    }
}
