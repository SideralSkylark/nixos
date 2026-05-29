{ nixvim, ... }:
{
  imports = [
    nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    imports = [
      ./options.nix
      ./keymaps.nix
      ./plugins.nix
      ./lsp.nix
    ];
  };
}
