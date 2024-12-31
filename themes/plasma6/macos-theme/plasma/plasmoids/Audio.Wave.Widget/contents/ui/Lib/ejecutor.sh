#!/bin/bash
command="$($HOME/.local/share/plasma/plasmoids/Audio.Wave.Widget/contents/ui/Lib/capturador 2>/dev/null | grep "Frecuencia:" | sed 's/Frecuencia://g' | sed 's/ dB//g' )"
elimEtiquetas="$(echo "$command" | sed 's/20 Hz - 513 Hz: //g' | sed 's/513 Hz - 1006 Hz: //g' | sed 's/1006 Hz - 1499 Hz: //g' | sed 's/1500 Hz - 8600 Hz: //g' | sed 's/8600 Hz - 15700 Hz: //g' | sed 's/15700 Hz - 22800 Hz: //g'  | sed 's/22800 Hz - 29900 Hz: //g' | sed 's/29900 Hz - 37000 Hz: //g' | sed 's/37000 Hz - 44100 Hz: //g')"
elimSaltos="$(echo "$elimEtiquetas" | sed ':a;N;$!ba;s/\n/ /g' )"
echo "$elimSaltos"
