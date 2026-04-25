{ ... }:
{
  xdg.configFile."fuzzel/fuzzel.ini".text = ''
    # ── Palette: Everforest Hard Dark ──────────────────────────
    # bg-base      #272E33   surface / background
    # bg-overlay   #374145   unified border
    # fg-default   #D3C6AA   primary text
    # fg-muted     #7A8478   dimmed
    # selection    #425047   selection background
    # accent-blue  #7FBBB3   match highlight
    # accent-gold  #E69875   selection match
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
    background=272E33ff      # bg-base      — surface
    text=D3C6AAff            # fg-default   — primary text
    match=7FBBb3ff           # accent-blue  — match highlight
    selection=425047ff       # selection    — selection bg
    selection-text=D3C6AAff  # fg-default   — selected text
    selection-match=E69875ff # accent-gold  — match within selection
    border=374145ff          # bg-overlay   — unified with Hyprland / Waybar / dunst
    [border]
    width=2
    radius=2
    [dmenu]
    exit-immediately-if-empty=yes
  '';
}
