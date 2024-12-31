import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore


PlasmoidItem {
    id: root
    width: iconAndTem.width


    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground | PlasmaCore.Types.ConfigurableBackground
    preferredRepresentation: compactRepresentation

    property bool boldfonts: plasmoid.configuration.boldfonts
    property string temperatureUnit: plasmoid.configuration.temperatureUnit
    property string sizeFontConfg: plasmoid.configuration.sizeFontConfig


  compactRepresentation: CompactRepresentation {

  }
          fullRepresentation: FullRepresentation {
          }
          }
