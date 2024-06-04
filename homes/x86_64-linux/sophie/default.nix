{ lib, pkgs, config, osConfig ? {}, format ? "unknown", ... }:
with lib;
with lib.custom; {
  custom = {
    theme.name = "catppuccin-latte";
    emacs.enable = true;
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
      nix-nil.enable = true;
      ssh-agent.enable = true;
    };
  };
}

