{ lib, config, pkgs, inputs, ... }:
with lib;
with lib.custom; let
  cfg = config.custom.services.adguardhome;
in {
  options.custom.services.adguardhome = with types; {
    enable = mkBoolOpt false "Whether or not to enable AdGuard Home.";
  };

  config = mkIf cfg.enable {
    services.adguardhome = {
      enable = true;
      mutableSettings = false;
      settings = {};
    };
  };
}
