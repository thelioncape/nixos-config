{ config, pkgs, ... }:

{
  home.username = "sophie";
  home.homeDirectory = "/home/sophie";

  home.packages = with pkgs; [
    neofetch
  ];

  programs.git = {
    enable = true;
    userEmail = "sophie@sophiecat.pw";
    userName = "Sophie";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}

