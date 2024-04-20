{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.wm-tools.waybar;
  theme = getTheme (config.custom.theme.name);
in {
  options.custom.wm-tools.waybar = with types; {
    enable = mkBoolOpt false "Whether or not to enable waybar.";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = [{
        height = 42;
        spacing = 0;
        modules-left = [
          "hyprland/window"
          "pulseaudio"
          "backlight"
          "cpu"
          "memory"
          "network"
        ];
        modules-center = [
          "hyprland/workspaces"
          #"custom/themeselector"
          #"pulseaudio"
          #"cpu"
          #"memory"
          #"clock"
        ];
        modules-right = [
          #"custom/hyprbindings"
          #"custom/exit"
          #"custom/notification"
          "idle_inhibitor"
          "custom/themeselector"
          "disk#root"
          "disk#home"
          "battery"
          "clock"
          "tray"
        ];

        "hyprland/window" = {
          max-length = 25;
          separate-outputs = false;
        };
        "pulseaudio" = {
          format = "{icon} {volume}%  {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
        "backlight" = {
          format = "{icon}  {percent}%";
          format-icons = [ "" ];
        };
        "cpu" = {
          interval = 5;
          format = " {usage:2}%";
          tooltip = true;
        };
        "memory" = {
          interval = 5;
          format = "  {}%";
          tooltip = true;
        };
        "network" = {
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-ethernet = ": {bandwidthDownOctets}";
          format-wifi = "{icon}  {signalStrength}%";
          format-disconnected = "󰤮";
          tooltip = false;
          on-click = "nm-applet";
        };
        "hyperland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = " ";
            active = " ";
            urgent = " ";
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        "disk#root" = {
          format = "/  {free}";
          tooltip = true;
          path = "/";
#          on-click = "hyprctl dispatch 'exec alacritty -e broot -hipsw'";
        };
        "disk#home" = {
          format = "  {free}";
          tooltip = true;
          path = "/home";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = "true";
        };
        "custom/themeselector" = {
          tooltip = false;
          format = "";
          # exec = "theme-selector";
          on-click = "theme-selector";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          on-click = "";
          tooltip = false;
        };
        "clock" = {
          format = "{: %F %H:%M}";
          tooltip = false;
        };
        "tray" = { spacing = 12; };
        "custom/startmenu" = {
          tooltip = false;
          format = "";
          # exec = "rofi -show drun";
          on-click = "wofi -show drun -i";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification =
              "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification =
              "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t";
          escape = true;
        };
        "privacy" = {
          icon-spacing = 4;
          icon-size = 18;
          transition-duration = 250;
          modules = [
            {
              "type" = "screenshare";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
            {
              "type" = "audio-out";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
            {
              "type" = "audio-in";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
          ];
        };
      }];
      style = ''
        * {
          font-size: 12px;
          font-family: 'JetBrains Mono', Font Awesome;
              font-weight: 600;
        }
        window#waybar {
              margin: 5px;
              padding: 5px;
              border-radius: 15px;
              border: 2px solid #${theme.base0F};
              background-color: rgba(26,27,38,0.64);
              color: #${theme.base0F};
        }
        #window {
              color: #${theme.base05};
              background: #${theme.base00};
              border-radius: 12px;
              margin: 5px;
              padding: 5px 10px;
        }
        #pulseaudio {
              color: #${theme.base0D};
              background: #${theme.base00};
              border-radius: 12px 0px 0px 12px;
              margin: 5px 0px 5px 5px;
              padding: 2px 3px 2px 10px;
        }
        #backlight {
              color: #${theme.base0C};
              background: #${theme.base00};
              border-radius: 0px 12px 12px 0px;
              margin: 5px 5px 5px 0px;
              padding: 2px 10px 2px 3px;
        }
        #cpu {
              color: #${theme.base07};
              background: #${theme.base00};
              border-radius: 12px 0px 0px 12px;
              margin: 5px 0px 5px 5px;
              padding: 2px 5px 2px 10px;
        }
        #memory {
              color: #${theme.base0F};
              background: #${theme.base00};
              border-radius: 0px;
              margin: 5px 0px;
              padding: 2px 5px;
        }
        #network {
              color: #${theme.base09};
              background: #${theme.base00};
              border-radius: 0px 12px 12px 0px;
              margin: 5px 5px 5px 0px;
              padding: 2px 10px 2px 3px;
        }
        #workspaces {
              background: linear-gradient(180deg, #${theme.base00}, #${theme.base01});
              margin: 5px;
              padding: 0px 1px;
              border-radius: 15px;
              border: 0px;
              font-style: normal;
              color: #${theme.base00};
        }
        #workspaces button {
              padding: 0px 5px;
              margin: 4px 3px;
              border-radius: 15px;
              border: 0px;
              color: #${theme.base00};
              background-color: #${theme.base00};
              opacity: 1.0;
              transition: all 0.3s ease-in-out;
        }
        #workspaces button.active {
              color: #${theme.base00};
              background: #${theme.base04};
              border-radius: 15px;
              min-width: 40px;
              transition: all 0.3s ease-in-out;
              opacity: 1.0;
        }
        #workspaces button:hover {
              color: #${theme.base02};
              background: #${theme.base04};
              border-radius: 15px;
              opacity: 1.0;
        }
        tooltip {
            background: #${theme.base00};
            border: 1px solid #${theme.base04};
            border-radius: 10px;
        }
        tooltip label {
            color: #${theme.base07};
        }
        #clock {
              color: #${theme.base0B};
              background: #${theme.base00};
              border-radius: 12px;
              margin: 5px;
              padding: 5px 10px;
        }
        #disk {
              color: #${theme.base03};
              background: #${theme.base00};
              border-radius: 0px;
              margin: 5px 0px;
              padding: 2px 5px;
        }
        #battery {
              color: #${theme.base08};
              background: #${theme.base00};
              border-radius: 0px 12px 12px 0px;
              margin: 5px 5px 5px 0px;
              padding: 2px 10px 2px 3px;
        }
        #tray {
              color: #${theme.base05};
              background: #${theme.base00};
              border-radius: 15px 0px 0px 50px;
              margin: 5px 0px 5px 5px;
              padding: 2px 20px;
        }
        #custom-notification {
              color: #${theme.base0C};
              background: #${theme.base00};
              border-radius: 15px 50px 15px 50px;
              margin: 5px;
              padding: 2px 20px;
        }
        #custom-themeselector {
              color: #${theme.base0D};
              background: #${theme.base00};
              border-radius: 0px;
              margin: 5px 0px;
              padding: 2px 5px;
          }
        #custom-startmenu {
              color: #${theme.base03};
              background: #${theme.base00};
              border-radius: 50px 15px 50px 15px;
              margin: 5px;
              padding: 2px 20px;
        }
        #idle_inhibitor {
              color: #${theme.base09};
              background: #${theme.base00};
              border-radius: 12px 0px 0px 12px;
              margin: 5px 0px 5px 5px;
              padding: 2px 10px 2px 10px;
        }
      '';
    };
  };
}
