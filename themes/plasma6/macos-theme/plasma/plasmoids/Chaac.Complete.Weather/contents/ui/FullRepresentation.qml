import QtQuick 2.4
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import "components" as Components
import Qt5Compat.GraphicalEffects
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg

ColumnLayout {
    id: fullweather
    width: 350
    height: 420


    Components.WeatherData {
        id: weatherData
    }

    ListModel {
        id: forecastModel
    }

    function agregarUnDia(x) {
        var fechaActual = new Date();
        fechaActual.setDate(fechaActual.getDate() + x); // Sumar un día
        return Qt.formatDateTime(fechaActual, "dd/MM");
    }

    function updateForecastModel() {

        let icons = {
            0: weatherData.oneIcon,
            1: weatherData.twoIcon,
            2: weatherData.threeIcon,
            3: weatherData.fourIcon,
            4: weatherData.fiveIcon,
            5: weatherData.sixIcon,
            6: weatherData.sevenIcon
        }
        let Maxs = {
            0: weatherData.oneMax,
            1: weatherData.twoMax,
            2: weatherData.threeMax,
            3: weatherData.fourMax,
            4: weatherData.fiveMax,
            5: weatherData.sixMax,
            6: weatherData.sevenMax
        }
        let Mins = {
            0: weatherData.oneMin,
            1: weatherData.twoMin,
            2: weatherData.threeMin,
            3: weatherData.fourMin,
            4: weatherData.fiveMin,
            5: weatherData.sixMin,
            6: weatherData.sevenMin
        }
        forecastModel.clear();
        for (var i = 0; i < 7; i++) {
            var icon = icons[i]
            var maxTemp = Maxs[i]
            var minTemp = Mins[i]
            var date = agregarUnDia(i)

            forecastModel.append({
                date: date,
                icon: icon,
                maxTemp: maxTemp,
                minTemp: minTemp
            });


        }
    }

    Component.onCompleted: {
        weatherData.dataChanged.connect(updateForecastModel); // Conectar el signal dataChanged a la función updateForecastModel
    }
    Item {
        width: fullweather.width
        height: fullweather.height
        Column {
            width: parent.width
            height: parent.height

            Column {
                id: currentWeather
                width: parent.width
                height: parent.height*.3
                Item {
                    id: location
                    width: parent.width
                    height: textLocation.implicitHeight
                    Text {
                        id: textLocation
                        width: parent.width
                        height: parent.height
                        text: weatherData.city
                        color: Kirigami.Theme.textColor
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
                Item {
                    id: currentWeatherText
                    width: parent.width
                    height: (parent.height - location.height)*.6
                    Text {
                        width: parent.width
                        height: parent.height
                        text: weatherData.temperaturaActual + "°"
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                        font.pixelSize: height*.9
                        color: Kirigami.Theme.textColor
                    }
                }
                Item {
                    width: parent.width
                    height: parent.height - currentWeatherText.height - location.height
                    Text {
                        width: parent.width*.7
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: weatherData.weatherLongtext.length > 10 ? weatherData.weatherLongtext + `\n ${weatherData.maxweatherCurrent} | ${weatherData.minweatherCurrent}` : weatherData.weatherLongtext + ` ${weatherData.maxweatherCurrent} | ${weatherData.minweatherCurrent}`
                        horizontalAlignment: Text.AlignHCenter
                        color: Kirigami.Theme.textColor
                    }
                }
            }
            Item {
                width: parent.width
                height: parent.height*.5


                KSvg.FrameSvgItem {
                    id: forecastFull
                    imagePath: "opaque/dialogs/background"
                    clip: true
                    anchors.centerIn: parent
                    width: parent.width -5
                    height: parent.height - 5

                    Column {
                        width: forecastFull.width
                        height: forecastFull.height

                        // Generate forecast items dynamically
                        Repeater {
                            model: forecastModel
                            delegate: Item {
                                width: parent.width
                                height: forecastFull.height / 7

                                Item {
                                    width: implicitWidth
                                    height: parent.height
                                    anchors.left: parent.left
                                    anchors.leftMargin: height * 0.5
                                    Text {

                                        width: parent.width
                                        height: parent.height
                                        color: Kirigami.Theme.textColor
                                        text: model.date
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }

                                Kirigami.Icon {
                                    height: parent.height * 0.8
                                    source: model.icon
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                Item {
                                    width: 50
                                    height: parent.height
                                    anchors.right: parent.right
                                    anchors.rightMargin: parent.height * 0.5
                                    Text {
                                        width: parent.width
                                        height: parent.height
                                        text: model.maxTemp + " | " + model.minTemp
                                        color: Kirigami.Theme.textColor
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                }
                            }
                        }
                    }
                }

            }
            Row {
                width: parent.width
                height: parent.height*.2
                Item {
                    width: parent.width/3
                    height: parent.height
                    KSvg.FrameSvgItem {
                        imagePath: "opaque/dialogs/background"
                        clip: true
                        anchors.centerIn: parent
                        width: parent.width -5
                        height: parent.height - 5
                        Column {
                            width: parent.width
                            height: parent.height
                            Item {
                                width: parent.width
                                height: parent.height*.3
                                Image {
                                    id: mask_uv
                                    width: height
                                    height: parent.height
                                    source: "../images/36.svg"
                                    sourceSize: Qt.size(width, width)
                                    fillMode: Image.PreserveAspectFit
                                    anchors.verticalCenter: parent.verticalCenter
                                    visible: false
                                }
                                Rectangle {
                                    width: mask_uv.width
                                    height: mask_uv.height
                                    color: Kirigami.Theme.textColor
                                    anchors.left: parent.left
                                    anchors.leftMargin: mask_uv.height*.3
                                    anchors.top: parent.top
                                    anchors.topMargin: mask_uv.height*.3
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: mask_uv
                                    }
                                }
                            }

                            Text {
                                width: parent.width
                                height: parent.height*.3
                                text: weatherData.uvtext
                                color: Kirigami.Theme.textColor
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                anchors.left: parent.left
                                anchors.leftMargin: height*.5
                            }
                            Text {
                                width: parent.width
                                text: weatherData.uvindex
                                height: parent.height*.3
                                color: Kirigami.Theme.textColor
                                verticalAlignment: Text.AlignVCenter
                                anchors.left: parent.left
                                anchors.leftMargin: height*.5
                            }
                        }
                    }
                }
                Item {
                    width: parent.width/3
                    height: parent.height
                    KSvg.FrameSvgItem {
                        imagePath: "opaque/dialogs/background"
                        clip: true
                        anchors.centerIn: parent
                        width: parent.width -5
                        height: parent.height - 5
                        Column {
                            width: parent.width
                            height: parent.height
                            Item {
                                width: parent.width
                                height: parent.height*.3
                                Image {
                                    id: mask_windSpeed
                                    width: height
                                    height: parent.height
                                    source: "../images/23.svg"
                                    sourceSize: Qt.size(width, width)
                                    fillMode: Image.PreserveAspectFit
                                    anchors.verticalCenter: parent.verticalCenter
                                    visible: false
                                }
                                Rectangle {
                                    width: mask_windSpeed.width
                                    height: mask_windSpeed.height
                                    color: Kirigami.Theme.textColor
                                    anchors.left: parent.left
                                    anchors.leftMargin: mask_windSpeed.height*.35
                                    anchors.top: parent.top
                                    anchors.topMargin: mask_windSpeed.height*.25
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: mask_windSpeed
                                    }
                                }
                            }

                            Text {
                                height: parent.height*.3
                                color: Kirigami.Theme.textColor
                                text: weatherData.windSpeedText
                                verticalAlignment: Text.AlignVCenter
                                //font.pixelSize: weatherData.windSpeedText.length > 8  ? height*.4 : height*.5
                                elide: Text.ElideRight
                                maximumLineCount: 2
                                anchors.left: parent.left
                                anchors.leftMargin: height*.5
                            }

                            Text {
                                height: parent.height*.3
                                color: Kirigami.Theme.textColor
                                text: weatherData.windSpeed + " km/h"
                                verticalAlignment: Text.AlignVCenter
                                anchors.left: parent.left
                                anchors.leftMargin: height*.5
                            }
                        }

                    }
                }
                Item {
                    width: parent.width/3
                    height: parent.height
                    KSvg.FrameSvgItem {
                        imagePath: "opaque/dialogs/background"
                        clip: true
                        anchors.centerIn: parent
                        width: parent.width -5
                        height: parent.height - 5
                        Column {
                            width: parent.width
                            height: parent.height
                            Item {
                                width: parent.width
                                height: parent.height*.3
                                Image {
                                    id: mask_drops
                                    width: height
                                    height: parent.height
                                    source: "../images/drops.svg"
                                    sourceSize: Qt.size(width, width)
                                    fillMode: Image.PreserveAspectFit
                                    anchors.verticalCenter: parent.verticalCenter
                                    visible: false
                                }
                                Rectangle {
                                    width: mask_drops.width
                                    height: parent.height
                                    color: Kirigami.Theme.textColor
                                    anchors.left: parent.left
                                    anchors.leftMargin: mask_drops.height*.3
                                    anchors.top: parent.top
                                    anchors.topMargin: mask_drops.height*.3
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: mask_drops
                                    }
                                }
                            }
                            Text {
                                height: parent.height*.3
                                text: " "
                                verticalAlignment: Text.AlignVCenter
                                anchors.left: parent.left
                                anchors.leftMargin: height*.5
                                color: Kirigami.Theme.textColor
                            }
                            Text {
                                height: parent.height*.3
                                width: parent.width*.8
                                color: Kirigami.Theme.textColor
                                verticalAlignment: Text.AlignVCenter
                                anchors.left: parent.left
                                anchors.leftMargin: height*.5
                                text: weatherData.probabilidadDeLLuvia + "%"
                            }
                        }

                    }
                }
            }
        }
    }
}
