# NixOS Configuration
Personal NixOS setup using flakes and Home Manager, focused on a minimal Hyprland desktop and role-based system configuration.

---

## Screenshots

### Desktop (Hyprland + Stylix)
![Desktop](assets/screenshots/desktop.png)

### Terminal
![Terminal](assets/screenshots/fetch.png)

### Editor (Neovim / nixvim)
![Editor](assets/screenshots/editor.png)

---

## Structure
```
.
├── flake.nix
├── hosts/
│   ├── laptop/
│   └── nixos/
├── modules/
│   ├── role/
│   │   ├── bluetooth/
│   │   ├── dev/
│   │   ├── hyprland/
│   │   ├── printing/
│   │   └── gaming/
│   ├── services/
│   └── system/
├── home/
│   ├── skylark.nix
│   └── modules/
│       ├── default.nix   # layer 1 — core
│       ├── wayland/      # layer 2 — Wayland 
│       ├── hyprland/     # layer 3 — compositor
│       └── kde/          # layer 3 — Fedora HM
└── dotfiles/
```

---

## Home Manager

Home Manager configuration lives under `home/`.

### Three-layer architecture

Configuration is split into three independent layers. Each layer only depends on the ones below it.

| Layer | Location | Contents |
|-------|----------|----------|
| 1 — Core | `home/skylark.nix` + `home/modules/` | git, nixvim, shell, starship, xdg dirs. No GUI, no Wayland. |
| 2 — Wayland | `home/modules/wayland/` | kitty, waybar, swaync, fuzzel. Compositor-agnostic. |
| 3 — Compositor | `home/modules/hyprland/` or `kde/` | Imports layer 2. Only entry point the flake touches. |

The flake imports only layer 3. Layer 3 imports layer 2. Layer 1 has no knowledge of Wayland or Hyprland.

### Neovim
- Configured via **nixvim**
- Chosen mainly for easier LSP configuration
- Stylix control over nixvim is **disabled** — themed manually

### Theming
- **Stylix** handles system-wide theming
- Fonts declared in Stylix are not duplicated in `system/fonts.nix`
- Only `noto-fonts-cjk-sans` is declared separately (not covered by Stylix)

### Dotfiles
- Desktop ricing (bar, waybar, hyprland, etc.) lives in `dotfiles/`
- Dotfiles are **not written in Nix** (intentionally, for now)
- Imported via `xdg.configFile` in the relevant Home Manager module

---

## Hosts

Each host declares which roles it needs. Shared base configuration is imported from `modules/`.

### laptop
- Uses Fedora's GRUB to boot NixOS (NixOS GRUB disabled)
- Roles: `hyprland`, `dev`, `printing`, and `bluetooth`

### nixos
- Desktop machine
- Serves as a base for new machines
- `hardware-configuration.nix` should be replaced on a new system

---

## Modules

System-wide NixOS modules live under `modules/`.

### `modules/system/`
Core system configuration: nix settings, networking, fonts, timezone, security, packages, gc.

- Networking uses **NetworkManager** and **iwd** for the WiFi backend
- Had issues with dns and container on **iwd** and systemd network

### `modules/services/`
System services: audio, power, printing, scanning, ssh, storage.

### `modules/role/`
Reusable role-based configurations. Each host imports only the roles it needs.

| Role | Contents |
|------|----------|
| `hyprland` | `programs.hyprland`, greetd, Qt/GTK Wayland libs, Stylix |
| `dev` | Docker daemon, development tools |
| `bluetooth` | enables bluetooth and blueman for GUI |
| `printing` | Printing (CUPS, hplip, epson) and scanning (SANE) |
| `gaming` | Gaming-related configuration |

---

## Flake Inputs

| Input | Channel |
|-------|---------|
| nixpkgs | nixos-25.11 |
| home-manager | release-25.11 |
| stylix | release-25.11 |
| nixvim | nixos-25.11 |

---
## TODOS
-- make sure the screen can be projected
