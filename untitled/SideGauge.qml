// =========================
// File: CustomCircularGauge.qml
// =========================
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: gauge
    // ---- Public API (drop-in-ish replacement) ----
    property real value: 80
    property real minimumValue: 0
    property real maximumValue: 260
    property real minimumValueAngle: -155
    property real maximumValueAngle: 155

    // Size
    width: 360; height: 360
    property real outerRadius: Math.min(width, height) / 2

    // Helpers
    function clamp(v, lo, hi) { return Math.max(lo, Math.min(hi, v)); }
    function norm(v) { return (v - minimumValue) / (maximumValue - minimumValue); }
    function valueToAngle(v) {
        var t = norm(clamp(v, minimumValue, maximumValue));
        return minimumValueAngle + t * (maximumValueAngle - minimumValueAngle);
    }
    function degreesToRadians(deg) { return deg * Math.PI / 180.0; }

    // --- Background thin arc (green line)
    Canvas {
        id: thinArc
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            var startAngle = gauge.valueToAngle(gauge.minimumValue) - 90;
            var endAngle   = gauge.valueToAngle(250) - 90; // keep as in original
            var gradient = ctx.createLinearGradient(0, 0, gauge.outerRadius * 2, 0);
            gradient.addColorStop(0, "#B8FF01");
            gradient.addColorStop(1, "#B8FF01");
            ctx.beginPath();
            ctx.lineWidth = 1.5;
            ctx.strokeStyle = gradient;
            ctx.arc(gauge.outerRadius, gauge.outerRadius,
                    gauge.outerRadius - 57,
                    degreesToRadians(startAngle),
                    degreesToRadians(endAngle));
            ctx.stroke();
        }
    }

    // --- Base dark arc (track)
    Canvas {
        id: baseArc
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            var startAngle = gauge.valueToAngle(gauge.minimumValue) - 90;
            var endAngle   = gauge.valueToAngle(250) - 90;
            var gradient = ctx.createLinearGradient(0, 0, gauge.outerRadius * 2, 0);
            gradient.addColorStop(0, "#163546");
            gradient.addColorStop(1, "#163546");
            ctx.beginPath();
            ctx.lineWidth = gauge.outerRadius * 0.15;
            ctx.strokeStyle = gradient;
            ctx.arc(gauge.outerRadius, gauge.outerRadius,
                    gauge.outerRadius - 75,
                    degreesToRadians(startAngle),
                    degreesToRadians(endAngle));
            ctx.stroke();
        }
    }

    // --- Progress arc (gradient)
    Canvas {
        id: progressArc
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            var startAngle = gauge.valueToAngle(gauge.minimumValue) - 90;
            var endAngle   = gauge.valueToAngle(gauge.value) - 90;
            var gradient = ctx.createLinearGradient(0, 0, gauge.outerRadius * 2, 0);
            gradient.addColorStop(0, "#6369FF");
            gradient.addColorStop(0.4, "#63FFFF");
            gradient.addColorStop(0.7, "#FFFF00");
            gradient.addColorStop(1, "#FF0000");
            ctx.beginPath();
            ctx.lineWidth = gauge.outerRadius * 0.15;
            ctx.strokeStyle = gradient;
            ctx.lineCap = "round";
            ctx.arc(gauge.outerRadius, gauge.outerRadius,
                    gauge.outerRadius - 75,
                    degreesToRadians(startAngle),
                    degreesToRadians(endAngle));
            ctx.stroke();
        }
        Connections {
            target: gauge
            function onValueChanged() { progressArc.requestPaint(); }
            function onWidthChanged() { progressArc.requestPaint(); }
            function onHeightChanged() { progressArc.requestPaint(); }
        }
    }

    // --- Tickmarks (major every 10, minor every 5)
    Item {
        id: ticksLayer
        anchors.fill: parent

        // Minor ticks
        Repeater {
            id: minorTicks
            model: Math.floor((gauge.maximumValue - gauge.minimumValue) / 5) + 1
            delegate: Item {
                width: 1; height: 1
                anchors.centerIn: parent
                property real val: gauge.minimumValue + index * 5
                property real ang: gauge.valueToAngle(val)
                rotation: ang
                Rectangle {
                    width: gauge.outerRadius * 0.006
                    height: gauge.outerRadius * 0.035
                    radius: width/2
                    color: val <= gauge.value ? "white" : "#555555"
                    antialiasing: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: gauge.outerRadius - height - gauge.outerRadius * 0.05
                }
            }
        }
        // Major ticks + labels
        Repeater {
            id: majorTicks
            model: Math.floor((gauge.maximumValue - gauge.minimumValue) / 10) + 1
            delegate: Item {
                width: 1; height: 1
                anchors.centerIn: parent
                property real val: gauge.minimumValue + index * 10
                property real ang: gauge.valueToAngle(val)
                rotation: ang
                Rectangle {
                    width: gauge.outerRadius * 0.010
                    height: gauge.outerRadius * 0.06
                    radius: width/2
                    color: val <= gauge.value ? "white" : "darkGray"
                    antialiasing: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: gauge.outerRadius - height - gauge.outerRadius * 0.04
                }
                // label every 20
                Text {
                    visible: (index % 2 === 0)
                    text: val
                    font.pixelSize: Math.max(6, gauge.outerRadius * 0.08 * 0.6)
                    color: val <= gauge.value ? "white" : "#777776"
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: gauge.outerRadius - gauge.outerRadius * 0.20
                    rotation: -ang   // keep labels upright
                    antialiasing: true
                }
            }
        }
    }

    // --- Needle
    Item {
        id: needleWrap
        anchors.centerIn: parent
        width: gauge.outerRadius * 0.02
        height: gauge.outerRadius * 0.70
        transformOrigin: Item.Bottom
        rotation: gauge.valueToAngle(gauge.value)

        Image {
            id: needle
            anchors.fill: parent
            source: "qrc:/img/Rectangle 4.svg"
            asynchronous: true
            antialiasing: true
            fillMode: Image.PreserveAspectFit
        }
        Glow {
            anchors.fill: needle
            radius: 5
            samples: 10
            color: "white"
            source: needle
        }
    }

    // --- Center foreground & speed text
    Item {
        id: centerForeground
        anchors.centerIn: parent
        width: gauge.outerRadius * 1.2
        height: width
        Image {
            anchors.centerIn: parent
            source: "qrc:/img/Ellipse 1.svg"
            fillMode: Image.PreserveAspectFit
            smooth: true
            antialiasing: true
            Image {
                anchors.centerIn: parent
                source: "qrc:/img/Subtract.svg"
                sourceSize: Qt.size(203, 203)
                fillMode: Image.PreserveAspectFit
                smooth: true
                antialiasing: true
                Image {
                    z: 2
                    anchors.centerIn: parent
                    source: "qrc:/img/Ellipse 6.svg"
                    sourceSize: Qt.size(147, 147)
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    antialiasing: true

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 0
                        Label {
                            text: Math.round(gauge.value)
                            font.pixelSize: 65
                            color: "#FFFFFF"
                            font.bold: Font.DemiBold
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Label {
                            text: "km/h"
                            font.pixelSize: 18
                            color: "#FFFFFF"
                            opacity: 0.4
                            Layout.alignment: Qt.AlignHCenter
                        }
                    }
                }
            }
        }
    }
}


