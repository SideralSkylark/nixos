# NixOS Configuration

A modular NixOS and Home Manager configuration. 

---

## Architecture

### System Roles (`modules/role/`)
Hosts select from reusable roles to ensure lean installations:
- **hyprland**: Tiling compositor, greetd (tuigreet), and Wayland compatibility.
- **dev**: Docker, build tools, and essential CLI utilities.
- **gaming**: Steam, Heroic, Lutris, and performance optimizations.
- **bluetooth**: Bluetooth stack and management tools.
- **printing**: CUPS with HP/Epson drivers and SANE scanning.

### User Layers (`home/`)
Modular Home Manager environment:
- **Core**: Fundamental CLI tools, Git, Starship, and XDG directories.
- **Wayland**: Compositor-agnostic utilities (Kitty, Waybar, Dunst, Fuzzel).
- **Compositor**: Hyprland-specific logic and scripts.
- **Nixvim**: Modular Neovim configuration via `nixvim`.
- **Standalone**: Desktop-agnostic tools for non-NixOS systems.

---

## Key Features

- **Theming**: **Stylix** manages the base color palette (Everforest) and fonts centrally. Manual control is retained for Dunst, Kitty, Fuzzel, and Nixvim for granular styling.
- **Declarative Editor**: Neovim is configured via **nixvim**, split into logical modules (`plugins.nix`, `lsp.nix`, etc.).
- **Hybrid Configuration**: Core system state is managed by Nix, while specific application styles (Waybar CSS, Hyprland scripts) are symlinked from `dotfiles/` for portability.
- **Boot Management**: 
  - **laptop**: Uses `systemd-boot` with EFI variable modifications disabled to coexist with external bootloaders.
  - **nixos**: Standard `systemd-boot` with full EFI management.

---

## Directory Structure

```text
.
├── flake.nix             # Flake entry point and host definitions
├── hosts/                # Machine-specific configurations
├── modules/              # NixOS system-level modules (roles, services, system)
├── home/                 # Home Manager modules (nixvim, wayland, hyprland)
├── dotfiles/             # External configs symlinked via Home Manager
└── assets/               # Screenshots 
```

---

## Installation & Usage

### NixOS
```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

### Standalone Home Manager
```bash
home-manager switch --flake .#skylark
```

---

## Screenshots

### Desktop
![Desktop](assets/screenshots/desktop.png)

### Terminal
![Terminal](assets/screenshots/fetch.png)

### Editor
![Editor](assets/screenshots/editor.png)

--- 

## Todo 
- fix waybar power script options (logout dosent work at the moment)
- clean up old hyprland configs 

