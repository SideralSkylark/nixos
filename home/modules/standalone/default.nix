{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode # Visual Studio Code editor
    lazydocker # TUI for docker
    lazygit # TUI for git
    bruno # Open-source API client
    jdk21_headless # Java Development Kit
    nodejs_22 # Node.js runtime
    rustc # Rust compiler
    cargo # Rust package manager
  ];
}
