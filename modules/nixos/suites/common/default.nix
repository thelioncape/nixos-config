{ options, config, lib, pkgs, ... }:
with lib;
with lib.custom; let
  cfg = config.custom.suites.common;
in {
  options.custom.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.custom.wallpapers
    ];
  };
}

