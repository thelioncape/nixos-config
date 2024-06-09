{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.wm-tools.hyprland;
in {
  options.custom.wm-tools.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable hyprland.";
  };

  config = mkIf cfg.enable {
    programs.hyprlock.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        "$terminal" = "kitty";
        "$menu" = "wofi --show drun -i";
        input = {
          kb_layout = "gb";
          kb_options = [ "ctrl:nocaps" ];
          touchpad = { natural_scroll = true; };
        };
        monitor = [
          "eDP-1,2256x1504@60,0x0,1.566667"
        ];
        exec-once = [
          "waybar"
        ];
        bind = [
          "$mod_SHIFT,E,exit"
          "$mod,Return,exec,$terminal"
          "$mod_SHIFT,Q,killactive"
          "$mod,D,exec,$menu"
          # Change focus with hjkl
          "$mod,H,movefocus,l"
          "$mod,J,movefocus,u"
          "$mod,K,movefocus,d"
          "$mod,L,movefocus,r"
          # Change focus with arrow keys
          "$mod,Left,movefocus,l"
          "$mod,Up,movefocus,u"
          "$mod,Down,movefocus,d"
          "$mod,Right,movefocus,r"
          # Switch to workspace
          "$mod,1,workspace,1"
          "$mod,2,workspace,2"
          "$mod,3,workspace,3"
          "$mod,4,workspace,4"
          "$mod,5,workspace,5"
          "$mod,6,workspace,6"
          "$mod,7,workspace,7"
          "$mod,8,workspace,8"
          "$mod,9,workspace,9"
          "$mod,0,workspace,10"
          # Move window to workspace
          "$mod_SHIFT,1,movetoworkspace,1"
          "$mod_SHIFT,2,movetoworkspace,2"
          "$mod_SHIFT,3,movetoworkspace,3"
          "$mod_SHIFT,4,movetoworkspace,4"
          "$mod_SHIFT,5,movetoworkspace,5"
          "$mod_SHIFT,6,movetoworkspace,6"
          "$mod_SHIFT,7,movetoworkspace,7"
          "$mod_SHIFT,8,movetoworkspace,8"
          "$mod_SHIFT,9,movetoworkspace,9"
          "$mod_SHIFT,0,movetoworkspace,10"
          # Scratchpad
          "$mod,Minus,togglespecialworkspace,magic"
          "$mod_SHIFT,Minus,movetoworkspace,special:magic"
          # Window Modifications
          "$mod,F,fullscreen"
          "$mod_SHIFT,Space,togglefloating"
          # Brightness Controls
          ",XF86MonBrightnessUp,exec,brillo -u 150000 -A 5"
          ",XF86MonBrightnessDown,exec,brillo -u 150000 -U 5"
        ];
      };
    };
  };
}
