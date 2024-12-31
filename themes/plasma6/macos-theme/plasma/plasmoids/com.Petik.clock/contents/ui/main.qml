/*
    SPDX-FileCopyrightText: zayronxio
    SPDX-License-Identifier: GPL-3.0-or-later
*/
import QtQuick 2.12
import QtQuick.Layouts 1.12
import Qt5Compat.GraphicalEffects
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    property var fSize: plasmoid.configuration.fontSize
    property var sizeBunble: fSize*1.3
    property int firstday: plasmoid.configuration.dayInitial
    property string generalColor: Plasmoid.configuration.customColors

    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: "NoBackground"

    FontLoader {
    id: england
    source: "../fonts/england.ttf"
    }
    FontLoader {
    id: oswald
    source: "../fonts/Oswald-VariableFont_wght.ttf"
    }
    FontLoader {
    id: quicksand
    source: "../fonts/Quicksand-VariableFont_wght.ttf"
    }

     function abbreviate(text, maxLength) {
        if (text.length > maxLength) {
            return text.substring(0, maxLength) + "..."
        } else {
            return text
        }
     }
     function daysSem(b) {
             var numofdaysem = new Date().getDay()
             if (numofdaysem === b) {
                 var now = new Date()
                 return Qt.formatDateTime(now, "dddd")
            } else {
                 var now = new Date()
                 now.setDate(now.getDate() -numofdaysem+b)
                 return Qt.formatDateTime(now, "dddd")
            }
    }
    function asignatureday(u,x) {
        if ((u+x) === 7) {
            return 0
        }  else {
            if ((u+x) > 7) {
                return  (0 + ((u+x)-7))
            } else {
                return (u+x)
            }
        }
    }
    function trues(h,v) {
        if (v === "color") {
            if (new Date().getDay() === h) {
                 return generalColor
                    } else {
                        return "transparent"
                    }
        }
        if (v === "visible") {
            if (new Date().getDay() === h) {
                 return false
                    } else {
                        return true
                    }
        }
        if (v === "mask") {
            if (new Date().getDay() === h) {
                return true
                    } else {
                        return false
                    }
            }
        }


          fullRepresentation: Item {
              Layout.minimumWidth: datefull.width
              Layout.minimumHeight: datefull.height
              Layout.preferredWidth: Layout.minimumWidth
              Layout.preferredHeight: Layout.minimumHeight

              ColumnLayout {
              id:  datefull
              anchors.centerIn: parent
              Layout.minimumWidth: root.Layout.minimumWidth
              Layout.minimumHeight: root.Layout.minimumHeight
              Layout.preferredWidth: daysofsem.width
              Layout.preferredHeight: daysofsem.height
              spacing: 0
              Row {
                  id: daysofsem
                  width: fSize*13
                  height: sizeBunble
                  spacing: domingo.height/2
                  anchors.horizontalCenter: parent.horizontalCenter
                  Rectangle {
                      id: bubleDom
                      color: trues(firstday,"color")
                      width: sizeBunble
                      height: sizeBunble
                      radius: 100
                      layer.enabled: trues(firstday,"mask")
                      layer.effect: OpacityMask {
                              maskSource: domingo_mask
                              invert: true
                        }
                        Rectangle {
                        id: domingo_mask
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        visible: trues(firstday,"visible")
                  Kirigami.Heading {
                      id: domingo
                      anchors.horizontalCenter: parent.horizontalCenter
                      anchors.verticalCenter: parent.verticalCenter
                      text: (abbreviate(daysSem(firstday),1)).replace(/\.{3}/g, "")
                      color: generalColor
                      font.pixelSize: fSize
                      font.capitalization: Font.Capitalize
                      font.bold: true
                    }
                 }

                  }

                  Rectangle {
                      id: bubleLun
                      color: trues(asignatureday(firstday,1),"color")
                      width: sizeBunble
                      height: sizeBunble
                      radius: 100
                      layer.enabled: trues(asignatureday(firstday,1),"mask")
                      layer.effect: OpacityMask {
                              maskSource: lunes_mask
                              invert: true
                        }
                        Rectangle {
                        id: lunes_mask
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        visible: trues(asignatureday(firstday,1),"visible")
                  Kirigami.Heading {
                      id: lunes
                      anchors.horizontalCenter: parent.horizontalCenter
                      anchors.verticalCenter: parent.verticalCenter
                      text: (abbreviate(daysSem(asignatureday(firstday,1)),1)).replace(/\.{3}/g, "")
                      color: generalColor
                      font.pixelSize: fSize
                      font.capitalization: Font.Capitalize
                      font.bold: true
                    }
                 }
                  }
                  Rectangle {
                      id: bubleMar
                      color: trues(asignatureday((firstday+1),1),"color")
                      width: sizeBunble
                      height: sizeBunble
                      radius: 100
                      layer.enabled: trues(asignatureday((firstday+1),1),"mask")
                      layer.effect: OpacityMask {
                              maskSource: martes_mask
                              invert: true
                        }
                        Rectangle {
                        id: martes_mask
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        visible: trues(asignatureday((firstday+1),1),"visible")
                  Kirigami.Heading {
                      id: martes
                      anchors.horizontalCenter: parent.horizontalCenter
                      anchors.verticalCenter: parent.verticalCenter
                      text: (abbreviate(daysSem(asignatureday((firstday+1),1)),1)).replace(/\.{3}/g, "")
                      color: generalColor
                      font.pixelSize: fSize
                      font.capitalization: Font.Capitalize
                      font.bold: true
                    }
                 }
                  }
                  Rectangle {
                      id: bubleMie
                      color: trues(asignatureday((firstday+2),1),"color")
                      width: sizeBunble
                      height: sizeBunble
                      radius: 100
                      layer.enabled: trues(asignatureday((firstday+2),1),"mask")
                      layer.effect: OpacityMask {
                              maskSource: miercoles_mask
                              invert: true
                        }
                        Rectangle {
                        id: miercoles_mask
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        visible: trues(asignatureday((firstday+2),1),"visible")
                  Kirigami.Heading {
                      id: miercoles
                      anchors.horizontalCenter: parent.horizontalCenter
                      anchors.verticalCenter: parent.verticalCenter
                      text: (abbreviate(daysSem(asignatureday((firstday+2),1)),1)).replace(/\.{3}/g, "")
                      color: generalColor
                      font.pixelSize: fSize
                      font.capitalization: Font.Capitalize
                      font.bold: true
                    }
                 }
                  }
                  Rectangle {
                      id: bubleJue
                      color: trues(asignatureday((firstday+3),1),"color")
                      width: sizeBunble
                      height: sizeBunble
                      radius: 100
                      layer.enabled: trues(asignatureday((firstday+3),1),"mask")
                      layer.effect: OpacityMask {
                              maskSource: jueves_mask
                              invert: true
                        }
                        Rectangle {
                        id: jueves_mask
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        visible: trues(asignatureday((firstday+3),1),"visible")
                  Kirigami.Heading {
                      id: jueves
                      anchors.horizontalCenter: parent.horizontalCenter
                      anchors.verticalCenter: parent.verticalCenter
                      text: (abbreviate(daysSem(asignatureday((firstday+3),1)),1)).replace(/\.{3}/g, "")
                      color: generalColor
                      font.pixelSize: fSize
                      font.capitalization: Font.Capitalize
                      font.bold: true
                    }
                 }
                  }
                  Rectangle {
                      id: bubleVie
                      color: trues(asignatureday((firstday+4),1),"color")
                      width: sizeBunble
                      height: sizeBunble
                      radius: 100
                      layer.enabled: trues(asignatureday((firstday+4),1),"mask")
                      layer.effect: OpacityMask {
                              maskSource: viernes_mask
                              invert: true
                        }
                        Rectangle {
                        id: viernes_mask
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        visible: trues(asignatureday((firstday+4),1),"visible")
                  Kirigami.Heading {
                      id: viernes
                      anchors.horizontalCenter: parent.horizontalCenter
                      anchors.verticalCenter: parent.verticalCenter
                      text: (abbreviate(daysSem(asignatureday((firstday+4),1)),1)).replace(/\.{3}/g, "")
                      color: generalColor
                      font.pixelSize: fSize
                      font.capitalization: Font.Capitalize
                      font.bold: true
                    }
                 }
                  }
                  Rectangle {
                      id: bubleSab
                      color: trues(asignatureday((firstday+5),1),"color")
                      width: sizeBunble
                      height: sizeBunble
                      radius: 100
                      layer.enabled: trues(asignatureday((firstday+5),1),"mask")
                      layer.effect: OpacityMask {
                              maskSource: sabado_mask
                              invert: true
                      }
                  Rectangle {
                      id: sabado_mask
                      width: parent.width
                      height: parent.height
                      color: "transparent"
                      visible: trues(asignatureday((firstday+5),1),"visible")
                      Kirigami.Heading {
                          id: sabado
                          anchors.horizontalCenter: parent.horizontalCenter
                          anchors.verticalCenter: parent.verticalCenter
                          text: (abbreviate(daysSem(asignatureday((firstday+5),1)),1)).replace(/\.{3}/g, "")
                          font.pixelSize: fSize
                          color: generalColor
                          font.capitalization: Font.Capitalize
                          font.bold: true
                      }
                   }
                  }
                  Timer {
                      interval: 8.64e+7-((new Date().getHours()*60*60*1000)+(new Date().getMinutes()*60*1000)+(new Date().getSeconds()*1000)+new Date().getMilliseconds())
                      running: true
                      repeat: true
                      onTriggered: {
                          bubleDom.color = trues(firstday,"color")
                          bubleLun.color = trues(asignatureday(firstday,1),"color")
                          bubleMar.color = trues(asignatureday((firstday+1),1),"color")
                          bubleMie.color = trues(asignatureday((firstday+2),1),"color")
                          bubleJue.color = trues(asignatureday((firstday+3),1),"color")
                          bubleVie.color = trues(asignatureday((firstday+4),1),"color")
                          bubleSab.color = trues(asignatureday((firstday+5),1),"color")
                          bubleDom.layer.enabled = trues(firstday,"mask")
                          bubleLun.layer.enabled = trues(asignatureday(firstday,1),"mask")
                          bubleMar.layer.enabled = trues(asignatureday((firstday+1),1),"mask")
                          bubleMie.layer.enabled = trues(asignatureday((firstday+2),1),"mask")
                          bubleJue.layer.enabled = trues(asignatureday((firstday+3),1),"mask")
                          bubleVie.layer.enabled = trues(asignatureday((firstday+4),1),"mask")
                          bubleSab.layer.enabled = trues(asignatureday((firstday+5),1),"mask")
                          doming_mask.visible = trues(firstday,"visible")
                          lunes_mask.visible = trues(asignatureday(firstday,1),"visible")
                          martes_mask.visible = trues(asignatureday((firstday+1),1),"visible")
                          miercoles_mask.visible = trues(asignatureday((firstday+2),1),"visible")
                          jueves_mask.visible = trues(asignatureday((firstday+3),1),"visible")
                          viernes_mask.visible = trues(asignatureday((firstday+4),1),"visible")
                          sabado_mask.visible = trues(asignatureday((firstday+5),1),"visible")
                          lunes.text = (abbreviate(daysSem(asignatureday(firstday,1)),1)).replace(/\.{3}/g, "")
                          martes.text = (abbreviate(daysSem(asignatureday((firstday+1),1)),1)).replace(/\.{3}/g, "")
                          miercoles.text = (abbreviate(daysSem(asignatureday((firstday+2),1)),1)).replace(/\.{3}/g, "")
                          jueves.text = (abbreviate(daysSem(asignatureday((firstday+3),1)),1)).replace(/\.{3}/g, "")
                          viernes.text = (abbreviate(daysSem(asignatureday((firstday+4),1)),1)).replace(/\.{3}/g, "")
                          sabado.text = (abbreviate(daysSem(asignatureday((firstday+5),1)),1)).replace(/\.{3}/g, "")
                          domingo.text = (abbreviate(daysSem(firstday),1)).replace(/\.{3}/g, "")
                    }
                }
            }
        }
     }
}



