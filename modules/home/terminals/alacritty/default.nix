{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.terminals.alacritty;
in {
  options.custom.terminals.alacritty = with types; {
    enable = mkBoolOpt false "Whether or not to enable alacritty.";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window.decorations = "None";
        window.resize_increments = true;
      };
    };
  };
}
