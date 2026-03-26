{ pkgs, ... }:

{
  stylix = {
    enable = true;

    image = null;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    # override = {
    #   base00 = "181616"; # dragonBlack3  
    #   base01 = "0D0C0C"; # dragonBlack0 
    #   base02 = "1a1a19"; # dragonBlack2 
    #   base03 = "282727"; # dragonBlack5
    #   base04 = "625E5A"; # dragonGray 
    #   base05 = "C5C9C5"; # dragonWhite 
    #   base06 = "A6A69C"; # oldWhite   
    #   base07 = "C8C093"; # fujiWhite  
    #   base08 = "C4746E"; # dragonRed 
    #   base09 = "B6927B"; # dragonOrange
    #   base0A = "C4B28A"; # dragonYellow 
    #   base0B = "8A9A7B"; # dragonGreen 
    #   base0C = "8EA4A2"; # dragonTeal 
    #   base0D = "8BA4B0"; # dragonBlue2 
    #   base0E = "A292A3"; # dragonViolet 
    #   base0F = "E46876"; # peachRed    
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
