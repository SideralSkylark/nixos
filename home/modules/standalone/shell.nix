{
  home.sessionVariables = {
    PATH = "$HOME/.nix-profile/bin:$PATH";
  };

  programs.bash.initExtra = ''
    # ---- Nix (standalone install fix) ----
    export PATH="$HOME/.nix-profile/bin:$PATH"

    # Home Manager session vars
    if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    fi

    # Rust
    if [ -e "$HOME/.cargo/env" ]; then
      . "$HOME/.cargo/env"
    fi

    # Android / custom tools
    export PATH="$HOME/.npm-global/bin:$PATH"
    export JAVA_HOME="$HOME/Apps/android-studio/jbr"
    export PATH="$JAVA_HOME/bin:$PATH"

    export ANDROID_HOME="$HOME/Android/Sdk"
    export NDK_HOME="$ANDROID_HOME/ndk/30.0.14904198"
    export PATH="$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH"
  '';
}
