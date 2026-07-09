{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font Mono:size=14";
        icon-theme = "Papirus-Dark";
        icons-enabled = true;
        terminal = "footclient";
        layer = "overlay";
        width = 40;
        lines = 8;
        horizontal-pad = 24;
        vertical-pad = 12;
        inner-pad = 12;
      };
      colors = {
        background = "272E33ff";
        text = "D3C6AAff";
        match = "7FBBB3ff";
        selection = "425047ff";
        selection-text = "D3C6AAff";
        selection-match = "E69875ff";
        border = "374145ff";
      };
      border = {
        width = 2;
        radius = 0;
      };
      dmenu = {
        exit-immediately-if-empty = true;
      };
    };
  };
}
