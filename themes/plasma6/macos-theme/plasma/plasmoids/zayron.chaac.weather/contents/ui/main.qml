/*
    SPDX-FileCopyrightText: zayronxio
    SPDX-License-Identifier: GPL-3.0-or-later
*/
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.core 2.0 as PlasmaCore
import "components" as Components

PlasmoidItem {
    id: root
    width: 400
    height: 200

    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground
    property string icon: (weatherData.datosweather !== "0") ? weatherData.iconWeatherCurrent : "weather-none-available"

    Components.WeatherData {
      id: weatherData
    }

    Column {
       id: base
       width: parent.width < parent.height*2 ? parent.width : parent.height*2
       height: width/2
       anchors.centerIn: parent

       Row {
           id: iconAndGrados
           width: base.height*2
           height: base.height

           Kirigami.Icon {
                width: base.height
                height: base.height
                source: icon
                roundToIconSize: false
           }
           Column {
               width: base.height
               height: width
               spacing: 0
               Row {
                   height: temOfCo.height
                   Text {
                      id: temOfCo
                      text: (weatherData.datosweather !== "0") ? parseFloat(weatherData.temperaturaActual).toFixed(1) : "?"
                      font.bold: boldfonts
                      color: "white"
                      font.pixelSize: iconAndGrados.height/2.5
                        }
                   Text {
                      text: (temperatureUnit === "0") ? "°C" : "°F"
                      font.bold: boldfonts
                      color: "white"
                      font.pixelSize: iconAndGrados.height/5
                      }

              }
              Text {
                  width: base.height
                  anchors.top: parent.top
                  anchors.topMargin: iconAndGrados.height/2.3
                  text: weatherData.city
                  color: "white"
                  wrapMode: Text.WordWrap
                  font.pixelSize: iconAndGrados.height/5.5
               }
             }
           }
   }
}
