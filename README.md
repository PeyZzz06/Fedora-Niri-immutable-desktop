# Fedora bootc + Niri: Un escritorio inmutable para hardware modesto
![Vista previa de mi escritorio en Niri](NiriPreview-Desktop.png)
Este repositorio documenta la construcción de un sistema operativo personalizado, inmutable y ultraligero, diseñado específicamente para un **HP 14-ck2xxx con Intel Celeron N4020 y 8 GB de RAM**.

## Filosofía del Proyecto
El objetivo era abandonar los escritorios tradicionales pesados y crear un entorno **a prueba de fallos** (gracias a `bootc` y OSTree) que aproveche al máximo un hardware limitado, priorizando la eficiencia energética, la seguridad y la velocidad.

## Arquitectura del Sistema
- **Base:** Fedora `bootc` (Imagen OCI inmutable).
- **Compositor:** Niri (Wayland, tiling, scroll infinito).
- **Shell:** Noctalia (Barra de estado ultraligera).
- **Terminal:** Kitty + Starship + Nushell/Bash.
- **Red:** AdGuard Home en Podman + Proton VPN.
- **Almacenamiento:** Fusión SSD (128GB) + HDD (1TB) mediante `bind mounts` y Systemd.

## Despliegue (Build & Switch)
Para replicar este sistema, sigue estos pasos:
1. Clona este repositorio.
2. Revisa el archivo `bootc/Containerfile` y ajusta los paquetes a tu hardware.
3. Construye la imagen: `sudo podman build -t localhost/mi-niri-custom:latest .`
4. Aplica los cambios: `sudo bootc upgrade`
5. Reinicia el equipo.

## Características Técnicas Destacadas
- **Montajes de HDD robustos:** Uso de `home-binds.service` con `RequiresMountsFor` para evitar conflictos si el HDD no está conectado al arrancar.
- **Solución al conflicto de portales:** Configuración de `niri-portals.conf` para Flatpak y capturas de pantalla.
- **Automatización:** Scripts en Bash para organizar descargas y gestionar la VPN.

##  Modo Pánico (Recovery)
Si una actualización rompe el sistema (por ejemplo, el conflicto conocido entre Niri y `kmscon` en Fedora 45):
1. Reinicia y mantén pulsado `Shift` o `Esc` para entrar a GRUB.
2. Selecciona la entrada de **Fedora 44**.
3. Si estás en la TTY, ejecuta `sudo bootc rollback`.
4. Luego, ejecuta `sudo reboot`

## Licencia
Este proyecto está bajo la licencia MIT. Siéntete libre de hacer fork y adaptarlo a tu propio hardware.
