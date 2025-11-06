import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root
    width: 1100
    height: 500
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
    Image {
        id: canhbao1
        source: "qrc:/img/icon-park-solid_right-two.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -185
        anchors.horizontalCenterOffset: -150   // sang trái

        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }
    Image {
        id: canhbao2
        source: "qrc:/img/mdi_car-handbrake.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -190
        anchors.horizontalCenterOffset: -200   // sang trái

        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }
    Image {
        id: canhbao3
        source: "qrc:/img/ph_engine-bold.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -195
        anchors.horizontalCenterOffset: -250   // sang trái

        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }
    Image {
        id: canhbao4
        source: "qrc:/img/mdi_oil.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -205
        anchors.horizontalCenterOffset: -300   // sang trái

        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }
    Image {
        id: canhbao5
        source: "qrc:/img/mdi_car-battery.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -213
        anchors.horizontalCenterOffset: -350   // sang trái

        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }
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
    }
    Image {
        id: canhbao7
        source: "qrc:/img/mdi_seatbelt.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -190
        anchors.horizontalCenterOffset: 200   // sang trái
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }
    Image {
        id: canhbao8
        source: "qrc:/img/mdi_car-light-dimmed.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -195
        anchors.horizontalCenterOffset: 250   // sang trái

        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }
    Image {
        id: canhbao9
        source: "qrc:/img/mdi_car-light-fog.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -205
        anchors.horizontalCenterOffset: 300   // sang trái
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
    }
    Image {
        id: canhbao10
        source: "qrc:/img/mdi_car-light-high.svg"
        anchors.centerIn: parent
        sourceSize: Qt.size(30, 30)
        anchors.verticalCenterOffset: -213
        anchors.horizontalCenterOffset: 350   // sang trái
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        z: 1
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
