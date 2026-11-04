# Fedora bootc + Niri: An Immutable Desktop for Modest Hardware

*[Leer en Español](README.es.md)*

![My Niri Desktop Preview](NiriPreview-Desktop.png)

This repository documents the construction of a personalized, immutable, and ultralight operating system, specifically designed for an **HP 14-ck2xxx with an Intel Celeron N4020 and 8 GB of RAM**.

## Project Philosophy

The goal was to move away from heavy traditional desktop environments and create a **fault-tolerant** environment (thanks to `bootc` and OSTree) that maximizes limited hardware, prioritizing energy efficiency, security, and speed.

## System Architecture

- **Base:** Fedora `bootc` (Immutable OCI Image).
- **Compositor:** Niri (Wayland, tiling, infinite scroll).
- **Shell:** Noctalia (Ultralight status bar).
- **Terminal:** Kitty + Starship + Nushell/Bash.
- **Network:** AdGuard Home on Podman + Proton VPN.
- **Storage:** SSD (128GB) + HDD (1TB) fusion via `bind mounts` and Systemd.

## Deployment (Build & Switch)

To replicate this system, follow these steps:

1. Clone this repository.
2. Review the `bootc/Containerfile` and adjust packages to your hardware.
3. Build the image:
```bash
sudo podman build -t localhost/mi-niri-custom:latest .
    ```
4. Apply changes using `sudo bootc upgrade`.
5. Reboot the system.

## Technical Highlights

- **Robust HDD mounts:** Use of `home-binds.service` with `RequiresMountsFor` to prevent conflicts if the HDD is not connected at boot.
- **Portal conflict resolution:** Configuration of `niri-portals.conf` for Flatpak and screenshot support.
- **Automation:** Bash scripts for organizing downloads and managing the VPN.

## ⚠️ Known Issues

### Niri and `kmscon` Conflict on Fedora 45

**Report Date:** November 2026  
**Status:** Pending upstream fix (staying on Fedora 44 for stability).

With the update to Fedora 45, a critical failure was experienced when attempting to start Niri from the TTY. The system threw the error `Failed to open session: Function not implemented (os error 38)` and the screen became unresponsive.

**Cause:**
Fedora 45 introduced the default use of `kmscon` (a userspace graphical console) on TTYs. Unlike the traditional console (`fbcon`), `kmscon` takes exclusive control of the GPU's DRM/KMS device. This prevents Niri (via `libseat`) from initializing its graphical backend, causing a compositor panic.

**Applied Solution (Rollback):**
Since the base system is immutable (`bootc`), a successful rollback to Fedora 44 was performed using:

```bash
sudo bootc rollback
```

### Possible Workarounds (Untested in production)

For those wishing to test Fedora 45, it is suggested to disable `kmscon` and revert to the classic console (`getty`) by adding the following to the `Containerfile`:

```dockerfile
RUN systemctl mask kmsconvt@tty1.service kmsconvt@tty2.service
```

## Recovery Mode

If an update breaks the system (e.g., the known Niri and kmscon conflict in Fedora 45):

1. Reboot and hold Shift or Esc to enter GRUB.
2. Select the Fedora 44 entry.
3. If in TTY, run the rollback command:
```bash
sudo bootc rollback
    ```
4. Finally, reboot the system:
```bash
sudo reboot
```

## License

This project is licensed under the MIT License. Feel free to fork and adapt it to your own hardware.
