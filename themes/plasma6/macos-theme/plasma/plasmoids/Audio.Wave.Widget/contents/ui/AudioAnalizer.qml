import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.plasma.plasma5support as Plasma5Support



Item {

    property string codesByAudio: "0"
    property string numeros: codesByAudio.toString();
    property string updatescommand0: "$HOME/.local/share/plasma/plasmoids/Audio.Wave.Widget/contents/ui/Lib/audio_fft default"
    //property string updatescommand1: "bash $HOME/.local/share/plasma/plasmoids/Audio.Wave.Widget/contents/ui/Lib/Simp.sh"
    //property string updatescommand2:  "bash $HOME/.local/share/plasma/plasmoids/Audio.Wave.Widget/contents/ui/Lib/Simp-advance.sh"
    property string updatescommand: "bash $HOME/.local/share/plasma/plasmoids/Audio.Wave.Widget/contents/ui/Lib/ejecutor2.sh" // plasmoid.configuration.dataExtractionMethod === 0 ? updatescommand0 : plasmoid.configuration.dataExtractionMethod === 1 ? updatescommand1 : updatescommand2
    property int maxheight: 200
    property int minwid: 10
    property bool timerRepat: true
    property int frecu: 100
    property int numeromasaltoVar: numeroMasAlto()

    property int one: valoresFrecuencias(8,maxheight,minwid)
    property int two: valoresFrecuencias(6,maxheight,minwid)
    property int three: valoresFrecuencias(4,maxheight,minwid)
    property int four: valoresFrecuencias(2,maxheight,minwid)
    property int five: valoresFrecuencias(1,maxheight,minwid)
    property int six: valoresFrecuencias(3,maxheight,minwid)
    property int seven: valoresFrecuencias(5,maxheight,minwid)
    property int eight: valoresFrecuencias(7,maxheight,minwid)
    property int nine: valoresFrecuencias(8,maxheight,minwid)

    Plasma5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: updatescommand0
        onNewData: function(source, data) {
            disconnectSource(source)
        }


    }
    /***/
    Plasma5Support.DataSource {
        id: executable2
        engine: "executable"
        connectedSources: []
        onNewData: {
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            exited(exitCode, exitStatus, stdout, stderr)
            disconnectSource(sourceName) // cmd finished
        }
        function exec(cmd) {
            connectSource(cmd)
        }
        signal exited(int exitCode, int exitStatus, string stdout, string stderr)
    }

    Connections {
        target: executable2
        onExited: {
            codesByAudio = stdout.toString()
        }
    }
    function executeCommand() {
        executable2.exec(updatescommand)
    }
    ///*//

    function getPrimerNumero(texto, b) {
        var regexp = /(-?\d+(\.\d+)?)/g; // Expresión regular para encontrar números enteros, decimales y negativos
        var matches = texto.match(regexp); // Busca todos los números en la cadena
        if (matches && matches.length > 0) {
            return Number(matches[b]); // Devuelve el primer número encontrado
        } else {
            return 5;
        }
    }



    function numeroMasAlto(){
        const serieFull = {
            1 : getPrimerNumero(numeros, 1),
            2 : getPrimerNumero(numeros, 2),
            3 : getPrimerNumero(numeros, 3),
            4 : getPrimerNumero(numeros, 4),
            5 : getPrimerNumero(numeros, 5),
            6 : getPrimerNumero(numeros, 6),
            7 : getPrimerNumero(numeros, 7),
            8 : getPrimerNumero(numeros, 8),
            9 : getPrimerNumero(numeros, 9)
        };

        let maxNumber = -Infinity; // Inicializa el número máximo como menos infinito

        // Itera sobre los valores de la serie y encuentra el máximo
        for (let key in serieFull) {
            if (serieFull.hasOwnProperty(key)) {
                if (serieFull[key] > maxNumber) {
                    maxNumber = serieFull[key];
                }
            }
        }

        return maxNumber; // Devuelve el número más alto encontrado
    }

    function valoresFrecuencias(a,alto,ancho){
        var factor = 0
        var num = 0
        if (numeromasaltoVar < (getPrimerNumero(numeros, 9))*2) {
            var factor = alto/((getPrimerNumero(numeros, 9))*2)
        } else {
            var factor = alto/numeromasaltoVar
        }
        var num = getPrimerNumero(numeros, a)*factor

        if (num < ancho) {
            return ancho
        } else {
            return num
        }

    }


    Timer {
        id: timer
        interval: frecu
        running: true
        repeat: true
        onTriggered: {
            if (timerRepat == true) {
                executeCommand()
            }

        }
    }

}
