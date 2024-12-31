import QtQuick 2.12
import org.kde.plasma.plasmoid
import "components" as Components
import org.kde.plasma.core as PlasmaCore
import Qt5Compat.GraphicalEffects
import "js/Texts.js" as Texts

PlasmoidItem {
  id: root
  width: 300
  height: 150
  preferredRepresentation: fullRepresentation
  Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground

  FontLoader {
    id: creato
    source: "../fonts/CreatoDisplay-Light.otf"
  }

  FontLoader {
    id: muro
    source: "../fonts/Muro.otf"
  }

  Components.WeatherData {
    id: weatherData
  }
  property string temperatureUnit: Plasmoid.configuration.temperatureUnit
  property int dateOfUbi: Plasmoid.configuration.locOrMaxMin
  property color colorWidget: Plasmoid.configuration.colorHex
  property string temcurrent: Math.round(weatherData.temperaturaActual) + "°"
  property string dat: Texts.getMonthText(codelang, Qt.formatDateTime(new Date(), "M") - 1) + " " + Qt.formatDateTime(new Date(), "d")
  property string dayInText: Texts.getDayWeekText(codelang, new Date().getDay())

  property string textByFirstPanel: (weatherData.datosweather !== "0") ? weatherData.weatherShottext + ", " + temcurrent : "Unknown"
  property string icon: (weatherData.datosweather !== "0") ? weatherData.iconWeatherCurrent : "weather-none-available"
  property string hours: Qt.formatDateTime(new Date(), "h:mm")
  property string codelang: ((Qt.locale().name)[0]+(Qt.locale().name)[1])


  Item {
    width: root.width
    height: root.height
    Row {
      id: wrapper
      width: (parent.height * 3) > parent.width ? parent.width : parent.height * 3
      height: width / 3
      anchors.centerIn: parent
      Item {
        width: parent.width * .50
        height: parent.height
        Text {
          width: parent.width
          text: dayInText
          anchors.top: parent.top
          color: colorWidget
          font.pixelSize: parent.height * .32
          font.family: muro.name
          horizontalAlignment: Text.AlignRight
        }
      }
      Item {
        width: wrapper.width * .15
        height: wrapper.height
        Column {
          width: parent.width
          height: parent.height
          Rectangle {
            id: firstLine
            width: weatherLogo.border.width*2
            height: parent.height * .9 - parent.width - 18
            color: white
            anchors.horizontalCenter: parent.horizontalCenter
            radius: height/2
          }
          Rectangle {
            width: parent.width
            height: 9
            color: "transparent"
          }
          Rectangle {
            id: weatherLogo
            width: parent.width
            height: parent.width
            color: "transparent"
            border.color: colorWidget
            border.width: 2
            radius: height / 2
            Image {
              id: mask
              width: parent.width * .7
              height: width
              source: "../icons/" + icon + ".svg"
              sourceSize: Qt.size(width, width)
              fillMode: Image.PreserveAspectFit
              visible: false
            }
            Rectangle {
              id: iconRect
              width: mask.width
              height: mask.height
              color: colorWidget
              layer.enabled: true
              layer.effect: OpacityMask {
                maskSource: mask
              }
              anchors.verticalCenter: parent.verticalCenter
              anchors.horizontalCenter: parent.horizontalCenter
            }
          }
          Rectangle {
            width: parent.width
            height: 9
            color: "transparent"
          }
          Rectangle {
            id: secondLine
            width: weatherLogo.border.width*2
            height: parent.height * .1
            anchors.horizontalCenter: parent.horizontalCenter
            color: white
            radius: height/2
          }
        }
      }
      Item {
        width: parent.width * .35
        height: parent.height
        Column {
          height: parent.height
          width: parent.width
          Text {
            id: hors
            text: hours
            color: colorWidget
            font.pixelSize: parent.height * .2
            font.family: muro.name
          }
          Text {
            id: date
            text: dat
            color: colorWidget
            font.pixelSize: parent.height * .2
            font.family: creato.name
          }
          Rectangle {
            id: separator
            width: parent.width
            height: parent.height - weat.implicitHeight - hors.implicitHeight - date.implicitHeight
            color: "transparent"
          }
          Text {
            id: weat
            text: textByFirstPanel
            color: colorWidget
            font.pixelSize: parent.height * .15
            font.family: creato.name
          }
        }
      }
    }

    Timer {
      interval: 6000
      running: true
      repeat: true
      onTriggered: {
        hours = Qt.formatDateTime(new Date(), "h:mm")
      }
    }
    Timer {
      id: timer
      interval: 8.64e+7-((new Date().getHours()*60*60*1000)+(new Date().getMinutes()*60*1000)+(new Date().getSeconds()*1000)+new Date().getMilliseconds())
      running: true
      repeat: true
      onTriggered: {
        dayInText = Texts.getDayWeekText(codelang, new Date().getDay())
        dat = Texts.getMonthText(codelang, Qt.formatDateTime(new Date(), "M") - 1) + Qt.formatDateTime(new Date(), "d")
        timer.interval = 8.64e+7
      }
    }
  }
}

