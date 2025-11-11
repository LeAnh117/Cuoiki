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

    property string currentTheme: "light" // or "light"

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

        // --- Hình nền ---
        // Image {
        //     id: wallpaper
        //     anchors.fill: parent
        //     source: "qrc:/imgIVI/Background.jpg"  // thay bằng ảnh nền thật
        //     fillMode: Image.PreserveAspectCrop
        // }
        Rectangle {
            id: background
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0A0A0A" }   // đen sâu
                GradientStop { position: 1.0; color: "#1F1F1F" }   // xám đậm
            }
        }
        // Ánh sáng neon mờ trung tâm
        Rectangle {
            id: neonGlow
            width: parent.width * 0.9
            height: parent.height * 0.9
            anchors.centerIn: parent
            radius: width / 2
            color: "#38FF14"   // neon xanh lá
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
                        border.color: Theme.neon
                        border.width: 2

                        Image {
                            anchors.centerIn: parent
                            source: icon
                            width: parent.width
                            height: parent.height
                            z: -1
                            // color: currentTheme === "light" ? "black" : "white"
                            fillMode: Image.PreserveAspectFit

                            // Đổi màu icon theo theme
                            layer.enabled: true
                            layer.samplerName: "source"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: iconContainer.border.color = Theme.textDark
                            onReleased: iconContainer.border.color = Theme.neon
                            onClicked: console.log("Clicked on " + name)
                        }
                    }

                    Text {
                        text: name
                        color: "white"
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
            ListElement { name: "Cài đặt"; icon: "qrc:/imgIVI/setting.svg" }
            ListElement { name: "Ngôn ngữ"; icon: "qrc:/imgIVI/setting.svg" }
            ListElement { name: "Cuộc gọi"; icon: "qrc:/imgIVI/setting.svg" }
            ListElement { name: "Tin nhắn"; icon: "qrc:/imgIVI/setting.svg" }
            ListElement { name: "Chế độ lái"; icon: "qrc:/imgIVI/setting.svg" }
            ListElement { name: "Âm nhạc"; icon: "qrc:/imgIVI/setting.svg" }
            ListElement { name: "Bản đồ"; icon: "qrc:/imgIVI/setting.svg" }
            ListElement { name: "Thời tiết"; icon: "qrc:/imgIVI/setting.svg" }
        }
    }



}
