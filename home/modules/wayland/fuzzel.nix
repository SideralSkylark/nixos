{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font Mono:size=14";
        icon-theme = "Papirus-Dark";
        terminal = "kitty";
        layer = "overlay";
        width = 40;
        lines = 8;
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
    };
  };
}
