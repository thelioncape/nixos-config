{ options, config, lib, pkgs, ... }:
with lib;
with lib.custom; let
  cfg = config.custom.windowManagers.hyprland;
in {
  options.custom.windowManagers.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable hyprland.";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;
  };
}

