{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.dev.git;
in {
  options.custom.dev.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable git.";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userEmail = "sophie@sophiecat.pw";
      userName = "Sophie";
    };
  };
}
