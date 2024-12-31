import QtQuick 2.12
import org.kde.plasma.plasmoid
import "components" as Components
import org.kde.plasma.core as PlasmaCore
import Qt5Compat.GraphicalEffects
import "js/Texts.js" as Texts

PlasmoidItem {
  id: root
  preferredRepresentation: fullRepresentation
  Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground


  FontLoader {
    id: muro
    source: "../fonts/Muro.otf"
  }

  Components.WeatherData {
    id: weatherData
  }

  property color colorWidget: Plasmoid.configuration.colorHex
  property string temcurrent: Math.round(weatherData.temperaturaActual) + "°"
  property string icon: weatherData.datosweather !== "0" ? weatherData.iconWeatherCurrent : "weather-none-available"


  Item {
    width: root.width
    height: root.height
    Rectangle {
      id: wrapper
      width: (parent.height < parent.width) ? parent.height : parent.width
      height: width
      radius: height/2
      color: colorWidget
      anchors.centerIn: parent
      layer.enabled: true
      layer.effect: OpacityMask {
        maskSource: mask
        invert: true
      }
    }
    Rectangle {
      id: mask
      width: wrapper.width
      height: wrapper.height
      color: "transparent"
      visible: false
      Image {
        id: icon
        width: parent.width * .5
        height: width
        source: "../icons/"+(weatherData.datosweather !== "0" ? weatherData.iconWeatherCurrent : "weather-none-available")+".svg"
        sourceSize: Qt.size(width, width)
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height*.12
      }

      Item {
        width: degrees.implicitWidth
        height: degrees.implicitHeight
        anchors.left: parent.left
        anchors.leftMargin: (parent.width - degrees.implicitWidth)/2 +  degrees.implicitWidth*.16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: icon.height*.3
        Text {
          id: degrees
          width: parent.width
          height: parent.height
          text: temcurrent
          color: "black"
          font.pixelSize: wrapper.height * .28
          font.family: muro.name
        }
      }
    }
  }
}

