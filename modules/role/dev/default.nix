{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true; # enable Docker service
    enableOnBoot = false; # do not start automatically on boot
  };

  environment.systemPackages = with pkgs; [
    docker-compose # Multi-container orchestration
    vscode # Visual Studio Code editor
    gemini-cli # Gemini AI CLI tool
    lazygit # TUI for git
    bruno # Open-source API client (Postman alternative)
    jdk21_headless # Java Development Kit 21
    nodejs_24 # Node.js runtime
    google-java-format
    rustc # Rust compiler
    cargo # Rust package manager
    gcc # GNU Compiler Collection
    python3 # Python 3 interpreter
    (pkgs.writeShellScriptBin "java-stable" ''
      export JAVA_HOME=${pkgs.jdk21_headless}
      exec ${pkgs.jdk21_headless}/bin/java "$@"
    '') # Helper script for stable Java environment
  ];
}
