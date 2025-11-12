pragma Singleton
import QtQuick 2.15

QtObject {
    // Dark mode
    property color bgDark: "#0A0A0A"
    property color bgDark2: "#1F1F1F"

    property color textDark: "#FFFFFF"
    property color iconDark: "#FFFFFF"
    property color borderDark: "#38FF14"

    // Neon nhấn
    property color neon: "#38FF14"   // Màu bạn chọn - N1

    // Light mode (dùng về sau)
    property color bgLight: "#FAFAFA"
    property color textLight: "#000000"
    property color iconLight: "#000000"
    property color borderLight: "#555555"
}
