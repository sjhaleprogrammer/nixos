import QtQuick 2.15
import QtQuick.Controls 2.15
import "../js/traductor.js" as Traduc
import "../js/GetInfoApi.js" as GetInfoApi
import "../js/geoCoordinates.js" as GeoCoordinates


Item {
  signal dataChanged // Definir el signal aquí

  function obtener(texto, indice) {
    var palabras = texto.split(/\s+/); // Divide el texto en palabras utilizando el espacio como separador
    return palabras[indice - 1]; // El índice - 1 porque los índices comienzan desde 0 en JavaScript
  }

  function fahrenheit(temp) {
    if (temperatureUnit == 0) {
      return temp;
    } else {
      return Math.round((temp * 9 / 5) + 32);
    }
  }

  property string useCoordinatesIp: plasmoid.configuration.useCoordinatesIp
  property string latitudeC: plasmoid.configuration.latitudeC
  property string longitudeC: plasmoid.configuration.longitudeC
  property string temperatureUnit: plasmoid.configuration.temperatureUnit

  property string latitude: (useCoordinatesIp === "true") ? latitudeIP : (latitudeC === "0") ? latitudeIP : latitudeC
  property string longitud: (useCoordinatesIp === "true") ? longitudIP : (longitudeC === "0") ? longitudIP : longitudeC

  property var observerCoordenates: latitude + longitud

  property string datosweather: "0"

  property string temperaturaActual: fahrenheit(obtener(datosweather, 1))
  property string codeleng: ((Qt.locale().name)[0] + (Qt.locale().name)[1])
  property string codeweather: obtener(datosweather, 2)
  property string iconWeatherCurrent: asingicon(codeweather, "preciso")

  property string weatherLongtext: Traduc.weatherLongText(codeleng, codeweather)
  property string weatherShottext: Traduc.weatherShortText(codeleng, codeweather)

  property string completeCoordinates: ""
  property string latitudeIP: completeCoordinates.substring(0, (completeCoordinates.indexOf(' ')) - 1)
  property string longitudIP: completeCoordinates.substring(completeCoordinates.indexOf(' ') + 1)

  property int isDay: obtener(datosweather, 3)
  property string prefixIcon: isDay === 1 ? "" : "-night"

  Component.onCompleted: {
    updateWeather(2);
  }



  function getCoordinatesWithIp() {
    GeoCoordinates.obtenerCoordenadas(function(result) {
      completeCoordinates = result;
    });
  }


  function getWeatherApi() {
    GetInfoApi.obtenerDatosClimaticos(latitude, longitud, function(result) {
      datosweather = result;
      checkDataReady(); // Verifica si los datos están listos después de obtener los datos del clima
    });
  }

  function asingicon(x, b) {
    let wmocodes = {
      0: "clear",
      1: "few-clouds",
      2: "few-clouds",
      3: "clouds",
      51: "showers-scattered",
      53: "showers-scattered",
      55: "showers-scattered",
      56: "showers-scattered",
      57: "showers-scattered",
      61: "showers",
      63: "showers",
      65: "showers",
      66: "showers-scattered",
      67: "showers",
      71: "snow-scattered",
      73: "snow",
      75: "snow",
      77: "hail",
      80: "showers",
      81: "showers",
      82: "showers",
      85: "snow-scattered",
      86: "snow",
      95: "storm",
      96: "storm",
      99: "storm",
    };
    var iconName = "weather-" + (wmocodes[x] || "unknown");
    var iconNamePresicion = iconName + prefixIcon
    return b === "preciso" ? iconNamePresicion : iconName;
  }

  function updateWeather(x) {
    getWeatherApi();
    if (x === 2) {
      //getCityFuncion();
      //getForecastWeather();
      if (useCoordinatesIp === "true") {
        getCoordinatesWithIp();
      } else {
        if (latitudeC === "0" || longitudC === "0") {
          getCoordinatesWithIp();
        }
      }
    }
  }

  function checkDataReady() {
    // Verificar si forecastWeather y datosweather están disponibles
    if (datosweather !== "0") {
      dataChanged(); // Emitir el signal dataChanged cuando los datos estén listos
    }
  }

  Timer {
    id: weatherupdate
    interval: 900000
    running: true
    repeat: true
    onTriggered: {
      updateWeather(1);
    }
  }

  onObserverCoordenatesChanged: updateWeather(2)
}

