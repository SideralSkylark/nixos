{
  services.openssh.enable = true;
  programs.ssh = {
    startAgent = true;

    # iclude github ssh key on boot
    extraConfig = ''
      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519
        AddKeysToAgent yes
    '';
  };
}