// =========================
// File: main.qml (example usage)
// =========================
import QtQuick
import QtQuick.Window

Window {
    id: root
    width: 800; height: 480
    visible: true
    color: "black"

    // Background image from your folder (optional)
    Image {
        anchors.fill: parent
        source: "qrc:/images/DashboardFrameSport-mask.png"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        smooth: true
    }

    // Use the custom gauge
    Loader {
        id: gaugeLoader
        anchors.centerIn: parent
        width: 360; height: 360
        source: "qrc:/qml/CustomCircularGauge.qml"
        onLoaded: {
            var g = gaugeLoader.item
            if (g) {
                g.minimumValue = 0
                g.maximumValue = 260
                g.value = 0
            }
        }
    }

    // Demo animation
    SequentialAnimation {
        running: true; loops: Animation.Infinite
        NumberAnimation { target: gaugeLoader.item; property: "value"; from: 0; to: 200; duration: 2500; easing.type: Easing.InOutQuad }
        PauseAnimation { duration: 400 }
        NumberAnimation { target: gaugeLoader.item; property: "value"; from: 200; to: 60; duration: 1800; easing.type: Easing.InOutCubic }
        PauseAnimation { duration: 300 }
    }
}


// =========================
// qml.qrc (add these entries)
// =========================
// <RCC>
//   <qresource prefix="/">
//     <file>qml/CustomCircularGauge.qml</file>
//     <file>qml/main.qml</file>
//     <file>images/DashboardFrameSport-mask.png</file>
//     <file>img/Rectangle 4.svg</file>
//     <file>img/Ellipse 1.svg</file>
//     <file>img/Subtract.svg</file>
//     <file>img/Ellipse 6.svg</file>
//   </qresource>
// </RCC>
