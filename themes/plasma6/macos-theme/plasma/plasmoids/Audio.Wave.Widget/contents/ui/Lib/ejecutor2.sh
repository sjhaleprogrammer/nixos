#!/bin/bash

# Ejecutar el comando y limpiar la salida
output="$($HOME/.local/share/plasma/plasmoids/Audio.Wave.Widget/contents/ui/Lib/capturador 2>/dev/null)"

# Extraer los valores para cada rango de frecuencia
valores=$(echo "$output" | grep "Frecuencia:" | awk '{print $NF}')

# Concatenar los valores con un separador de espacio
resultado=$(echo "$valores" | tr '\n' ' ')

# Mostrar el resultado final
echo "$resultado"
