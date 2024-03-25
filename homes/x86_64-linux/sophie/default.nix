{ lib, pkgs, config, osConfig ? {}, format ? "unknown", ... }:
with lib;
with lib.custom; {
  custom = {
    cli-apps = {
      rbw.enable = true;
    };
    terminals = {
      alacritty.enable = true;
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

