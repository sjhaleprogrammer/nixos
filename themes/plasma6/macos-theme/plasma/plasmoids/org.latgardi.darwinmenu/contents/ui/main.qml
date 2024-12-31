import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid

PlasmoidItem  {
    id: root

    Plasmoid.constraintHints: Plasmoid.CanFillArea

    readonly property string icon: plasmoid.configuration.useCustomButtonImage
        ? plasmoid.configuration.customButtonImage
        : plasmoid.configuration.icon

    property Window forceQuit

    preferredRepresentation: fullRepresentation
    compactRepresentation: null
    fullRepresentation: MainMenuButton {
            id: menuButton
            anchors.fill: parent
        }

    Component.onCompleted: {
        if (plasmoid.globalShortcut.toString().length === 0) {
            plasmoid.globalShortcut = "Meta+Alt+Escape"
        }

        const component = Qt.createComponent("ForceQuit/ForceQuit.qml")
        if (component.status !== Component.Ready) {
            if (component.status === Component.Error)
                console.debug("Error:" + component.errorString());
            return;
        }
        forceQuit = component.createObject(root)
    }

    Plasmoid.icon: root.icon
}


