import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: configRoot




    signal configurationChanged


    property alias cfg_colorHex: colorhex.text

    ColumnLayout {
        Layout.fillWidth: true

        GridLayout{
            columns: 2
            Label {
                Layout.minimumWidth: root.width/2
                horizontalAlignment: Label.AlignRight
                text: i18n("Color")
            }
            TextField {
                id: colorhex
                width: 100
            }
        }
   }
}
