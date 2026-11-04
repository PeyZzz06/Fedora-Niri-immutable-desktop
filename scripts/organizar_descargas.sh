#!/bin/bash

ORIGEN="/home/jairfed/Datos/Descargas"
DESTINO_IMGS="/home/jairfed/Datos/Imágenes"
DESTINO_DOCS="/home/jairfed/Datos/Documentos"
DESTINO_VIDS="/home/jairfed/Datos/Vídeos"
DESTINO_MUSIC="/home/jairfed/Datos/Música"

if [ ! -d "$ORIGEN" ]; then
    exit 0
fi

mv "$ORIGEN"/*.{jpg,jpeg,png,gif,bmp,svg,webp} "$DESTINO_IMGS/" 2>/dev/null
mv "$ORIGEN"/*.{pdf,doc,docx,txt,odt,xls,xlsx,ppt,pptx,csv,epub,zip,tar,gz,rar,7z,xz,deb,rpm,iso,sh} "$DESTINO_DOCS/" 2>/dev/null
mv "$ORIGEN"/*.{mp4,mkv,avi,mov,webm,flv} "$DESTINO_VIDS/" 2>/dev/null
mv "$ORIGEN"/*.{mp3,wav,flac,ogg,m4a} "$DESTINO_MUSIC/" 2>/dev/null

exit 0
