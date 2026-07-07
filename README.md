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

## Proposed Maintenance & Simplification Plan

To thin down the configuration, reduce moving parts, and make the repository easier to maintain long-term, the following improvements are recommended:

1. **Consolidate Micro-Modules (Avoid Over-Modularization)**
   * **System modules**: Merge all individual files under `./modules/system/` (`gc.nix`, `networking.nix`, `timezone.nix`, `nix.nix`, `packages.nix`, `fonts.nix`, `security.nix`, `stylix.nix`) into a unified `./modules/system/default.nix`.
   * **Service modules**: Merge all individual files under `./modules/services/` (`audio.nix`, `power.nix`, `gpg.nix`, `ssh.nix`, `storage.nix`) into a single `./modules/services/default.nix`.
   * **Home Manager Core modules**: Merge `./home/modules/git.nix`, `./home/modules/packages.nix`, and `./home/modules/programs.nix` into `./home/modules/core.nix` (or inline them into `./home/skylark.nix`).
   * *Why:* Reduces file count by ~13 files, removes boilerplate imports, and keeps settings easier to locate and edit in one place.

2. **Inline Host-Specific Boot Configurations**
   * Inline `./hosts/laptop/boot.nix` and `./hosts/nixos/boot.nix` directly into their respective host `./hosts/<hostname>/configuration.nix` files, then delete the separate `boot.nix` files.
   * *Why:* These files are extremely small (6 lines each) and configure host-specific, non-reusable options. Inlining them removes two redundant files and reduces directory navigation.

3. **Eliminate Custom Wayland Option Flags (Over-Engineering)**
   * Remove custom options like `wayland.manageKittyPackage`, `wayland.manageWaybarPackage`, `wayland.manageBrightnessctl`, and `wayland.manageClipboard` defined in `./home/modules/wayland/`.
   * *Why:* The configuration files (e.g. `kitty.conf`) are symlinked unconditionally, so disabling these options doesn't decouple configurations. Defining custom flags to conditionally toggle individual package installs adds complexity (`lib.mkIf`, `lib.optionals`) for little value.
   * *Alternative:* Use standard idiomatic Nix modules. For instance, if a user profile wants Kitty, it imports `./home/modules/wayland/kitty.nix` which contains both the package definition and its config symlink.

4. **De-duplicate Hyprland Configurations in Standalone Profile**
   * Avoid copy-pasting the Hyprland `xdg.configFile` blocks and shared package listings (e.g., `wbg`, `nwg-displays`, `pavucontrol`, `jq`) between `./home/modules/hyprland/packages.nix` and `./home/modules/standalone/default.nix`.
   * *Why:* Keeping these lists duplicated leads to configuration drift.
   * *Alternative:* Refactor the shared components into a common helper module (e.g. `hyprland-base.nix`) or have the standalone profile import the Hyprland packages/configs module directly.

5. **Clean up Redundant Service/Group Declarations**
   * In `./modules/role/dev/packages.nix`, remove `docker` from `environment.systemPackages`. It is already enabled via `virtualisation.docker.enable = true` in `./modules/role/dev/docker.nix`, which automatically adds the client binary to system path.
   * In `./modules/role/dev/docker.nix`, remove the manual declaration of `users.groups.docker = { };` as the NixOS virtualization service creates this group automatically.

6. **Simplify Flake Host Definitions**
   * Move the shared `hmModules` imports (`./home/modules/hyprland` and `./home/modules/nixvim`) out of the `flake.nix` host declarations and directly into `./home/skylark.nix` (since both hosts import `skylark.nix`).
   * *Why:* Keeps `flake.nix` lean and focused on top-level system architecture rather than repeating user configuration modules.

--- 

## Todo 
- better nvim experience whatever that means
- consider removing tools that i didnot use in the past 3 months from the config


