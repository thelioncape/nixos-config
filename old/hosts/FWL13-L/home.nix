{ config, pkgs, ... }:

let
  waybarconfig = import ./modules/waybar.nix;
in
  {
    home.username = "sophie";
    home.homeDirectory = "/home/sophie";

    fonts.fontconfig.enable = true;
  
    home.packages = with pkgs; [
      neofetch
      font-awesome
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
      wofi = {
        enable = true;
      };
      alacritty = {
        enable = true;
        settings = {
          window.decorations = "None";
          window.resize_increments = true;
        };
      };
      rbw = {
        enable = true;
        settings = {
          base_url = "https://vaultwarden.benstanderline.com";
          email = "ben@benstanderline.com";
          pinentry = "curses";
        };
      };
    };
  
    home.file.".config/sway/config".source = ./modules/swayconfig;
  
    home.stateVersion = "23.11";
  }

