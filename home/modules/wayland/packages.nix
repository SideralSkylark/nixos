{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.wayland = {
    manageBrightnessctl = lib.mkEnableOption "Install brightnessctl via Nix";
    manageClipboard = lib.mkEnableOption "Install clipboard tools via Nix";
  };

  config.home.packages =
    with pkgs;
    [
      pamixer
      playerctl
      grim
      slurp
      swappy
      bluetui
      imv
      cliphist
      yazi
    ]
    ++ lib.optionals config.wayland.manageBrightnessctl [ brightnessctl ]
    ++ lib.optionals config.wayland.manageClipboard [ wl-clipboard ];
}
