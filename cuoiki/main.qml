import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Effects
Window {
    id: root
    width: 1000
    height: 720
    visible: true
    color: "#000000"
    title: qsTr("Dashboard Demo")

    // --- Background ---
    Image {
        id: background
        source: "qrc:/icons/Background.png"
        anchors.centerIn: parent
        width: 1200
        height: 720
        fillMode: Image.Stretch
        smooth: true
    }

    // --- Base frame ---
    Image {
        id: baseImage
        source: "qrc:/icons/Base.svg"
        anchors.centerIn: parent
        width: parent.width * 0.9
        height: parent.height * 0.9
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }

    // Image {
    //     id: tophead
    //     source: "qrc:/icons/Top Navigation.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(50, 55)
    //     anchors.verticalCenterOffset: -180

    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }
    // Top Navigation
    Image {
        id: tophead
        source: "qrc:/icons/Top Navigation.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(50, 55)
        anchors.verticalCenterOffset: -180
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }

    // Icon Car nằm giữa Top Navigation
    Image {
        id: carIcon
        source: "qrc:/icons/Car_icon.svg"
        anchors.centerIn: tophead   // quan trọng: đặt giữa tophead
        width: 30                   // đặt kích thước phù hợp
        height: 30
        fillMode: Image.PreserveAspectFit
        smooth: true
        z: 2                        // trên tophead
    }

    // Image {
    //     id: canhbao1
    //     source: "qrc:/img/icon-park-solid_right-two.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -185
    //     anchors.horizontalCenterOffset: -150   // sang trái

    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }
    // Image {
    //     id: canhbao1
    //     source: "qrc:/img/icon-park-solid_right-two.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -185
    //     anchors.horizontalCenterOffset: -150   // sang trái

    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }


    Item {
        id: canhbao1_container
        width: 30
        height: 30
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -185
        anchors.horizontalCenterOffset: -150

        // Icon gốc
        Image {
            id: canhbao1
            source: "qrc:/img/icon-park-solid_right-two.svg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            z: 1
        }

        // Overlay đỏ
        Image {
            id: canhbao1_red
            source: "qrc:/img/icon-park-solid_right-two_green.svg"  // file SVG đỏ
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            opacity: 0
            z: 2
        }

        // Overlay vàng
        Image {
            id: canhbao1_yellow
            source: "qrc:/img/icon-park-solid_right-two_yellow.svg"  // file SVG vàng
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            opacity: 0
            z: 3
        }

        // MouseArea để nhấp nháy
        MouseArea {
            anchors.fill: parent
            onClicked: blinkPark.start()
            cursorShape: Qt.PointingHandCursor
        }

        // Animation nhấp nháy đỏ ↔ vàng
        SequentialAnimation {
            id: blinkPark
            loops: 6
            NumberAnimation { target: canhbao1_red; property: "opacity"; to: 1; duration: 200 }
            NumberAnimation { target: canhbao1_red; property: "opacity"; to: 0; duration: 200 }
            NumberAnimation { target: canhbao1_yellow; property: "opacity"; to: 1; duration: 200 }
            NumberAnimation { target: canhbao1_yellow; property: "opacity"; to: 0; duration: 200 }
        }
    }


    // Image {
    //     id: canhbao2
    //     source: "qrc:/img/mdi_car-handbrake.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -190
    //     anchors.horizontalCenterOffset: -200   // sang trái

    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }

    Item {
        id: canhbao2_container
        width: 30
        height: 30
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -190
        anchors.horizontalCenterOffset: -200

        // Icon gốc
        Image {
            id: canhbao2
            source: "qrc:/img/mdi_car-handbrake.svg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            z: 1
        }

        // Overlay đỏ
        Image {
            id: canhbao2_red
            source: "qrc:/img/mdi_car-handbrake_green.svg"  // file SVG đỏ
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            opacity: 0
            z: 2
        }

        // Overlay vàng
        Image {
            id: canhbao2_yellow
            source: "qrc:/img/mdi_car-handbrake_yellow.svg"  // file SVG vàng
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            opacity: 0
            z: 3
        }

        // MouseArea để nhấp nháy
        MouseArea {
            anchors.fill: parent
            onClicked: blinkHandbrake.start()
            cursorShape: Qt.PointingHandCursor
        }

        // Animation nhấp nháy đỏ ↔ vàng
        SequentialAnimation {
            id: blinkHandbrake
            loops: 6
            NumberAnimation { target: canhbao2_red; property: "opacity"; to: 1; duration: 200 }
            NumberAnimation { target: canhbao2_red; property: "opacity"; to: 0; duration: 200 }
            NumberAnimation { target: canhbao2_yellow; property: "opacity"; to: 1; duration: 200 }
            NumberAnimation { target: canhbao2_yellow; property: "opacity"; to: 0; duration: 200 }
        }
    }


    // Image {
    //     id: canhbao3
    //     source: "qrc:/img/ph_engine-bold.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -195
    //     anchors.horizontalCenterOffset: -250   // sang trái

    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }

    Item {
        id: canhbao3_container
        width: 30
        height: 30
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -195
        anchors.horizontalCenterOffset: -250

        // Icon gốc
        Image {
            id: canhbao3
            source: "qrc:/img/ph_engine-bold.svg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            z: 1
        }

        // Overlay đỏ
        Image {
            id: canhbao3_red
            source: "qrc:/img/ph_engine-bold_green.svg"  // file SVG đỏ
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            opacity: 0
            z: 2
        }

        // Overlay vàng
        Image {
            id: canhbao3_yellow
            source: "qrc:/img/ph_engine-bold_yellow.svg"  // file SVG vàng
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            opacity: 0
            z: 3
        }

        // MouseArea để nhấp nháy
        MouseArea {
            anchors.fill: parent
            onClicked: blinkEngine.start()
            cursorShape: Qt.PointingHandCursor
        }

        // Animation nhấp nháy đỏ ↔ vàng
        SequentialAnimation {
            id: blinkEngine
            loops: 6
            NumberAnimation { target: canhbao3_red; property: "opacity"; to: 1; duration: 200 }
            NumberAnimation { target: canhbao3_red; property: "opacity"; to: 0; duration: 200 }
            NumberAnimation { target: canhbao3_yellow; property: "opacity"; to: 1; duration: 200 }
            NumberAnimation { target: canhbao3_yellow; property: "opacity"; to: 0; duration: 200 }
        }
    }


    // Image {
    //     id: canhbao4
    //     source: "qrc:/img/mdi_oil.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -205
    //     anchors.horizontalCenterOffset: -300   // sang trái

    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }

    Item {
        id: canhbao4_container
        width: 30
        height: 30
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -205
        anchors.horizontalCenterOffset: -300

        // Icon gốc
        Image {
            id: canhbao4
            source: "qrc:/img/mdi_oil.svg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            z: 1
        }

        // Overlay đỏ
        Image {
            id: canhbao4_red
            source: "qrc:/img/mdi_oil_yellow.svg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            opacity: 0
            z: 2
        }

        // Overlay vàng
        Image {
            id: canhbao4_yellow
            source: "qrc:/img/mdi_oil_green.svg"
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            opacity: 0
            z: 3
        }

        // MouseArea
        MouseArea {
            anchors.fill: parent
            onClicked: blinkOil.start()
            cursorShape: Qt.PointingHandCursor
        }

        // Animation nhấp nháy
        SequentialAnimation {
            id: blinkOil
            loops: 6

            NumberAnimation { target: canhbao4_red; property: "opacity"; to: 1; duration: 200 }
            NumberAnimation { target: canhbao4_red; property: "opacity"; to: 0; duration: 200 }
            NumberAnimation { target: canhbao4_yellow; property: "opacity"; to: 1; duration: 200 }
            NumberAnimation { target: canhbao4_yellow; property: "opacity"; to: 0; duration: 200 }
        }
    }



    // Image {
    //     id: canhbao5
    //     source: "qrc:/img/mdi_car-battery.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -213
    //     anchors.horizontalCenterOffset: -350   // sang trái

    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }

    // Icon mặc định
    Image {
        id: canhbao5
        source: "qrc:/img/mdi_car-battery.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30,30)
        anchors.verticalCenterOffset: -213
        anchors.horizontalCenterOffset: -350
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1

        MouseArea {
            anchors.fill: parent
            onClicked: blinkBattery.start()
            cursorShape: Qt.PointingHandCursor
        }
    }

    // Icon đỏ (overlay)
    Image {
        id: canhbao5_red
        source: "qrc:/img/mdi_car-battery-red.svg"
        anchors.centerIn: canhbao5
        sourceSize: canhbao5.sourceSize
        opacity: 0
        z: 2
    }

    // Icon vàng (overlay)
    Image {
        id: canhbao5_yellow
        source: "qrc:/img/mdi_car-battery-yellow.svg"
        anchors.centerIn: canhbao5
        sourceSize: canhbao5.sourceSize
        opacity: 0
        z: 3
    }

    // Animation nhấp nháy đỏ ↔ vàng
    SequentialAnimation {
        id: blinkBattery
        loops: 6

        NumberAnimation { target: canhbao5_red; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao5_red; property: "opacity"; to: 0; duration: 200 }

        NumberAnimation { target: canhbao5_yellow; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao5_yellow; property: "opacity"; to: 0; duration: 200 }
    }

    // Image {
    //     id: canhbao6
    //     source: "qrc:/img/icon-park-solid_right.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -185
    //     anchors.horizontalCenterOffset: 150
    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }

    // Icon gốc
    Image {
        id: canhbao6
        source: "qrc:/img/icon-park-solid_right.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -185
        anchors.horizontalCenterOffset: 150
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1

        // MouseArea trực tiếp để click nhấp nháy
        MouseArea {
            anchors.fill: parent
            onClicked: blinkBattery1.start()
            cursorShape: Qt.PointingHandCursor
        }
    }

    // Icon overlay đỏ
    Image {
        id: canhbao6_red
        source: "qrc:/img/icon-park-solid_right_red.svg" // tạo file màu đỏ
        anchors.centerIn: canhbao6
        sourceSize: canhbao6.sourceSize
        opacity: 0
        z: 2
    }

    // Icon overlay vàng
    Image {
        id: canhbao6_yellow
        source: "qrc:/img/icon-park-solid_right_yellow.svg" // tạo file màu vàng
        anchors.centerIn: canhbao6
        sourceSize: canhbao6.sourceSize
        opacity: 0
        z: 3
    }

    // Animation nhấp nháy đỏ ↔ vàng
    SequentialAnimation {
        id: blinkBattery1
        loops: 6 // số lần nhấp nháy

        // đỏ
        NumberAnimation { target: canhbao6_red; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao6_red; property: "opacity"; to: 0; duration: 200 }

        // vàng
        NumberAnimation { target: canhbao6_yellow; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao6_yellow; property: "opacity"; to: 0; duration: 200 }
    }


    // Image {
    //     id: canhbao7
    //     source: "qrc:/img/mdi_seatbelt.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -190
    //     anchors.horizontalCenterOffset: 200   // sang trái
    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }

    // Icon gốc
    Image {
        id: canhbao7
        source: "qrc:/img/mdi_seatbelt.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -190
        anchors.horizontalCenterOffset: 200
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1

        MouseArea {
            anchors.fill: parent
            onClicked: blinkSeatbelt2.start()
            cursorShape: Qt.PointingHandCursor
        }
    }

    // Overlay đỏ
    Image {
        id: canhbao7_red
        source: "qrc:/img/mdi_seatbelt_green.svg"  // file SVG đỏ
        anchors.centerIn: canhbao7
        sourceSize: canhbao7.sourceSize
        opacity: 0
        z: 2
    }

    // Overlay vàng
    Image {
        id: canhbao7_yellow
        source: "qrc:/img/mdi_seatbelt_yellow.svg"  // file SVG vàng
        anchors.centerIn: canhbao7
        sourceSize: canhbao7.sourceSize
        opacity: 0
        z: 3
    }

    // Animation nhấp nháy đỏ ↔ vàng
    SequentialAnimation {
        id: blinkSeatbelt2
        loops: 6  // số lần nhấp nháy

        // đỏ
        NumberAnimation { target: canhbao7_red; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao7_red; property: "opacity"; to: 0; duration: 200 }

        // vàng
        NumberAnimation { target: canhbao7_yellow; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao7_yellow; property: "opacity"; to: 0; duration: 200 }
    }


    // Image {
    //     id: canhbao8
    //     source: "qrc:/img/mdi_car-light-dimmed.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -195
    //     anchors.horizontalCenterOffset: 250   // sang trái

    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }

    // Icon gốc
    Image {
        id: canhbao8
        source: "qrc:/img/mdi_car-light-dimmed.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -195
        anchors.horizontalCenterOffset: 250
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1

        MouseArea {
            anchors.fill: parent
            onClicked: blinkCarLight.start()
            cursorShape: Qt.PointingHandCursor
        }
    }

    // Overlay đỏ
    Image {
        id: canhbao8_red
        source: "qrc:/img/mdi_car-light-dimmed.svg"  // file SVG đỏ
        anchors.centerIn: canhbao8
        sourceSize: canhbao8.sourceSize
        opacity: 0
        z: 2
    }

    // Overlay vàng
    Image {
        id: canhbao8_yellow
        source: "qrc:/img/mdi_car-light-dimmed_yellow.svg"  // file SVG vàng
        anchors.centerIn: canhbao8
        sourceSize: canhbao8.sourceSize
        opacity: 0
        z: 3
    }

    // Animation nhấp nháy đỏ ↔ vàng
    SequentialAnimation {
        id: blinkCarLight
        loops: 6  // số lần nhấp nháy

        // đỏ
        NumberAnimation { target: canhbao8_red; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao8_red; property: "opacity"; to: 0; duration: 200 }

        // vàng
        NumberAnimation { target: canhbao8_yellow; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao8_yellow; property: "opacity"; to: 0; duration: 200 }
    }

    // Image {
    //     id: canhbao9
    //     source: "qrc:/img/mdi_car-light-fog.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -205
    //     anchors.horizontalCenterOffset: 300   // sang trái
    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }

    // Icon gốc
    Image {
        id: canhbao9
        source: "qrc:/img/mdi_car-light-fog.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -205
        anchors.horizontalCenterOffset: 300
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1

        MouseArea {
            anchors.fill: parent
            onClicked: blinkFogLight.start()
            cursorShape: Qt.PointingHandCursor
        }
    }

    // Overlay đỏ
    Image {
        id: canhbao9_red
        source: "qrc:/img/mdi_car-light-fog_red.svg"  // file SVG màu đỏ
        anchors.centerIn: canhbao9
        sourceSize: canhbao9.sourceSize
        opacity: 0
        z: 2
    }

    // Overlay vàng
    Image {
        id: canhbao9_yellow
        source: "qrc:/img/mdi_car-light-fog.svg"  // file SVG màu vàng
        anchors.centerIn: canhbao9
        sourceSize: canhbao9.sourceSize
        opacity: 0
        z: 3
    }

    // Animation nhấp nháy đỏ ↔ vàng
    SequentialAnimation {
        id: blinkFogLight
        loops: 6  // số lần nhấp nháy

        // đỏ
        NumberAnimation { target: canhbao9_red; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao9_red; property: "opacity"; to: 0; duration: 200 }

        // vàng
        NumberAnimation { target: canhbao9_yellow; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao9_yellow; property: "opacity"; to: 0; duration: 200 }
    }



    // Image {
    //     id: canhbao10
    //     source: "qrc:/img/mdi_car-light-high.svg"
    //     anchors.centerIn: parent
    //     sourceSize: Qt.size(30, 30)
    //     anchors.verticalCenterOffset: -213
    //     anchors.horizontalCenterOffset: 350   // sang trái
    //     fillMode: Image.PreserveAspectFit
    //     smooth: true
    //     mipmap: true
    //     z: 1
    // }

    // Icon gốc
    Image {
        id: canhbao10
        source: "qrc:/img/mdi_car-light-high.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -213
        anchors.horizontalCenterOffset: 350
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1

        MouseArea {
            anchors.fill: parent
            onClicked: blinkHighLight.start()
            cursorShape: Qt.PointingHandCursor
        }
    }

    // Overlay đỏ
    Image {
        id: canhbao10_red
        source: "qrc:/img/mdi_car-light-high_red.svg"  // file SVG màu đỏ
        anchors.centerIn: canhbao10
        sourceSize: canhbao10.sourceSize
        opacity: 0
        z: 2
    }

    // Overlay vàng
    Image {
        id: canhbao10_yellow
        source: "qrc:/img/mdi_car-light-high_green.svg"  // file SVG màu vàng
        anchors.centerIn: canhbao10
        sourceSize: canhbao10.sourceSize
        opacity: 0
        z: 3
    }

    // Animation nhấp nháy đỏ ↔ vàng
    SequentialAnimation {
        id: blinkHighLight
        loops: 6  // số lần nhấp nháy

        // đỏ
        NumberAnimation { target: canhbao10_red; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao10_red; property: "opacity"; to: 0; duration: 200 }

        // vàng
        NumberAnimation { target: canhbao10_yellow; property: "opacity"; to: 1; duration: 200 }
        NumberAnimation { target: canhbao10_yellow; property: "opacity"; to: 0; duration: 200 }
    }


    // =========================================================
    //  CỤM ĐỒNG HỒ TRÁI (Speed Gauge)
    // =========================================================
    Item {
        id: clusterGroupLeft
        width: 250
        height: 250
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -300   // sang trái
        anchors.verticalCenterOffset: 0
        z: 2

        Item {
            id: gaugeLeft
            anchors.centerIn: parent
            width: 250
            height: 250
            z: 2

            // --- KIM ---
            Item {
                id: needleLayerLeft
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                z: 0

                Image {
                    id: needleLeft
                    source: "qrc:/img/Rectangle 4.svg"
                    width: 10
                    height: 110
                    smooth: true
                    fillMode: Image.PreserveAspectFit
                    transformOrigin: Item.Bottom
                    rotation: angleSliderLeft.value
                    x: (parent.width - width) / 2
                    y: parent.height / 2 - height
                }
            }

            // --- Vòng ngoài ---
            Image {
                id: ellipse1Left
                anchors.centerIn: parent
                source: "qrc:/img/Ellipse 1.svg"
                sourceSize: Qt.size(270, 270)
                smooth: true
                z: 1
            }

            // --- Vòng giữa ---
            Image {
                id: ellipse2Left
                anchors.centerIn: parent
                source: "qrc:/img/ring.svg"
                sourceSize: Qt.size(190, 190)
                smooth: true
                z: 1
            }

            // --- Lớp Subtract (che kim + chữ) ---
            Image {
                id: subtractLeft
                anchors.centerIn: parent
                source: "qrc:/img/Subtract.svg"
                sourceSize: Qt.size(150, 150)
                smooth: true
                z: 3

                // Nắp giữa
                Image {
                    id: ellipse6Left
                    anchors.centerIn: parent
                    source: "qrc:/img/Ellipse 6.svg"
                    sourceSize: Qt.size(100, 100)
                    smooth: true
                    z: 4

                    // --- DÒNG HIỂN THỊ TỐC ĐỘ ---
                    Column {
                        anchors.centerIn: parent
                        spacing: 0

                        Text {
                            id: speedText
                            text: Math.round(speedSlider.value)
                            color: "white"
                            font.pixelSize: 48
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: "km/h"
                            color: "#AAAAAA"
                            font.pixelSize: 18
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
        width: 250
        height: 250
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 300    // sang phải
        anchors.verticalCenterOffset: 0
        z: 2

        Item {
            id: gaugeRight
            anchors.centerIn: parent
            width: 250
            height: 250
            z: 2

            // --- KIM ---
            Item {
                id: needleLayerRight
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                z: 0

                Image {
                    id: needleRight
                    source: "qrc:/img/Rectangle 4.svg"
                    width: 10
                    height: 110
                    smooth: true
                    fillMode: Image.PreserveAspectFit
                    transformOrigin: Item.Bottom
                    rotation: angleSliderRight.value
                    x: (parent.width - width) / 2
                    y: parent.height / 2 - height
                }
            }

            // --- Vòng ngoài ---
            Image {
                id: ellipse1Right
                anchors.centerIn: parent
                source: "qrc:/img/Ellipse 1.svg"
                sourceSize: Qt.size(270, 270)
                smooth: true
                z: 1
            }

            // --- Vòng giữa ---
            Image {
                id: ellipse2Right
                anchors.centerIn: parent
                source: "qrc:/img/ring.svg"
                sourceSize: Qt.size(190, 190)
                smooth: true
                z: 1
            }

            // --- Lớp Subtract (che kim + chữ) ---
            Image {
                id: subtractRight
                anchors.centerIn: parent
                source: "qrc:/img/Subtract.svg"
                sourceSize: Qt.size(150, 150)
                smooth: true
                z: 3

                // Nắp giữa
                Image {
                    id: ellipse6Right
                    anchors.centerIn: parent
                    source: "qrc:/img/Ellipse 6.svg"
                    sourceSize: Qt.size(100, 100)
                    smooth: true
                    z: 4

                    // --- DÒNG HIỂN THỊ VÒNG TU (RPM) ---
                    Column {
                        anchors.centerIn: parent
                        spacing: 0

                        Text {
                            id: rpmText
                            text: Math.round(rpmSlider.value)
                            color: "white"
                            font.pixelSize: 48
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Text {
                            text: "RPM"
                            color: "#AAAAAA"
                            font.pixelSize: 18
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }
    }

    // =========================================================
    //  SLIDER TEST CHO 2 ĐỒNG HỒ
    // =========================================================
    // --- Speed ---
    Slider {
        id: speedSlider
        from: 0
        to: 220
        value: 0
        stepSize: 1
        width: parent.width * 0.4
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        z: 10
    }

    Label {
        text: qsTr("Speed: %1 km/h").arg(Math.round(speedSlider.value))
        color: "white"
        anchors.horizontalCenter: speedSlider.horizontalCenter
        anchors.bottom: speedSlider.top
        anchors.bottomMargin: 8
        z: 10
    }

    // --- RPM ---
    Slider {
        id: rpmSlider
        from: 0
        to: 8        // giả lập 0–8000 rpm
        value: 0
        stepSize: 0.1
        width: parent.width * 0.4
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        z: 10
    }

    Label {
        text: qsTr("RPM").arg(rpmSlider.value.toFixed(1))
        color: "white"
        anchors.horizontalCenter: rpmSlider.horizontalCenter
        anchors.bottom: rpmSlider.top
        anchors.bottomMargin: 8
        z: 10
    }

    // =========================================================
    //  ÁNH XẠ SLIDER → GÓC KIM
    // =========================================================
    Binding {
        target: angleSliderLeft
        property: "value"
        value: (speedSlider.value / 220) * 310 - 155
    }

    Binding {
        target: angleSliderRight
        property: "value"
        value: (rpmSlider.value / 8) * 310 - 155
    }

    // --- Slider ẩn ---
    Slider {
        id: angleSliderLeft
        visible: false
        from: -155
        to: 155
        value: 0
    }

    Slider {
        id: angleSliderRight
        visible: false
        from: -155
        to: 155
        value: 0
    }

}
