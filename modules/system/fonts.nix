{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans # Google Noto Sans CJK fonts
    ];
  };
}
