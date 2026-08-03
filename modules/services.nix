{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  security.rtkit.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.power-profiles-daemon.enable = true;

  services.openssh.enable = false;
  programs.ssh = {
    startAgent = true;

    # include github ssh key on boot
    extraConfig = ''
      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519
        AddKeysToAgent yes
    '';
  };

  services.gvfs.enable = true; # both for auto mounting
  services.udisks2.enable = true;
  services.fstrim.enable = true; # ssd health

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
  };
}
