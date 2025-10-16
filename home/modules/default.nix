{config, pkgs, ... }:
{
    imports = [
        ./git.nix
        ./packages.nix
        ./polkit.nix
        ./programs.nix
        ./stylix.nix
    ];
}
