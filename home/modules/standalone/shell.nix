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

  '';
}
