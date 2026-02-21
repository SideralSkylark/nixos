{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    vscode
    zed-editor
    lazydocker
    lazygit
    postman
    jdk21_headless
    nodejs_22
    rustc
    cargo

    (pkgs.writeShellScriptBin "java-stable" ''
      export JAVA_HOME=${pkgs.jdk21_headless}
      exec ${pkgs.jdk21_headless}/bin/java "$@"
    '')
  ];
}
