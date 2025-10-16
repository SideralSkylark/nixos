{ config, pkgs, ... }:
{
    programs.bash = {
        enable = true;
        shellAliases = {
        btw = "echo i use nixos btw";
        };
    };

    programs.starship = {
        enable = true;
    };
}
