{ config, pkgs, ... }:

{
  home.username = "sophie";
  home.homeDirectory = "/home/sophie";

  home.packages = with pkgs; [
    neofetch
  ];

  programs = {
    git = {
      enable = true;
      userEmail = "sophie@sophiecat.pw";
      userName = "Sophie";
    };
    waybar = {
      enable = true;
      settings = {
        height = 30;
        spacing = 4;
        modules-left = [ "sway/workspaces" "sway/mode" "sway/scratchpad" "custom/media" ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "mpd"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "keyboard-state"
          "sway/language"
          "battery"
          "battery#bat2"
          "clock"
          "tray"
        ];
        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };
      };
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}

