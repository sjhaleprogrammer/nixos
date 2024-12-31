/*
 KWin - the KDE window manager
 This file is part of the KDE project.

 SPDX-FileCopyrightText: 2011 Martin Gräßlin <mgraesslin@kde.org>

 SPDX-License-Identifier: GPL-2.0-or-later
 */
import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami 2.20 as Kirigami
import org.kde.ksvg 1.0 as KSvg
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.kwin 3.0 as KWin

KWin.TabBoxSwitcher {
    id: tabBox

    currentIndex: icons.currentIndex

    PlasmaCore.Dialog {
        location: PlasmaCore.Types.Floating
        visible: tabBox.visible
        flags: Qt.X11BypassWindowManagerHint
        x: tabBox.screenGeometry.x + tabBox.screenGeometry.width * 0.5 - dialogMainItem.width * 0.5
        y: tabBox.screenGeometry.y + tabBox.screenGeometry.height * 0.5 - dialogMainItem.height * 0.8

        mainItem: ColumnLayout {
            id: dialogMainItem
            spacing: Kirigami.Units.smallSpacing * 2

            width: Math.min(Math.max(icons.delegateWidth, icons.implicitWidth), tabBox.screenGeometry.width * 0.9) + Kirigami.Units.largeSpacing * 2
            height: icons.delegateHeight + Kirigami.Units.largeSpacing * 2
            ListView {
                id: icons

                readonly property int iconSize: Kirigami.Units.iconSizes.huge * 1.5
                readonly property int delegateWidth: iconSize +  Kirigami.Units.largeSpacing * 4
                readonly property int delegateHeight: iconSize + Kirigami.Units.largeSpacing * 4

                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: tabBox.screenGeometry.width * 0.9

                implicitWidth: contentWidth
                implicitHeight: delegateWidth

                focus: true
                orientation: ListView.Horizontal

                model: tabBox.model
                delegate: Item{

                    width: icons.delegateHeight
                    height: icons.delegateWidth

                    Kirigami.Icon {
                        property string caption: model.caption

                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: Kirigami.Units.smallSpacing * 2
                        }

                        width:  icons.iconSize // delegateHeight
                        height: icons.iconSize // delegateWidth

                        source: model.icon
                        // active: index == icons.currentIndex

                        TapHandler {
                            onSingleTapped: {
                                if (index === icons.currentIndex) {
                                    icons.model.activate(index);
                                    return;
                                }
                                icons.currentIndex = index;
                            }
                            onDoubleTapped: icons.model.activate(index)
                        }
                    }

                    PlasmaComponents3.Label {
                        id: textItem
                        width: parent.width - Kirigami.Units.smallSpacing*2
                        text: {
                            var program = (model.caption).split('—')[1]
                            return (program) ? program : (model.caption).split('-').pop()
                        }
                        height: paintedHeight
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        font.weight: icons.currentIndex === index ? Font.Bold : Font.Normal
                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: Kirigami.Units.smallSpacing
                        }
                    }

                }

                highlight: KSvg.FrameSvgItem {
                    id: highlightItem
                    imagePath: "widgets/viewitem"
                    prefix: "hover"
                    width: icons.iconSize + margins.left + margins.right
                    height: icons.iconSize + margins.top + margins.bottom
                }

                highlightMoveDuration: 0
                highlightResizeDuration: 0
                boundsBehavior: Flickable.StopAtBounds
            }

            Connections {
                target: tabBox
                function onCurrentIndexChanged() {
                    icons.currentIndex = tabBox.currentIndex;
                }
            }

            /*
            * Key navigation on outer item for two reasons:
            * @li we have to emit the change signal
            * @li on multiple invocation it does not work on the list view. Focus seems to be lost.
            **/
            Keys.onPressed: event => {
                                if (event.key == Qt.Key_Left) {
                                    icons.decrementCurrentIndex();
                                } else if (event.key == Qt.Key_Right) {
                                    icons.incrementCurrentIndex();
                                }
                            }
        }
    }
}
