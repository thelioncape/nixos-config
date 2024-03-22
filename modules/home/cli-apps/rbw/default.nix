{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.cli-apps.rbw;
in {
  options.custom.cli-apps.rbw = with types; {
    enable = mkBoolOpt false "Whether or not to enable rbw.";
  };

  config = mkIf cfg.enable {
    programs.rbw = {
      enable = true;
      settings = {
        base_url = "https://vaultwarden.benstanderline.com";
        email = "ben@benstanderline.com";
        pinentry = "curses";
      };
    };
  };
}
