{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lazydocker # TUI for docker
    lazygit # TUI for git
    bruno # Open-source API client
    gcc # GNU Compiler Collection
  ];
}
