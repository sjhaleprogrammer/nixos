import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root

    signal configurationChanged


    property alias cfg_frecuencyUpdates: frecuencyUpdate.value
    property alias cfg_customColorEnable: sistemColorCkeck.checked
    property alias cfg_customColorCodeRGB: customColorRGB.text
    property var cfg_colorize: sistemColorCkeck.checked ? cfg_customColorCodeRGB : Kirigami.Theme.TextColor

    ColumnLayout {
    id:mainColumn
    spacing: Kirigami.Units.largeSpacing
    Layout.fillWidth: true

    GridLayout{
        columns: 2

        Label {
            id: refrestitle
            Layout.minimumWidth: root.width/2
            text: i18n("AudioData refresh rate:")
            horizontalAlignment: Label.AlignRight
        }
        Row {
            Layout.minimumWidth: root.width/2
            height: refrestitle.implicitHeight
            Label {
                height: parent.height
                width: 30
                text: "10"
                font.bold: true
                verticalAlignment: Text.AlignVBottom
            }
            Slider {
                id: frecuencyUpdate
                width: parent.width*.3
                from: 10 // Valor mínimo del slider
                to: 150 // Valor máximo del slider
                stepSize: 10 // Incremento de paso del slider

            }
            Label {
                height: parent.height
                width: 30
                text: "150"
                font.bold: true
                verticalAlignment: Text.AlignVBottom
            }

        }
        Label {
        }
        Label {
        }
        Label {
            Layout.minimumWidth: root.width/2
            text: i18n("Custom color:")
            horizontalAlignment: Label.AlignRight
        }

        CheckBox{
            id: sistemColorCkeck
            text: i18n("")
        }
        Label {
            Layout.minimumWidth: root.width/2
            text: i18n("code color RGB:")
            horizontalAlignment: Label.AlignRight
        }
        TextField {
            id: customColorRGB
            width: 250
            enabled: sistemColorCkeck.checked
        }

    }
    }
}
