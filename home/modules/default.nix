{config, pkgs, ... }:
{
    imports = [
        ./git.nix
		./nixvim.nix
        ./packages.nix
        ./polkit.nix
        ./programs.nix
        ./stylix.nix
    ];
}
