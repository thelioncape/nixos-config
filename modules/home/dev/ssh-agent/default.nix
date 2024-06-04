{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.dev.ssh-agent;
in {
  options.custom.dev.ssh-agent = with types; {
    enable = mkBoolOpt false "Whether or not to enable ssh-agent.";
  };

  config = mkIf cfg.enable {
    services.ssh-agent.enable = true;
  };
}
