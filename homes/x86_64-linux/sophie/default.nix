{ lib, pkgs, config, osConfig ? {}, format ? "unknown", ... }:
with lib; {
  custom = {
    cli-apps = {
      rbw.enabled = true;
    };
  };
}

