{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.dev.nix-nil;
in {
  options.custom.dev.nix-nil = with types; {
    enable = mkBoolOpt false "Whether or not to enable nix-nil LSP.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nil
    ];
  };
}
