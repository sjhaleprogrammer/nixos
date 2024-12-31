import Qt5Compat.GraphicalEffects
import QtQuick 2.12

Item {
    id: root
    width: 45
    height: 45
    property color iconColor: "black"
    property string iconUrl: ""
    property int wAndH: 0
    Image {
        id: mask
        source: iconUrl
        width: root.width
        height: root.height
        sourceSize: Qt.size(width, width)
        fillMode: Image.PreserveAspectFit
        visible: false

    }
    Rectangle {
        width: root.width
        height: root.height
        color: iconColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
    }
}
