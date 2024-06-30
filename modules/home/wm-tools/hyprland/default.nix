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
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            drag_lock = true;
          };
        };
        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
        };
        monitor = [
          "eDP-1,2256x1504@60,0x0,1.566667"
        ];
        exec-once = [
          "waybar"
        ];
        windowrulev2 = [
          "opacity 0.8 override 0.8 override,class:(kitty)"
          "opacity 0.8 override 0.8 override,class:(emacs)"
        ];
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 0.8;
          drop_shadow = true;
          shadow_range = 8;
          shadow_render_power = 2;
          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            noise = 0.01;
            contrast = 0.9;
            brightness = 0.8;
            popups = true;
          };
        };
        animations = {
          enabled = true;
          bezier = [
            "wind, 0.05, 0.9, 0.1, 1.05"
            "winIn, 0.1, 1.1, 0.1, 1.1"
            "winOut, 0.3, -0.3, 0, 1"
            "liner, 1, 1, 1, 1"
            "siryessir, 0.1, 1.0, 0.1, 1.0"
          ];
          animation = [
            "windows, 1, 6, wind, slide"
            "windowsIn, 1, 6, winIn, popin"
            "windowsOut, 1, 5, winOut, slide"
            "windowsMove, 1, 5, wind, slide"
            "layers, 1, 5, siryessir, popin"
            "border, 1, 1, liner"
            "borderangle, 1, 30, liner, loop"
            "fade, 1, 10, default"
            "workspaces, 1, 5, wind"
            "specialWorkspace, 1, 10, winIn, fade"
          ];
        };
        bindm = [
          "SUPER, mouse:273, resizewindow"
          "SUPER, mouse:272, movewindow"
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
        ];
        bindl = [
          ",XF86MonBrightnessUp,exec,brillo -u 150000 -A 5"
          ",XF86MonBrightnessDown,exec,brillo -u 150000 -U 5"
          ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioRaiseVolume,exec,wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ];
      };
    };
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "off";
        splash = false;
        preload = [
          "${pkgs.custom.wallpapers.nix-minimal-latte}"
        ];
        wallpaper = [
          "eDP-1,${pkgs.custom.wallpapers.nix-minimal-latte}"
        ];
      };
    };
  };
}
