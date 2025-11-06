import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: splash
    width: 800
    height: 480
    visible: true
    color: "black"
    title: "Splash Screen"

    signal splashFinished()

    Image {
        id: logo
        anchors.centerIn: parent
        source: "qrc:/resources/logo.png"
        opacity: 0.0
        Behavior on opacity { NumberAnimation { duration: 1000 } }
    }

    SequentialAnimation {
        id: fadeAnim
        running: true
        loops: 1

        NumberAnimation { target: logo; property: "opacity"; from: 0; to: 1; duration: 1500 }
        PauseAnimation { duration: 1000 }
        NumberAnimation { target: logo; property: "opacity"; from: 1; to: 0; duration: 1500 }

        onStopped: {
            splash.visible = false
            splashFinished()
        }
    }
}
