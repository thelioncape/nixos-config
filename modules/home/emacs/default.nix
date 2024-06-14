{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.emacs;
in {
  options.custom.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable emacs.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
    };
    home.packages = with pkgs; [
      cmake
      libtool
      python3
      fd
    ];
    home.file.initel = {
      enable = true;
      source = ./init.el;
      target = ".config/emacs/init.el";
      executable = true;
    };
  };
}
