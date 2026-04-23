{
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    # Palette: Kanagawa
    # inkBlack   #0F1419   sumiInk3   #1F1F28   sumiInk6   #363646
    # fujiWhite  #DCD7BA   oldWhite   #C8C093   fujiGray   #727169
    # waveBlue1  #2D4F67   springBlue #7E9CD8   waveAqua   #7AA89F
    # carpYellow #DCA561   dragonGreen#98BB6C   oniViolet  #957FB8

    [main]
    font=JetBrainsMono Nerd Font Mono:size=14
    icon-theme=Papirus-Dark
    icons-enabled=yes
    terminal=kitty
    layer=overlay
    width=50
    lines=8
    horizontal-pad=24
    vertical-pad=12
    inner-pad=12

    [colors]
    background=1F1F28ff     # sumiInk3
    text=DCD7BAff           # fujiWhite
    match=7E9CD8ff          # springBlue  — readable against bg
    selection=2D4F67ff      # waveBlue1   — matches kitty selection + active tab
    selection-text=DCD7BAff # fujiWhite
    selection-match=DCA561ff # carpYellow — pops against waveBlue1 selection
    border=363646ff         # sumiInk6    — subtle, from palette

    [border]
    width=2
    radius=2

    [dmenu]
    exit-immediately-if-empty=yes
  '';
}
