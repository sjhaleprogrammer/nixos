/*
 *  SPDX-FileCopyrightText: zayronxio
 *  SPDX-License-Identifier: GPL-3.0-or-later
 */
import org.kde.plasma.private.mpris as Mpris
import QtQuick 2.15

Item {

    Mpris.Mpris2Model {
        id: mpris2Model
    }

    property var artist: mpris2Model.currentPlayer?.artist ?? ""
    property var track: mpris2Model.currentPlayer?.track
    property var albumUrl: mpris2Model.currentPlayer?.artUrl
    property color predominantColor: "transparent"
    readonly property int playbackStatus: mpris2Model.currentPlayer?.playbackStatus ?? 0
    readonly property bool isPlaying: root.playbackStatus === Mpris.PlaybackStatus.Playing


    Image {
        id: image
        source: albumUrl
        visible: false
        onStatusChanged: {
            if (status === Image.Ready) {
                canvas.requestPaint();
            }
        }
    }

    Canvas {
        id: canvas
        width: image.width
        height: image.height
        visible: false
        onPaint: {
            var ctx = getContext('2d');
            ctx.drawImage(image, 0, 0);
            var imageData = ctx.getImageData(0, 0, width, height);
            var data = imageData.data;

            var colorCount = {};
            var maxColor = null;
            var maxCount = 0;

            // Define brightness range to filter colors
            var minBrightness = 0.2;
            var maxBrightness = 0.8;

            // Function to calculate brightness of a color
            function calculateBrightness(r, g, b) {
                var brightness = (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255;
                return brightness;
            }

            for (var i = 0; i < data.length; i += 4) {
                var r = data[i];
                var g = data[i + 1];
                var b = data[i + 2];
                var color = `rgb(${r},${g},${b})`; // Use RGB format for color key

                var brightness = calculateBrightness(r, g, b);

                // Only consider colors within the defined brightness range
                if (brightness >= minBrightness && brightness <= maxBrightness) {
                    if (colorCount[color]) {
                        colorCount[color]++;
                    } else {
                        colorCount[color] = 1;
                    }

                    if (colorCount[color] > maxCount) {
                        maxCount = colorCount[color];
                        maxColor = color;
                    }
                }
            }

            // Convert RGB color to HEX
            function rgbToHex(r, g, b) {
                var rgb = (r << 16) | (g << 8) | b;
                return "#" + ("000000" + rgb.toString(16)).slice(-6);
            }

            if (maxColor) {
                var rgb = maxColor.match(/\d+/g);
                var hexColor = rgbToHex(parseInt(rgb[0]), parseInt(rgb[1]), parseInt(rgb[2]));
                predominantColor = hexColor;
            }
        }
    }
}
