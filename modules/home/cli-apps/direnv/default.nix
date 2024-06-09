{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.cli-apps.direnv;
in {
  options.custom.cli-apps.direnv = with types; {
    enable = mkBoolOpt false "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
