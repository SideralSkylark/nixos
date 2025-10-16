{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Skylark";
    userEmail = "sidikebrahimserage@gmail.com";
  };
}
