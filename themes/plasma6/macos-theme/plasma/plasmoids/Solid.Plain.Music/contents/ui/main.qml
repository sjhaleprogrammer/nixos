import QtQuick 2.12
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import Qt5Compat.GraphicalEffects
import org.kde.kirigami as Kirigami
import org.kde.ksvg 1.0 as KSvg
import org.kde.plasma.private.mpris as Mpris

PlasmoidItem {
  id: root
  width: 450
  height: 100
  preferredRepresentation: fullRepresentation
  Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground

  property int wAndH: ((root.height*4 < root.width) ? root.height*4 : root.width)/4
  property color widgetColor: Plasmoid.configuration.colorHex
  KSvg.FrameSvgItem {
    id : backgroundSvg

    visible: false

    imagePath: "dialogs/background"
  }

  function isColorLight(color) {
    var r = Qt.rgba(color.r, 0, 0, 0).r * 255;
    var g = Qt.rgba(0, color.g, 0, 0).g * 255;
    var b = Qt.rgba(0, 0, color.b, 0).b * 255;
    var luminance = 0.299 * r + 0.587 * g + 0.114 * b;
    return luminance > 127.5; // Devuelve true si es claro, false si es oscuro
  }

  InfoMusic {
    id: infoMusic
  }

  Mpris.Mpris2Model {
    id: mpris2Model
  }

  function next() {
    mpris2Model.currentPlayer.Next()
  }
  function playPause() {
    mpris2Model.currentPlayer.PlayPause()
  }
  function prev() {
    mpris2Model.currentPlayer.Previous()
  }

  Item {
    width: (root.height*4 < root.width) ? root.height*4 : root.width
    height: width/4
    DropShadow {
      anchors.fill: base
      horizontalOffset: 2
      verticalOffset: 2
      radius: 15
      samples: 17
      color: "#b2000000"
      source: base
      opacity: 0.3
    }
      Rectangle {
        id: base
        width: parent.width
        height: parent.height
        color: widgetColor
        radius: height/6
        opacity: 1
      }

      //
      //
      //

      Rectangle {
        id: coverMask
        width: parent.height * .8
        height: width
        radius: height/6
        visible: false
      }

      Image {
        id: cover
        width: coverMask.width
        height: coverMask.height
        source: infoMusic.albumUrl
        visible: infoMusic.albumUrl ? true : false
        layer.enabled: true
        layer.effect: OpacityMask {
          maskSource: coverMask
        }

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.height * .1
      }
      Rectangle {
        id: border
        width: coverMask.width
        height: coverMask.height
        anchors.centerIn: cover
        radius: coverMask.radius
        color: "transparent"
        border.width: 3
        border.color: isColorLight(widgetColor) ? "black" : "white"
        visible: infoMusic.albumUrl ? true : false
      }

      Item {
        id: music
        width: parent.width - cover.width - parent.height * .1
        height: track.implicitHeight + artist.implicitHeight
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:  cover.right
        anchors.leftMargin: cover.height * .1
        MouseArea {
          width: parent.width
          height: parent.height
          preventStealing: true
          anchors.centerIn: parent
          hoverEnabled: true
          onEntered: {
            controls.visible = true
            track.visible = false
            artist.visible = false
          }
          onExited: {
            controls.visible = false
            track.visible = true
            artist.visible = true
          }
        }
        Text {
          id: track
          text: infoMusic.track
          width: parent.width
          height: parent.height - artist.implicitHeight
          color: isColorLight(widgetColor) ? "black" : "white"
          wrapMode: "WordWrap"
          font.pixelSize: cover.height*.22
          font.capitalization: Font.Capitalize
          font.bold: true
          anchors.top: parent.top
          visible: true
        }
        Text {
          id: artist
          text: infoMusic.artist
          height: parent.width - track.implicitHeight
          color:  isColorLight(widgetColor) ? "black" : "white"
          wrapMode: "WordWrap"
          font.capitalization: Font.Capitalize
          font.pixelSize: cover.height*.18
          //font.bold: true
          anchors.top: track.bottom
          visible: true
        }
      }
      Row {
        id: controls
        width: coverMask.height*2.1
        height: coverMask.height*.7
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:  cover.right
        anchors.leftMargin: (parent.width - cover.width - controls.width)/2
        spacing: cover.height*.2
        visible: false
        Icons {
          id: prevplay
          width: coverMask.height*.5
          wAndH: coverMask.height*.5
          height: width
          iconColor: isColorLight(widgetColor) ? "black" : "white"
          iconUrl: "../icons/media-skip-backward"
          anchors.verticalCenter: parent.verticalCenter
          MouseArea {
            anchors.fill: parent
            onClicked: prev()
          }
        }
        Icons {
          id: iconplay
          width: coverMask.height*.7
          wAndH: coverMask.height*.7
          height: width
          iconColor: isColorLight(widgetColor) ? "black" : "white"
          iconUrl: "../icons/media-playback-start.svg"
          anchors.verticalCenter: parent.verticalCenter
          MouseArea {
            anchors.fill: parent
            onClicked: playPause()
          }
        }
        Icons {
          id: nextplay
          width: coverMask.height*.5
          wAndH: coverMask.height*.5
          height: width
          iconColor: isColorLight(widgetColor) ? "black" : "white"
          iconUrl: "../icons/media-skip-forward"
          anchors.verticalCenter: parent.verticalCenter
          MouseArea {
            anchors.fill: parent
            onClicked: next()
          }
        }
      }


  }


}

