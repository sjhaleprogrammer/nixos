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
import "components" as Components

PlasmoidItem {
    id: root
    width: 450
    height: 150

    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: "NoBackground"

    property color widgetColor: "white"
    property string codelang: ((Qt.locale().name)[0]+(Qt.locale().name)[1])

    Components.WeatherData {
      id: weatherData
    }

    FontLoader {
      id: quicksand
      source: "../fonts/Quicksand-Regular.otf"
    }
    FontLoader {
      id: rubik
      source: "../fonts/Rubik-Bold.ttf"
    }

    function getDayWeekText(language, dayIndex) {
      const daysOfWeek = {
        es: ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"],
        en: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
        fr: ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"],
        it: ["Domenica", "Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato"],
        pt: ["Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira", "Sábado"],
        de: ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"],
        nl: ["Zondag", "Maandag", "Dinsdag", "Woensdag", "Donderdag", "Vrijdag", "Zaterdag"],
        sv: ["Söndag", "Måndag", "Tisdag", "Onsdag", "Torsdag", "Fredag", "Lördag"],
        da: ["Søndag", "Mandag", "Tirsdag", "Onsdag", "Torsdag", "Fredag", "Lørdag"],
        no: ["Søndag", "Mandag", "Tirsdag", "Onsdag", "Torsdag", "Fredag", "Lørdag"],
        fi: ["Sunnuntai", "Maanantai", "Tiistai", "Keskiviikko", "Torstai", "Perjantai", "Lauantai"],
        is: ["Sunnudagur", "Mánudagur", "Þriðjudagur", "Miðvikudagur", "Fimmtudagur", "Föstudagur", "Laugardagur"],
        pl: ["Niedziela", "Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota"],
        ro: ["Duminică", "Luni", "Marți", "Miercuri", "Joi", "Vineri", "Sâmbătă"],
        cs: ["Neděle", "Pondělí", "Úterý", "Středa", "Čtvrtek", "Pátek", "Sobota"],
        sk: ["Nedeľa", "Pondelok", "Utorok", "Streda", "Štvrtok", "Piatok", "Sobota"],
        hu: ["Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat"],
        hr: ["Nedjelja", "Ponedjeljak", "Utorak", "Srijeda", "Četvrtak", "Petak", "Subota"],
        sl: ["Nedelja", "Ponedeljek", "Torek", "Sreda", "Četrtek", "Petek", "Sobota"],
        lt: ["Sekmadienis", "Pirmadienis", "Antradienis", "Trečiadienis", "Ketvirtadienis", "Penktadienis", "Šeštadienis"],
        lv: ["Svētdiena", "Pirmdiena", "Otrdiena", "Trešdiena", "Ceturtdiena", "Piektdiena", "Sestdiena"],
        et: ["Pühapäev", "Esmaspäev", "Teisipäev", "Kolmapäev", "Neljapäev", "Reede", "Laupäev"],
        sq: ["E diel", "E hënë", "E martë", "E mërkurë", "E enjte", "E premte", "E shtunë"]

      };

      // Si el idioma está en el objeto, devuelve el día correspondiente; si no, devuelve en inglés por defecto.
      return daysOfWeek[language] ? daysOfWeek[language][dayIndex] : daysOfWeek["en"][dayIndex];
    }


    function getMonthText(language, monthIndex) {
      const months = {
        es: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
        en: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
        fr: ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"],
        it: ["Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"],
        pt: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"],
        de: ["Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"],
        nl: ["Januari", "Februari", "Maart", "April", "Mei", "Juni", "Juli", "Augustus", "September", "Oktober", "November", "December"],
        sv: ["Januari", "Februari", "Mars", "April", "Maj", "Juni", "Juli", "Augusti", "September", "Oktober", "November", "December"],
        da: ["Januar", "Februar", "Marts", "April", "Maj", "Juni", "Juli", "August", "September", "Oktober", "November", "December"],
        no: ["Januar", "Februar", "Mars", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Desember"],
        fi: ["Tammikuu", "Helmikuu", "Maaliskuu", "Huhtikuu", "Toukokuu", "Kesäkuu", "Heinäkuu", "Elokuu", "Syyskuu", "Lokakuu", "Marraskuu", "Joulukuu"],
        is: ["Janúar", "Febrúar", "Mars", "Apríl", "Maí", "Júní", "Júlí", "Ágúst", "September", "Október", "Nóvember", "Desember"],
        pl: ["Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"],
        ro: ["Ianuarie", "Februarie", "Martie", "Aprilie", "Mai", "Iunie", "Iulie", "August", "Septembrie", "Octombrie", "Noiembrie", "Decembrie"],
        cs: ["Leden", "Únor", "Březen", "Duben", "Květen", "Červen", "Červenec", "Srpen", "Září", "Říjen", "Listopad", "Prosinec"],
        sk: ["Január", "Február", "Marec", "Apríl", "Máj", "Jún", "Júl", "August", "September", "Október", "November", "December"],
        hu: ["Január", "Február", "Március", "Április", "Május", "Június", "Július", "Augusztus", "Szeptember", "Október", "November", "December"],
        hr: ["Siječanj", "Veljača", "Ožujak", "Travanj", "Svibanj", "Lipanj", "Srpanj", "Kolovoz", "Rujan", "Listopad", "Studeni", "Prosinac"],
        sl: ["Januar", "Februar", "Marec", "April", "Maj", "Junij", "Julij", "Avgust", "September", "Oktober", "November", "December"],
        lt: ["Sausis", "Vasaris", "Kovas", "Balandis", "Gegužė", "Birželis", "Liepa", "Rugpjūtis", "Rugsėjis", "Spalis", "Lapkritis", "Gruodis"],
        lv: ["Janvāris", "Februāris", "Marts", "Aprīlis", "Maijs", "Jūnijs", "Jūlijs", "Augusts", "Septembris", "Oktobris", "Novembris", "Decembris"],
        et: ["Jaanuar", "Veebruar", "Märts", "Aprill", "Mai", "Juuni", "Juuli", "August", "September", "Oktoober", "November", "Detsember"],
        sq: ["Janar", "Shkurt", "Mars", "Prill", "Maj", "Qershor", "Korrik", "Gusht", "Shtator", "Tetor", "Nëntor", "Dhjetor"]
      };

      // Si el idioma está en el objeto, devuelve el mes correspondiente; si no, devuelve en inglés por defecto.
      return months[language] ? months[language][monthIndex] : months["en"][monthIndex];
    }


    Column {
       id: wrapper
       width: parent.width < parent.height*3 ? parent.width : parent.height*3
       height: width/3
       anchors.centerIn: parent

       Item {
         width: hours.implicitWidth + separator.implicitWidth + minutes.implicitWidth
         height: parent.height*.8
         anchors.horizontalCenter: parent.horizontalCenter
         Row {
           width: parent.width
           height: parent.height
           Text {
             id: hours
             text: Qt.formatDateTime(new Date(), "h") < 12 ? Qt.formatDateTime(new Date(), "h") === 0 ? 12 : Qt.formatDateTime(new Date(), "h") : Qt.formatDateTime(new Date(), "h") - 12
             height: parent.height
             color: widgetColor
             font.family: rubik.name
             verticalAlignment: Text.AlignVCenter
             font.bold: true
             font.pixelSize: parent.height*.9
          }
          Text {
            id: separator
            text: ":"
            height: parent.height
            color: widgetColor
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pixelSize: parent.height*.9
          }
          Text {
            id: minutes
            text: Qt.formatDateTime(new Date(), "mm")
            height: parent.height
            color: widgetColor
            font.family: rubik.name
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pixelSize: parent.height*.9
          }
        }
      }
      Item {
        width: date.implicitWidth + currentDegrees.implicitWidth + probaOfRain.implicitWidth + height*2 + textContainer.spacing * 3 + height/8
        height: parent.height*.20
        anchors.horizontalCenter: parent.horizontalCenter
        Row {
          id: textContainer
          width: parent.width
          height: parent.height
          spacing: 5
          Text {
            id: date
            text: getDayWeekText(codelang, (new Date()).getDay()).substring(0, 3) + " " + getMonthText(codelang, Qt.formatDateTime(new Date(), "M") - 1 ) + " " + Qt.formatDateTime(new Date(), "d")
            font.family: quicksand.name
            height: parent.height
            font.pixelSize: height*.65
            color: widgetColor
            verticalAlignment: Text.AlignVCenter
          }
          Rectangle {
            id: circleSeparator
            color: widgetColor
            height: parent.height/8
            width: height
            radius: height
            anchors.verticalCenter: parent.verticalCenter
          }
          Image {
            id: maskIcon
            height: width
            width: parent.height*.9
            source: "../icons/" +  weatherData.iconWeatherCurrent + ".svg"
            sourceSize: Qt.size(width, width)
            fillMode: Image.PreserveAspectFit
            visible: false
          }
          Rectangle {
            width: parent.height*.9
            height: width
            color:  widgetColor
            anchors.verticalCenter: parent.verticalCenter
            layer.enabled: true
            layer.effect: OpacityMask {
              maskSource: maskIcon
            }
          }
          Text {
            id: currentDegrees
            text: weatherData.currentWeather+"°"
            font.family: quicksand.name
            color: widgetColor
            height: parent.height
            font.pixelSize: height*.65
            verticalAlignment: Text.AlignVCenter
          }
          Image {
            id: maskDrops
            height: width
            width: parent.height*.9
            source: "../icons/drops.svg"
            sourceSize: Qt.size(width, width)
            fillMode: Image.PreserveAspectFit
            visible: false
          }
          Rectangle {
            width: parent.height*.9
            height: width
            color:  widgetColor
            anchors.verticalCenter: parent.verticalCenter
            layer.enabled: true
            layer.effect: OpacityMask {
              maskSource: maskDrops
            }
          }
          Text {
            id: probaOfRain
            text: weatherData.probabilidadDeLLuvia + "%"
            font.family: quicksand.name
            color: widgetColor
            height: parent.height
            font.pixelSize: height*.65
            verticalAlignment: Text.AlignVCenter
          }
        }
      }
      Timer {
        id: timer
        interval: 8.64e+7-((new Date().getHours()*60*60*1000)+(new Date().getMinutes()*60*1000)+(new Date().getSeconds()*1000)+new Date().getMilliseconds())
        running: true
        repeat: true
        onTriggered: {
          date.text = getDayWeekText(codelang, (new Date()).getDay()).substring(0, 3) + " " + getMonthText(codelang, Qt.formatDateTime(new Date(), "M") - 1 ) + " " + Qt.formatDateTime(new Date(), "d")
          timer.interval = 8.64e+7
        }
      }
      Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: {
          hours.text = Qt.formatDateTime(new Date(), "h") < 12 ? Qt.formatDateTime(new Date(), "h") === 0 ? 12 : Qt.formatDateTime(new Date(), "h") : Qt.formatDateTime(new Date(), "h") - 12
          minutes.text = Qt.formatDateTime(new Date(), "mm")
        }
      }
   }
}
