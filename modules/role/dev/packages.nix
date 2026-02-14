{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        docker
        docker-compose
        vscode
		zed-editor
        lazydocker
        postman
        jdk21_headless
        nodejs_22
        jdt-language-server
        lua-language-server
        rustc
        cargo
        rust-analyzer

        (pkgs.writeShellScriptBin "java-stable" ''
            export JAVA_HOME=${pkgs.jdk21_headless}
            exec ${pkgs.jdk21_headless}/bin/java "$@"
        '')
    ];
}
