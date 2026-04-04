{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    vscode
    gemini-cli
    lazydocker
    lazygit
    hoppscotch
    jdk21_headless
    nodejs_22
    rustc
    cargo
    gcc
    python3
    (pkgs.writeShellScriptBin "java-stable" ''
      export JAVA_HOME=${pkgs.jdk21_headless}
      exec ${pkgs.jdk21_headless}/bin/java "$@"
    '')
  ];
}
