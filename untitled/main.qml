import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root
    width: 800
    height: 480
    visible: true
    color: "#000000"
    title: qsTr("Dashboard Demo")

    // ====== STATES ======
    property bool blink1:  false
    property bool blink2:  false
    property bool blink3:  false
    property bool blink4:  false
    property bool blink5:  false
    property bool blink6:  false
    property bool blink7:  false
    property bool blink8:  false
    property bool blink9:  false
    property bool blink10: false

    // ====== DRIVE MODE ======
    // 0 = bth, 1 = sport, 2 = eco
    property int driveMode: 0
    property url baseSrc:     driveMode === 0 ? "qrc:/icons/Base.svg"
                          : driveMode === 1 ? "qrc:/icons/Base1.png"
                                            : "qrc:/icons/Base2.png"
    property url ellipseSrc:  driveMode === 0 ? "qrc:/img/Ellipse.svg"
                          : driveMode === 1 ? "qrc:/img/Ellipse1.png"
                                            : "qrc:/img/Ellipse2.png"
    property url subtractSrc: driveMode === 0 ? "qrc:/img/Subtract.svg"
                          : driveMode === 1 ? "qrc:/img/Subtract1.png"
                                            : "qrc:/img/Subtract2.png"

    // ====== ICON SRC THEO DRIVE MODE ======
    property url canhbao1Src: driveMode === 0 ? "qrc:/img/canhbao1.png"
                              : driveMode === 1 ? "qrc:/img/canhbao1.1.png"
                                                : "qrc:/img/canhbao1.2.png"

    property url canhbao2Src: driveMode === 0 ? "qrc:/img/canhbao2.png"
                              : driveMode === 1 ? "qrc:/img/canhbao2.1.png"
                                                : "qrc:/img/canhbao2.2.png"

    property url canhbao3Src: driveMode === 0 ? "qrc:/img/canhbao3.png"
                              : driveMode === 1 ? "qrc:/img/canhbao3.1.png"
                                                : "qrc:/img/canhbao3.2.png"

    property url canhbao5Src: driveMode === 0 ? "qrc:/img/canhbao5.png"
                              : driveMode === 1 ? "qrc:/img/canhbao5.1.png"
                                                : "qrc:/img/canhbao5.2.png"

    property url canhbao6Src: driveMode === 0 ? "qrc:/img/canhbao6.png"
                              : driveMode === 1 ? "qrc:/img/canhbao6.1.png"
                                                : "qrc:/img/canhbao6.2.png"

    property url canhbao10Src: driveMode === 0 ? "qrc:/img/canhbao10.png"
                               : driveMode === 1 ? "qrc:/img/canhbao10.1.png"
                                                 : "qrc:/img/canhbao10.2.png"

    // ====== ODO/TRIP/AVG (tính đúng vật lý) ======
    property real  odoKm: 0.0
    property real  tripKm: 0.0
    property bool  tripRunning: false
    property real  tripElapsedMs: 0.0
    property double _lastTickMs: Date.now()

    // ====== SERIAL HANDLER (C++ – dùng instance chung từ C++) ======
    Connections {
        target: serialHandler

        function onButtonEvent(label) {
            console.log("BTN event:", label)
            if      (label === "BTN1")  blink1  = !blink1
            else if (label === "BTN2")  blink2  = !blink2
            else if (label === "BTN3")  blink3  = !blink3
            else if (label === "BTN4")  blink4  = !blink4
            else if (label === "BTN5")  blink5  = !blink5
            else if (label === "BTN6")  blink6  = !blink6
            else if (label === "BTN7")  blink7  = !blink7
            else if (label === "BTN8")  blink8  = !blink8
            else if (label === "BTN9")  blink9  = !blink9
            else if (label === "BTN10") blink10 = !blink10
        }

        function onStatus(text) {
            console.log("[Serial]", text)
        }
    }

    // --- Debug Serial ---
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 12
        color: "white"
        text: "Serial: " + serialHandler.message
              + " | SPD1=" + Math.round(serialHandler.speed1)
              + " SPD2=" + Math.round(serialHandler.speed2)
              + " TEMP=" + serialHandler.speed3.toFixed(1) + "°C"
              + " SPD4=" + Math.round(serialHandler.speed4)
        font.pixelSize: 14
        z: 100
    }

    // --- Background ---
    Image {
        id: background
        source: "qrc:/icons/Background.png"
        anchors.centerIn: parent
        fillMode: Image.Stretch
        smooth: true
    }

    // --- Base frame ---
    Image {
        id: baseImage
        source: baseSrc
        anchors.centerIn: parent
        width: parent.width * 0.9
        height: parent.height * 0.9
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }

    Image {
        id: tophead
        source: "qrc:/icons/Top Navigation.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(40, 40)
        anchors.verticalCenterOffset: -125
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }

    // ============= TRANG TRÍ XE & XĂNG ============

    Image { id: xemini;  source: "qrc:/img/Model 3.png"
        anchors.centerIn: parent; sourceSize: Qt.size(35,35)
        anchors.verticalCenterOffset: -20; anchors.horizontalCenterOffset: 0
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1 }

    Image { id: xe;  source: "qrc:/icons/Car.svg"
        anchors.centerIn: parent; sourceSize: Qt.size(55,55)
        anchors.verticalCenterOffset: 85; anchors.horizontalCenterOffset: 0
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1 }

    Image { id: canhtrai;  source: "qrc:/icons/Vector 1.svg"
        anchors.centerIn: parent; sourceSize: Qt.size(70,40)
        anchors.verticalCenterOffset: 20; anchors.horizontalCenterOffset: -60
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1 }

    Image { id: canhphai;  source: "qrc:/icons/Vector 2.svg"
        anchors.centerIn: parent; sourceSize: Qt.size(70,40)
        anchors.verticalCenterOffset: 20; anchors.horizontalCenterOffset: 60
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1 }

    Image { id: pha;  source: "qrc:/icons/Headlights.svg"
        anchors.centerIn: parent; sourceSize: Qt.size(50,50)
        anchors.verticalCenterOffset: 55; anchors.horizontalCenterOffset: 0
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 0 }

    Image { id: canhbao;  source: "qrc:/img/xang.png"
        anchors.centerIn: parent; sourceSize: Qt.size(70,70)
        anchors.verticalCenterOffset: 120; anchors.horizontalCenterOffset: -250
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1 }

    // ====== ICONS HÀNG TRÊN ======
    Image {
        id: canhbao1
        source: canhbao5Src
        anchors.centerIn: parent; sourceSize: Qt.size(17,17)
        anchors.verticalCenterOffset: -120; anchors.horizontalCenterOffset: -120
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1
        SequentialAnimation on opacity {
            running: blink1; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao1.opacity = 1.0
        }
    }

    Image {
        id: canhbao2
        source: "qrc:/img/canhbao4"
        anchors.centerIn: parent; sourceSize: Qt.size(17,17)
        anchors.verticalCenterOffset: -125; anchors.horizontalCenterOffset: -150
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1
        SequentialAnimation on opacity {
            running: blink2; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao2.opacity = 1.0
        }
    }

    Image {
        id: canhbao3
        source: canhbao3Src
        anchors.centerIn: parent; sourceSize: Qt.size(17,17)
        anchors.verticalCenterOffset: -130; anchors.horizontalCenterOffset: -180
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1
        SequentialAnimation on opacity {
            running: blink3; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao3.opacity = 1.0
        }
    }

    Image {
        id: canhbao4
        source: canhbao2Src
        anchors.centerIn: parent; sourceSize: Qt.size(17,17)
        anchors.verticalCenterOffset: -135; anchors.horizontalCenterOffset: -210
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1
        SequentialAnimation on opacity {
            running: blink4; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao4.opacity = 1.0
        }
    }

    Image {
        id: canhbao5
        source: canhbao1Src
        anchors.centerIn: parent; sourceSize: Qt.size(17,17)
        anchors.verticalCenterOffset: -140; anchors.horizontalCenterOffset: -240
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1
        SequentialAnimation on opacity {
            running: blink5; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao5.opacity = 1.0
        }
    }

    Image {
        id: canhbao6
        source: canhbao6Src
        anchors.centerIn: parent; sourceSize: Qt.size(17,17)
        anchors.verticalCenterOffset: -120; anchors.horizontalCenterOffset: 120
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1
        SequentialAnimation on opacity {
            running: blink6; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao6.opacity = 1.0
        }
    }

    Image {
        id: canhbao7
        source: "qrc:/img/mdi_seatbelt.svg"
        anchors.centerIn: parent; sourceSize: Qt.size(17,17)
        anchors.verticalCenterOffset: -125; anchors.horizontalCenterOffset: 150
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1
        SequentialAnimation on opacity {
            running: blink7; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao7.opacity = 1.0
        }
    }

    Image {
        id: canhbao8
        source: "qrc:/img/mdi_car-light-dimmed.svg"
        anchors.centerIn: parent; sourceSize: Qt.size(17,17)
        anchors.verticalCenterOffset: -130; anchors.horizontalCenterOffset: 180
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1
        SequentialAnimation on opacity {
            running: blink8; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao8.opacity = 1.0
        }
    }

    Image {
        id: canhbao9
        source: "qrc:/img/mdi_car-light-fog.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(17,17)
        anchors.verticalCenterOffset: -135
        anchors.horizontalCenterOffset: 210
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1

        SequentialAnimation on opacity {
            running: blink9; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao9.opacity = 1.0
        }
    }

    Image {
        id: canhbao10
        source: canhbao10Src
        anchors.centerIn: parent; sourceSize: Qt.size(13,13)
        anchors.verticalCenterOffset: -140; anchors.horizontalCenterOffset: 240
        fillMode: Image.PreserveAspectFit; smooth: true; mipmap: true; z: 1
        SequentialAnimation on opacity {
            running: blink10; loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 0.2; duration: 250 }
            NumberAnimation { from: 0.2; to: 1.0; duration: 250 }
            onRunningChanged: if (!running) canhbao10.opacity = 1.0
        }
    }

    // ====== GIÁ TRỊ TỪ ESP ======
    // SPD1: 0..100 -> 0..220 km/h
    property real speedValue: (serialHandler.speed1 > 0
                               ? (serialHandler.speed1 / 100.0) * 220.0
                               : 0)

    // SPD2: 0..100 -> 0..8 kRPM
    property real rpmValue: (serialHandler.speed2 > 0
                             ? (serialHandler.speed2 / 100.0) * 8.0
                             : 0)

    // SPD3: nhiệt độ (°C)
    property real tempC: serialHandler.speed3

    // SPD4: 0..100 -> góc kim xăng phải
    property real fuelRightAngle: (serialHandler.speed4 > 0
                                   ? (44 + (serialHandler.speed4 / 100.0) * 91.0)
                                   : 44)

    // Kim trái: map nhiệt độ 0..60°C -> -10..-170°
    property real fuelLeftAngle: {
        var t = Math.max(0, Math.min(tempC, 60))
        return -10 - (t / 60.0) * 160.0
    }

    // =========================================================
    //  CỤM ĐỒNG HỒ TRÁI (SPEED Gauge)
    // =========================================================
    Item {
        id: clusterGroupLeft
        width: 150; height: 150
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -200
        z: 2

        Item {
            id: gaugeLeft
            anchors.centerIn: parent
            width: 150; height: 150; z: 2

            Item {
                id: needleLayerLeft
                anchors.centerIn: parent
                width: parent.width; height: parent.height; z: 0

                Image {
                    id: needleLeft
                    source: "qrc:/img/Rectangle 4.svg"
                    width: 10; height: 70
                    smooth: true
                    fillMode: Image.PreserveAspectFit
                    transformOrigin: Item.Bottom
                    rotation: angleSliderLeft.value
                    x: (parent.width - width) / 2
                    y: parent.height / 2 - height
                }
            }

            Image { id: ellipse1Left; anchors.centerIn: parent
                source: ellipseSrc; sourceSize: Qt.size(170,170)
                smooth: true; z: 1 }

            Image { id: ellipse2Left; anchors.centerIn: parent
                source: "qrc:/img/ring.svg"; sourceSize: Qt.size(120,120)
                smooth: true; z: 1 }

            Image {
                id: subtractLeft
                anchors.centerIn: parent
                source: subtractSrc
                sourceSize: Qt.size(100, 100)
                smooth: true; z: 3

                Image {
                    id: ellipse6Left
                    anchors.centerIn: parent
                    source: "qrc:/img/Ellipse 6.svg"
                    sourceSize: Qt.size(70, 70)
                    smooth: true; z: 4

                    Column {
                        anchors.centerIn: parent; spacing: 0
                        Text {
                            id: speedText
                            text: Math.round(speedValue)
                            color: "white"
                            font.pixelSize: 48
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                            text: "km/h"
                            color: "#AAAAAA"
                            font.pixelSize:10
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }

    // =========================================================
    //  CỤM ĐỒNG HỒ PHẢI (RPM Gauge)
    // =========================================================
    Item {
        id: clusterGroupRight
        width: 150; height: 150
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 200
        z: 2

        Item {
            id: gaugeRight
            anchors.centerIn: parent; width: 150; height: 150; z: 2

            Item {
                id: needleLayerRight
                anchors.centerIn: parent; width: parent.width; height: parent.height; z: 0

                Image {
                    id: needleRight
                    source: "qrc:/img/Rectangle 4.svg"
                    width: 10; height: 70
                    smooth: true
                    fillMode: Image.PreserveAspectFit
                    transformOrigin: Item.Bottom
                    rotation: angleSliderRight.value
                    x: (parent.width - width) / 2
                    y: parent.height / 2 - height
                }
            }

            Image { id: ellipse1Right; anchors.centerIn: parent
                source: ellipseSrc; sourceSize: Qt.size(170,170)
                smooth: true; z: 1 }

            Image { id: ellipse2Right; anchors.centerIn: parent
                source: "qrc:/img/ring.svg"; sourceSize: Qt.size(120,120)
                smooth: true; z: 1 }

            Image {
                id: subtractRight
                anchors.centerIn: parent
                source: subtractSrc
                sourceSize: Qt.size(100, 100)
                smooth: true; z: 3

                Image {
                    id: ellipse6Right
                    anchors.centerIn: parent
                    source: "qrc:/img/Ellipse 6.svg"
                    sourceSize: Qt.size(70, 70)
                    smooth: true; z: 4

                    Column {
                        anchors.centerIn: parent; spacing: 0
                        Text {
                            id: rpmText
                            text: (rpmValue * 1000).toFixed(0)
                            color: "white"
                            font.pixelSize: 48
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                            text: "RPM"
                            color: "#AAAAAA"
                            font.pixelSize: 10
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }

    // ====== HAI KIM XĂNG (kim trái = nhiệt độ, kim phải = xăng) ======
    Item {
        id: fuelNeedles
        width: canhbao.width
        height: canhbao.height
        anchors.centerIn: canhbao
        z: canhbao.z + 1

        Rectangle {
            id: needleLeftFuel
            width: 4
            height: Math.min(parent.width, parent.height) * 0.4
            radius: 2
            color: "#E8EBE0"
            antialiasing: true
            transformOrigin: Item.Bottom
            rotation: fuelLeftAngle     // nhiệt độ từ DHT22
            x: (parent.width - width) / 2
            y: parent.height/2 - height
        }

        Rectangle {
            id: needleRightFuel
            width: 4
            height: Math.min(parent.width, parent.height) * 0.38
            radius: 2
            color: "#E8EBE0"
            antialiasing: true
            transformOrigin: Item.Bottom
            rotation: fuelRightAngle    // xăng (SPD4)
            x: (parent.width - width) / 2
            y: parent.height/2 - height
        }
    }

    // ===== AVG =====
    Item {
        id: avgOverlay
        anchors.bottom: tophead.top
        anchors.bottomMargin: -20
        anchors.horizontalCenter: tophead.horizontalCenter
        anchors.horizontalCenterOffset: -40
        z: 50
        Text {
            id: avgText
            readonly property real avgKmh: (tripElapsedMs > 0)
                                            ? (tripKm / (tripElapsedMs / 3600000.0))
                                            : 0
            text: "AVG: " + avgKmh.toFixed(1) + " km/h"
            color: "white"
            font.pixelSize: 12
        }
    }

    // ===== ODO / TRIP =====
    Item {
        id: metricsOverlay
        anchors.top: tophead.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: tophead.horizontalCenter
        z: 50

        property color lime: "#b7fca1"

        Column {
            spacing: 8
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                spacing: 28
                anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    spacing: 10
                    Text {
                        text: "ODO: " + odoKm.toFixed(1) + " km"
                        color: "white"
                        font.pixelSize: 12
                    }
                    Button {
                        id: odoResetBtn
                        width: 40
                        height: 18
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 10

                        text: "Reset"
                        focusPolicy: Qt.NoFocus
                        contentItem: Text {
                            text: odoResetBtn.text
                            color: "black"
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }
                        background: Rectangle {
                            radius: 8
                            color: metricsOverlay.lime
                            border.color: "#6fbf5f"
                        }
                        onClicked: { odoKm = 0; }
                    }
                }

                Row {
                    spacing: 6
                    Text {
                        text: "TRIP: " + tripKm.toFixed(1) + " km"
                        color: "white"
                        font.pixelSize: 12
                    }

                    Switch {
                        id: tripSwitch
                        checked: tripRunning
                        focusPolicy: Qt.NoFocus

                        indicator: Rectangle {
                            width: 42
                            height: 20
                            radius: 10
                            color: tripSwitch.checked ? "#B8FF01" : "#555555"
                            border.color: tripSwitch.checked ? "#7FB800" : "#333333"

                            Rectangle {
                                id: knob
                                width: 18
                                height: 18
                                radius: 9
                                y: 1
                                x: tripSwitch.checked ? (parent.width - width - 1) : 1
                                color: "white"
                                border.color: "#cccccc"

                                Behavior on x { NumberAnimation { duration: 120 } }
                            }
                        }

                        onCheckedChanged: {
                            tripRunning = checked
                            if (!checked) {
                                tripKm = 0
                                tripElapsedMs = 0
                            }
                        }
                    }
                }
            }
        }
    }

    // ===== NÚT CHUYỂN CHẾ ĐỘ LÁI =====
    Button {
        id: modeButton
        anchors.top: tophead.top
        anchors.topMargin: 6
        anchors.right: parent.right
        anchors.rightMargin: 16
        z: 100

        text: driveMode === 0 ? "Mode: Bth"
             : driveMode === 1 ? "Mode: Sport"
                               : "Mode: Eco"

        contentItem: Text {
            text: modeButton.text
            color: "black"
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        background: Rectangle {
            radius: 8
            color: "#b7fca1"
            border.color: "#6fbf5f"
        }
        onClicked: driveMode = (driveMode + 1) % 3
    }

    // =========================================================
    //  PHYSICS TIMER
    // =========================================================
    Timer {
        id: physicsTimer
        interval: 100
        repeat: true
        running: true
        onTriggered: {
            const now = Date.now()
            const dtMs = now - _lastTickMs
            _lastTickMs = now

            const vKmh = speedValue
            const deltaKm = vKmh * (dtMs / 3600000.0)

            odoKm += deltaKm
            if (tripRunning) {
                tripKm += deltaKm
                tripElapsedMs += dtMs
            }
        }
    }

    // =========================================================
    //  ÁNH XẠ GÓC KIM SPEED/RPM
    // =========================================================
    Binding {
        target: angleSliderLeft
        property: "value"
        value: (speedValue / 220.0) * 310.0 - 155.0
    }
    Binding {
        target: angleSliderRight
        property: "value"
        value: (rpmValue / 8.0) * 310.0 - 155.0
    }

    // Slider ẩn để tái dùng công thức xoay kim
    Slider { id: angleSliderLeft;  visible: false; from: -155; to: 155; value: 0 }
    Slider { id: angleSliderRight; visible: false; from: -155; to: 155; value: 0 }
}
