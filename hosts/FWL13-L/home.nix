{ config, pkgs, ... }:

let
  waybarconfig = import ./modules/waybar.nix;
in
  {
    home.username = "sophie";
    home.homeDirectory = "/home/sophie";
  
    home.packages = with pkgs; [
      neofetch
    ];
  
    programs = {
      home-manager.enable = true;
      git = {
        enable = true;
        userEmail = "sophie@sophiecat.pw";
        userName = "Sophie";
      };
      waybar = {
        enable = true;
        settings = waybarconfig;
      };
    };
  
    home.file.".config/sway/config".source = ./modules/swayconfig;
  
    home.stateVersion = "23.11";
  }

