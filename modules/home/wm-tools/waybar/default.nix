{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.wm-tools.waybar;
in {
  options.custom.wm-tools.waybar = with types; {
    enable = mkBoolOpt false "Whether or not to enable waybar.";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          height = 30;
          spacing = 4;
          modules-left = [ "sway/workspaces"
                           "sway/mode"
                           "sway/scratchpad"
                           "custom/media" ];
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
          "sway/scratchpad" = {
            format = "{icon} {count}";
            show-empty = false;
          };
          mpd = {
            format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
            
          };
        };
      };
    };
  };
}
