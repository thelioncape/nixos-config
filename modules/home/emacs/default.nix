{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.emacs;
in {
  options.custom.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable rbw.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      
    };
  };
}
