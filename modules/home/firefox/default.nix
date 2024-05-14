{ lib, config, pkgs, ... }:

with lib;
with lib.custom; let
  cfg = config.custom.firefox;
in {
  options.custom.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable firefox.";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      policies = {
        ExtensionSettings = {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          };
          "idcac-pub@guus.ninja" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
          };
          "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/noscript/latest.xpi";
          };
          "extension@one-tab.com" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/onetab/latest.xpi";
          };
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };
          "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/old-reddit-redirect/latest.xpi";
          };
        };
      };
      profiles.standard = {
        isDefault = true;
      };
    };
  };
}
