{ pkgs, ... }:
{
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nodejs_24
    jdk25
    google-java-format
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    lazygit
    tmux
    obsidian
  ];

  home.sessionVariables = {
    JAVA_HOME = "$HOME/Apps/android-studio/jbr";
    ANDROID_HOME = "$HOME/Android/Sdk";
    NDK_HOME = "$HOME/Android/Sdk/ndk/30.0.14904198";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.npm-global/bin"
    "$HOME/Apps/android-studio/jbr/bin"
    "$HOME/Android/Sdk/ndk/30.0.14904198/toolchains/llvm/prebuilt/linux-x86_64/bin"
  ];
}
