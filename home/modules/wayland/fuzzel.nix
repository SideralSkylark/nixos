{ ... }:
{
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    # ── Palette: Kanagawa Wave ─────────────────────────────────
    # sumiInk3   #1F1F28   surface / background
    # sumiInk6   #363646   subtle ui
    # overlay    #2A2A37   unified border
    # fujiWhite  #DCD7BA   primary text
    # oldWhite   #C8C093   secondary text
    # fujiGray   #727169   dimmed
    # waveBlue1  #2D4F67   selection background
    # springBlue #7E9CD8   match highlight
    # carpYellow #DCA561   selection match
    # oniViolet  #957FB8

    [main]
    font=JetBrainsMono Nerd Font Mono:size=14
    icon-theme=Papirus-Dark
    icons-enabled=yes
    terminal=kitty
    layer=overlay
    width=40
    lines=8
    horizontal-pad=24
    vertical-pad=12
    inner-pad=12

    [colors]
    background=1F1F28ff      # sumiInk3    — surface
    text=DCD7BAff            # fujiWhite   — primary text
    match=7E9CD8ff           # springBlue  — match highlight
    selection=2D4F67ff       # waveBlue1   — selection bg
    selection-text=DCD7BAff  # fujiWhite   — selected text
    selection-match=DCA561ff # carpYellow  — match within selection
    border=2A2A37ff          # overlay     — unified with Hyprland / Waybar / dunst

    [border]
    width=2
    radius=2

    [dmenu]
    exit-immediately-if-empty=yes
  '';
}
