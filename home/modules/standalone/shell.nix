{
  programs.bash.initExtra = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi

      # Rust
    if [ -e "$HOME/.cargo/env" ]; then
      . "$HOME/.cargo/env"
    fi

    export PATH="$HOME/.npm-global/bin:$PATH"
    export JAVA_HOME="$HOME/Downloads/apps/android-studio/jbr"
     export PATH="$JAVA_HOME/bin:$PATH"
    export PATH="$HOME/.npm-global/bin:$PATH"
    export ANDROID_HOME="$HOME/Android/Sdk"
    export NDK_HOME="$ANDROID_HOME/ndk/29.0.13846066"
    export PATH="$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH"
  '';
}
