#!/bin/bash

echo " INICIANDO LIMPIEZA PROFUNDA DEL SISTEMA: $(date) "

# 1. Limpiar Podman (imágenes viejas, contenedores detenidos y caché de compilación)
echo "Limpiando imágenes y caché de Podman..."
sudo podman system prune -a -f
sudo podman image prune -a -f

# 2. Limpiar la versión de rollback de bootc (la versión anterior del sistema)
echo "Eliminando versión de respaldo del sistema operativo (bootc/ostree)..."
# El comando undeploy 1 borra el despliegue de índice 1 (el de respaldo)
sudo ostree admin undeploy 1 2>/dev/null || true
# Limpia los objetos huérfanos que hayan quedado
sudo ostree admin cleanup

# 3. Limpiar logs antiguos del sistema (dejando solo los últimos 50 MB)
echo "Limpiando logs del sistema (journal)..."
sudo journalctl --vacuum-size=50M

# 4. Limpiar la caché de DNF (aunque en bootc se limpia al compilar, nunca está de más)
echo "Limpiando caché de DNF..."
sudo dnf clean all

echo " LIMPIEZA FINALIZADA CON ÉXITO "
