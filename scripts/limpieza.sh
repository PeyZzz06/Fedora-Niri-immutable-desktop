#!/bin/bash

# Script de limpieza para Fedora Bootc + Niri
echo "Iniciando limpieza del sistema..."

# 1. Vaciar papelera
gio trash --empty

# 2. Limpiar Flatpak (runtimes no usados)
flatpak uninstall --unused -y

# 3. Limpiar Podman (contenedores, imágenes y volúmenes no usados)
podman system prune -a --volumes -f

# 4. Limpiar rpm-ostree (implementaciones viejas y caché)
sudo rpm-ostree cleanup -bm

# 5. Limpiar caché de DNF
sudo dnf clean all

# 6. Reducir registros del sistema (logs) a 200 MB
sudo journalctl --vacuum-size=200M

echo "¡Limpieza completada!"
