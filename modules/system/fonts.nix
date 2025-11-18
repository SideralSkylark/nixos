{ pkgs, ... }:

{
    fonts = {
        enableDefaultPackages = true;
        fontconfig.enable = true;
        packages = with pkgs; [
            roboto
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-color-emoji
            jetbrains-mono
            nerd-fonts.jetbrains-mono
        ];
    };
}

