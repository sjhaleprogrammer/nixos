/*
    SPDX-FileCopyrightText: zayronxio
    SPDX-License-Identifier: GPL-3.0-or-later
*/
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import "components" as Components


PlasmoidItem {
    id: root
    width: 400
    height: 200

    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground

    property string temperatureUnit: plasmoid.configuration.temperatureUnit

    Components.WeatherData {
      id: weatherData
    }

    function porcentOftext(a,b) {
          var porcenttext = b/a
          return  porcenttext
        }
    Column {
       id: base
       width: parent.width < parent.height*2 ? parent.width : parent.height*2
       height: width/2
       anchors.centerIn: parent

       Row {
           id: twoRectangle
           width: base.width
           height: base.height
           Rectangle {
             width: parent.width/2
             height: parent.height
             color: "#ff444f5b"
             Column {
               anchors.verticalCenter: parent.verticalCenter
               width: parent.width
               height: parent.height*.7
               Text {
                 text:Math.round(weatherData.temperaturaActual) + "°"
                 color: "white"
                 font.bold: true
                 font.pixelSize: parent.height*.5
                 anchors.horizontalCenter: parent.horizontalCenter
              }

               Text {
                 id: textLocalidadPrev
                 visible: false
                 text: weatherData.city
                 font.bold: true
                 font.pixelSize: parent.height*.3
              }
              Text {
                id: textWithWrap
                visible: false
                text: weatherData.city
                font.bold: true
                wrapMode: porcentOftext(textLocalidadPrev.width,(parent.width*.9)) > .7 ? Text.WordWrap : Text.NoWrap
                font.pixelSize:  porcentOftext(textLocalidadPrev.width,(parent.width*.9)) > .7 ? textLocalidadPrev.font.pixelSize : textLocalidadPrev.font.pixelSize*porcentOftext(textLocalidadPrev.width,(parent.width*.9))
              }
              Text {
                id: textlocFinal
                color: "white"
                text: weatherData.city
                wrapMode: textWithWrap.wrapMode
                font.pixelSize:  porcentOftext(textWithWrap.width,(parent.width*.9)) > .101 ? textWithWrap.font.pixelSize : textWithWrap.font.pixelSize*porcentOftext(textWithWrap.width,(parent.width*.9))
                anchors.horizontalCenter: parent.horizontalCenter
              }
            }
          }
          Rectangle {
            width: parent.width/2
            height: parent.height
            color: "#fff7f8f9"
            Column {
              width: parent.width
              height:parent.height

              Rectangle {
                width: parent.width
                height: parent.height*.75
                color: "transparent"

                Image {
                  width: parent.height*.75
                  height: width
                  source: "../icons/"+weatherData.iconWeatherCurrent+".svg"
                  sourceSize: Qt.size(width, width)
                  fillMode: Image.PreserveAspectFit
                  anchors.centerIn: parent
                }
              }

              Rectangle {
                id: secondrectangle
                color: "#ff3fa4bb"
                width: parent.width
                height: parent.height*.25
                Row {
                  width: down.width + textOfMinTemp.width + separator.width + up.width + textOfMaxTemp.width
                  height: parent.height
                  anchors.horizontalCenter: parent.horizontalCenter
                  spacing: 0
                      Image {
                        id: down
                        width: parent.height*.7
                        height: width
                        source: "../icons/down.svg"
                        sourceSize: Qt.size(width, width)
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                      }
                      Text {
                        height: parent.height
                        id: textOfMinTemp
                        text: Math.round(weatherData.minweatherCurrent)+"°"
                        color: "white"
                        font.pixelSize: parent.height*.5
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                      }
                      Rectangle {
                        id: separator
                        width: parent.width*.15
                        height: parent.height
                        color: "transparent"
                      }
                      Image {
                        id: up
                        width: parent.height*.7
                        height: width
                        source: "../icons/up.svg"
                        sourceSize: Qt.size(width, width)
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                      }
                      Text {
                        height: parent.height
                        id: textOfMaxTemp
                        wrapMode: Text.NoWrap
                        text: Math.round(weatherData.maxweatherCurrent)+"°"
                        color: "white"
                        font.pixelSize: parent.height*.5
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                      }
                }
              }
            }
          }

           }

   }
}
