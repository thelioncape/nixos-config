{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.custom.cli-apps.rbw;
in
{
  options.custom.tools.rbw = with types; {
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
