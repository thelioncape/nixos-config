{ options, config, lib, pkgs, ... }:
with lib;
with lib.custom; let
  cfg = config.custom.suites.photography;
in {
  options.custom.suites.photography = with types; {
    enable = mkBoolOpt false "Whether or not to enable photography configuration.";
  };

  config = mkIf cfg.enable {
    custom.photography.darktable.enable = true;
  };
}

