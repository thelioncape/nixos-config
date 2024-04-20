{ options, config, lib, pkgs, ... }:
with lib;
with lib.custom; let
  cfg = config.custom.archetypes.workstation;
in {
  options.custom.archetypes.workstation = with types; {
    enable = mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    custom = {
      suites = {
        common.enable = true;
      };
      fonts = {
        enable = true;
        fonts = with pkgs; [
          font-awesome
        ];
      };
    };
  };
}

