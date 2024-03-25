{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.wm-tools.hyprland;
in {
  options.custom.wm-tools.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable hyprland.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        "$terminal" = "kitty";
        bind = [
          "$mod_SHIFT,E,exit"
          "$mod,Enter,$terminal"
          
          
          
          
          
          
          
          
          
          
          
          
        ];
      };
    };
  };
}
