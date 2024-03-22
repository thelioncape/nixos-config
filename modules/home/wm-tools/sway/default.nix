{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.wm-tools.sway;
  modifier = config.wayland.windowManager.sway.config.modifier;
  terminal = config.wayland.windowManager.sway.config.terminal;
  menu = config.wayland.windowManager.sway.config.menu;
  left = config.wayland.windowManager.sway.config.left;
  right = config.wayland.windowManager.sway.config.right;
  up = config.wayland.windowManager.sway.config.up;
  down = config.wayland.windowManager.sway.config.down;
in {
  options.custom.wm-tools.sway = with types; {
    enable = mkBoolOpt false "Whether or not to enable sway.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "wofi --show drun -i";
        fonts = {
          names = [ "SF Pro Display" ];
          style = "Regular";
          size = 12.0;
        };
        startup = [
                    #{ command = "swaybg -i ~/.papes/Snowy-Mountain-Region.jpg -m tile"; always = true }
                  ];
        output = {
          eDP-1 = {
            bg = "${pkgs.custom.wallpapers.nixos-flake-dark} fill";
          };
        };
        input = {
          "1189:32769:BenQ_ZOWIE_BenQ_ZOWIE_Gaming_Mouse" = {
            accel_profile = "flat";
            pointer_accel = "-0.3";
          };
          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
          };
          "type:keyboard" = {
            xkb_numlock = "enabled";
            xkb_options = "ctrl:nocaps";
          };
          "*" = {
            xkb_layout = "gb";
          };
        };
        bars = [
          {
            position = "top";
            command = "waybar";
          }
        ];
        keybindings = {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+Shift+q" = "kill";
          "${modifier}+d" = "exec ${menu}";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+e" = "exec swaymsg exit";

          # Move focus with hjkl
          "${modifier}+${left}" = "focus left";
          "${modifier}+${right}" = "focus right";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${down}" = "focus down";

          # Move focus with arrow keys
          "${modifier}+Left" = "focus left";
          "${modifier}+Right" = "focus right";
          "${modifier}+Up" = "focus up";
          "${modifier}+Down" = "focus down";

          # Move window with hjkl
          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${right}" = "move right";
          "${modifier}+Shift+${up}" = "move up";
          "${modifier}+Shift+${down}" = "move down";

          # Move window with arrow keys
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Right" = "move right";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Down" = "move down";

          # Switch to workspace
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          # Move window to workspace
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          # Layout
          "${modifier}+b" = "splith";
          "${modifier}+v" = "splitv";

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          "${modifier}+f" = "fullscreen";

          "${modifier}+Shift+Space" = "floating toggle";

          "${modifier}+Space" = "focus mode_toggle";

          "${modifier}+a" = "focus parent";

          # Scratchpad
          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          # Modes
          "${modifier}+r" = "mode resize";
        };
        modes = {
          resize = {
            "${left}" = "resize shrink width 10px";
            "${right}" = "resize grow width 10px";
            "${up}" = "resize shrink height 10px";
            "${down}" = "resize grow height 10px";

            "Left" = "resize shrink width 10px";
            "Right" = "resize grow width 10px";
            "Up" = "resize shrink height 10px";
            "Down" = "resize grow height 10px";

            "Return" = "mode default";
            "Escape" = "mode default";
          };
        };
        floating.criteria = [
          { title = "Friends List"; }
          { title = "Open Database File"; }
          { title = "Options"; class = "KeePass2"; }
          { title = "RemoteDesktopManager"; }
          { title = "Add cards"; app_id = "mnemosyne"; }
          { title = "Tip of the day"; app_id = "mnemosyne"; }
        ];
        assigns = {
          "M" = [{ title = "DavMail Gateway"; }];
          "2" = [{ class = "Emacs"; }];
          "10" = [{ class = "teams-for-linux"; }];
          "5" = [{ app_id = "RemoteDesktopManager"; }];
          "4" = [{ class = "Bitwarden"; }];
        };
      };
    };
  };
}
