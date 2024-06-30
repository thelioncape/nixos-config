{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.terminals.kitty;
in {
  options.custom.terminals.kitty = with types; {
    enable = mkBoolOpt false "Whether or not to enable kitty.";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "SF Mono";
        size = 12;
      };
      theme = "Catppuccin-Latte";
    };
  };
}
