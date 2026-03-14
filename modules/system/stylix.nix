{ pkgs, ... }:

{
  stylix = {
    enable = true;

    image = null;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    # override = {
    #   base00 = "181616"; # dragonBlack3  — bg principal
    #   base01 = "0D0C0C"; # dragonBlack0  — bg mais escuro
    #   base02 = "1a1a19"; # dragonBlack2  — overlay
    #   base03 = "282727"; # dragonBlack5  — superfície
    #   base04 = "625E5A"; # dragonGray    — muted/comentários
    #   base05 = "C5C9C5"; # dragonWhite   — foreground
    #   base06 = "A6A69C"; # oldWhite      — foreground dim
    #   base07 = "C8C093"; # fujiWhite     — bright text
    #   base08 = "C4746E"; # dragonRed     — red/error
    #   base09 = "B6927B"; # dragonOrange  — orange
    #   base0A = "C4B28A"; # dragonYellow  — yellow
    #   base0B = "8A9A7B"; # dragonGreen   — green
    #   base0C = "8EA4A2"; # dragonTeal    — cyan
    #   base0D = "8BA4B0"; # dragonBlue2   — blue
    #   base0E = "A292A3"; # dragonViolet  — purple
    #   base0F = "E46876"; # peachRed      — bright red
    # };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        terminal = 13;
        desktop = 11;
        popups = 10;
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };
}
