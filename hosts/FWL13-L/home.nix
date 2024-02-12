{ config, pkgs, ... }:

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
      settings = {
        mainBar = {
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
          "sway/mode".format = "<span style=\"italic\">{}</span>";
          mpd = {
            format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) (({songPosition}|{queueLength})) {volume}% ";
          };
        };
      };
    };
  };

  home.file.".config/sway/config".source = ./hosts/FWL13-L/modules/swayconfig;

  home.stateVersion = "23.11";
}

