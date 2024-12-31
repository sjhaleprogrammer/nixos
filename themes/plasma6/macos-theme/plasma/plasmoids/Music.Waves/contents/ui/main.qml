import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plasma.private.mpris as Mpris
import org.kde.plasma.private.volume

PlasmoidItem {
    id: root
    width: 576
    height: 240

    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: "NoBackground"

    property var sink: PreferredDevice.sink
    property string artist: mpris2Model.currentPlayer?.artist ?? ""
    property string track: mpris2Model.currentPlayer?.track
    property string generalColor: Plasmoid.configuration.customColorEnable ? Plasmoid.configuration.customColorCodeRGB : Kirigami.ThemeTextColor

    readonly property int playbackStatus: mpris2Model.currentPlayer?.playbackStatus ?? 0
    readonly property bool isPlaying: root.playbackStatus === Mpris.PlaybackStatus.Playing

    VolumeMonitor {
        id: volumeMonitor
        target: sink
    }

    Item {
        id: wrapper
        width: root.width < root.height*2.5 ? root.width : root.height*2.5
        height: width/2.5

        Item {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            Row {
                id: bar
                height: parent.height / 4
                spacing: bar.height * 0.12
                width: bar.height*4.08
                anchors.left: parent.left
                anchors.leftMargin: (parent.width - bar.implicitWidth)/2
                anchors.top: parent.top
                anchors.topMargin: height/3

                property var heights: [height * 0.17, height * 0.33, height * 0.36, height * 0.62, height, height * 0.62, height * 0.36, height * 0.33, height * 0.17]

                function generateRectangles() {
                    for (let i = 0; i < heights.length; i++) {
                        createRectangle(i, heights[i]);
                    }
                }

                onHeightChanged: {
                    bar.heights = [height * 0.17, height * 0.33, height * 0.36, height * 0.62, height, height * 0.62, height * 0.36, height * 0.33, height * 0.17]
                }

                Component.onCompleted: {
                    generateRectangles();
                }

                function createRectangle(index, initialHeight) {
                    var rect = Qt.createQmlObject('import QtQuick 2.15; import org.kde.kirigami as Kirigami; Rectangle { \
                    id: rect' + index + '; \
                    width: bar.height / 8; \
                    radius: width / 2; \
                    anchors.verticalCenter: parent.verticalCenter; \
                    color: Kirigami.Theme.textColor; \
                    height: ' + initialHeight + '; \
                    property real oneHeight: ' + initialHeight + '; \
                    SequentialAnimation { \
                    id: heightAnimation' + index + '; \
                    running: true; \
                    loops: Animation.Infinite; \
                    PropertyAnimation { \
                    target: parent; \
                    property: "height"; \
                    to: initialHeight; \
                    duration: 100; \
                    easing.type: Easing.InOutQuad; \
                } \
                } \
                Timer { \
                id: timer' + index + '; \
                interval: 100; \
                running: true; \
                repeat: true; \
                onTriggered: { \
                parent.oneHeight = isPlaying  ? Math.random() * (volumeMonitor.volume * (' + bar.height + ')) + (' + initialHeight + ') * volumeMonitor.volume + 8 : bar.height / 8; \
                parent.height = parent.oneHeight; \
                } \
                } \
                }', bar);
                    rect.anchors.verticalCenter = parent.verticalCenter;
                    rect.anchors.horizontalCenterOffset = (index - (heights.length - 1) / 2) * (bar.width / heights.length + bar.spacing);
                }
            }

            Column {
                id: infotrack
                width: wrapper.width
                height: parent.height - (bar.height * 2)
                anchors.top: bar.bottom
                anchors.topMargin: 10
                spacing: 0
                Rectangle {
                    width: wrapper.width
                    height: parent.height * 0.7
                    color: "transparent"
                    Text {
                        id: trackMusic
                        width: wrapper.width
                        font.pixelSize: parent.height * 0.25
                        text: track
                        color: generalColor
                        font.bold: true
                        lineHeight: 0.8
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.Bottom
                        wrapMode: Text.WordWrap
                        elide: Text.ElideRight
                        maximumLineCount: 2
                        anchors.bottom: parent.bottom
                    }
                }

                Text {
                    id: artisMusic
                    width: wrapper.width
                    height: parent.height * 0.35
                    font.pixelSize: height * 0.4
                    text: artist
                    color: generalColor
                    opacity: 0.80
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
            }
        }
    }

    Mpris.Mpris2Model {
        id: mpris2Model
    }
}

