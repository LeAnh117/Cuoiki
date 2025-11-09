import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import QtQuick.Layouts 1.15

Window {
    id: root
    width: 500
    height: 700
    x: 900
    visible: true
    title: "IVI HMI"

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

                SequentialAnimation on opacity {
                    id: fadeAnim
                    NumberAnimation { from: 0.0; to: 1.0; duration: 3000; easing.type: Easing.InOutQuad }
                    PauseAnimation { duration: 500 }
                    NumberAnimation { from: 1.0; to: 0.0; duration: 3000; easing.type: Easing.InOutQuad }

                    // Khi animation xong → ẩn splash, hiện màn hình chính
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
        color: "black"

        // --- Hình nền ---
        Image {
            id: wallpaper
            anchors.fill: parent
            source: "qrc:/imgIVI/Background.jpg"  // thay bằng ảnh nền thật
            fillMode: Image.PreserveAspectCrop
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
                        radius: 20
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 10

                        Image {
                            anchors.centerIn: parent
                            source: icon
                            width: 80
                            height: 80
                            fillMode: Image.PreserveAspectFit
                        }

                        MouseArea {
                            anchors.fill: parent
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
            ListElement { name: "Cài đặt"; icon: "qrc:/imgIVI/setting-icon.jpg" }
            ListElement { name: "Ngôn ngữ"; icon: "qrc:/imgIVI/setting-icon.jpg" }
            ListElement { name: "Cuộc gọi"; icon: "qrc:/imgIVI/setting-icon.jpg" }
            ListElement { name: "Tin nhắn"; icon: "qrc:/imgIVI/setting-icon.jpg" }
            ListElement { name: "Chế độ lái"; icon: "qrc:/imgIVI/setting-icon.jpg" }
            ListElement { name: "Âm nhạc"; icon: "qrc:/imgIVI/setting-icon.jpg" }
            ListElement { name: "Bản đồ"; icon: "qrc:/imgIVI/setting-icon.jpg" }
            ListElement { name: "Thời tiết"; icon: "qrc:/imgIVI/setting-icon.jpg" }
        }
    }



}
