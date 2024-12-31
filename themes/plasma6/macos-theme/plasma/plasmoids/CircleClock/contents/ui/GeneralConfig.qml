import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: configRoot

    signal configurationChanged

    property alias cfg_opacity: porcetageOpacity.value
    property alias cfg_customColor: colorHEX.text

    ColumnLayout {
        spacing: units.smallSpacing * 2

        GridLayout{
            columns: 2
            Label {
                Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
                text: i18n("Opacity:")
                horizontalAlignment: Text.AlignRight
            }

            SpinBox{
                id: porcetageOpacity

                from: 30
                to: 100
                stepSize: 10
                // suffix: " " + i18nc("pixels","px.")
            }
            Label {
                Layout.minimumWidth: Math.max(centerFactor * root.width, minimumWidth)
                text: i18n("Color HEX:")
                horizontalAlignment: Text.AlignRight
            }
            TextField {
                id: colorHEX
                width: 200
            }
        }
}

}
