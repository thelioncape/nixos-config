{ lib, pkgs, config, osConfig ? {}, format ? "unknown", ... }:
with lib;
with lib.custom; {
  custom = {
    cli-apps = {
      rbw.enable = true;
    };
    terminals = {
      kitty.enable = true;
    };
    wm-tools = {
      wofi.enable = true;
      hyprland.enable = true;
      waybar.enable = true;
    };
    dev = {
      git.enable = true;
    };
  };
}

