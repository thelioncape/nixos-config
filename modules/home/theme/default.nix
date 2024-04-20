{ lib, config, pkgs,  ...}:
let
  inherit (lib) types;
  inherit (lib.custom) mkOpt;
in
{
  options.custom.theme = with types; {
    name = mkOpt (types.nullOr types.str) "cattpuccin-latte" "The theme name.";
  };

  config = {
    home.pointerCursor = {
      package = pkgs.catppuccin-cursors.latteMauve;
      name = "Catppuccin-Latte-Mauve-Cursors";
      size = 64;
      gtk.enable = true;
    };
  };
}
