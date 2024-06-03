{ options, config, lib, pkgs, ... }:
with lib;
with lib.custom; let
  cfg = config.custom.suites.server-common;
in {
  options.custom.suites.server-common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common server configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.git
    ];
  };
}

