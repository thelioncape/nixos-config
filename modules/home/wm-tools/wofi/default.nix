{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.wm-tools.wofi;
in {
  options.custom.wm-tools.wofi = with types; {
    enable = mkBoolOpt false "Whether or not to enable wofi.";
  };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
    };
  };
}
