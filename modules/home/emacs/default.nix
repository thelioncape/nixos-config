{ lib, config, pkgs, inputs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.emacs;
in {
  options.custom.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable emacs.";
    doomrepo = mkOpt types.str "https://github.com/doomemacs/doomemacs" "The doom emacs repo URL";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
    };
    # Emacs Dependencies
    home.packages = with pkgs; [
      cmake
      fd
      html-tidy
      jsbeautifier
      ledger
      libtool
      nixfmt
      php
      phpactor
      php82Packages.composer
      python3
      ripgrep
      shellcheck
      stylelint
    ];
    programs.pandoc = {
      enable = true;
    };
    # Emacs Configuration File Mapping
    home.file.initel = {
      enable = true;
      source = ./init.el;
      target = ".config/doom/init.el";
      executable = true;
    };
    home.file.configel = {
      enable = true;
      source = ./config.el;
      target = ".config/doom/config.el";
      executable = true;
    };
    home.file.packagesel = {
      enable = true;
      source = ./packages.el;
      target = ".config/doom/packages.el";
      executable = true;
    };
    # Doom installation
    home.activation = {
      doomEmacs = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundry"] ''
        if [ ! -d "$HOME/.config/emacs" ]; then
          run ${pkgs.git}/bin/git clone --depth=1 --single-branch "${cfg.doomrepo}" $HOME/.config/emacs
        fi
      '';
    };
    home.sessionVariables = {
      PATH = "$HOME/.config/emacs/bin:$PATH";
    };
  };
}
