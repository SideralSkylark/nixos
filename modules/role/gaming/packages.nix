{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        hydralauncher
    ]; 
}
