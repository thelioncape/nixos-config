{ lib, config, pkgs, inputs, ... }:
with lib;
with lib.custom; let
  cfg = config.custom.fonts;
in {
  options.custom.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [font-manager];

    fonts.packages = [
      pkgs.emacs-all-the-icons-fonts
      pkgs.nerdfonts
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-emoji
      (pkgs.nerdfonts.override {fonts = ["Hack"];})
      inputs.apple-fonts
    ]
    ++ cfg.fonts;
  };
}
