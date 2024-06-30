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
      name = "catppuccin-latte-mauve-cursors";
      size = 32;
    };
    wayland.windowManager.hyprland.settings.env = [
      "HYPRCURSOR_THEME, ${toString config.home.pointerCursor.name}"
      "HYPRCURSOR_SIZE, ${toString config.home.pointerCursor.size}"
    ];
  };
}
