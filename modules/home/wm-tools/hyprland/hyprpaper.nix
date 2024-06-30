{ config, lib, pkgs, ... }:

{
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
}
