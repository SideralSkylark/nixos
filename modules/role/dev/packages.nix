{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        docker
        docker-compose
        stow
        vscode
		zed-editor
        lazydocker
        posting
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
