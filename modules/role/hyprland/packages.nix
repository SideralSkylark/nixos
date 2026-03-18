{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
    gtk3
    mate.engrampa #thunar dosent come with file archiver
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman # auto-mount drives
      thunar-archive-plugin # context menu for zip/tar/etc
    ];
  };

  services.tumbler.enable = true;
}
