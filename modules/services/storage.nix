{
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
