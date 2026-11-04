#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: bajar_musica <URL>"
    exit 1
fi

echo "Descargando audio..."
yt-dlp -P "/home/jairfed/Datos/Descargas" -x --audio-format mp3 "$1"

echo "Organizando archivos..."
/home/jairfed/.local/bin/organizar_descargas.sh

echo "¡Música descargada y organizada en el HDD!"
