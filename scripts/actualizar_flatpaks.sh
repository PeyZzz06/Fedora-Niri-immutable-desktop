#!/bin/bash

# Registrar la fecha de inicio en el log
echo "--- Iniciando actualización de Flatpaks: $(date) ---" >> ~/.local/share/flatpak_update.log

# Actualizar todas las apps Flatpak
flatpak update -y >> ~/.local/share/flatpak_update.log 2>&1

# Limpiar versiones antiguas y runtimes no usados
flatpak uninstall --unused -y >> ~/.local/share/flatpak_update.log 2>&1

echo "--- Actualización finalizada: $(date) ---" >> ~/.local/share/flatpak_update.log
