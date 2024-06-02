{ lib, pkgs, ... }:
with lib;
with lib.custom; {
  custom = {
    services.adguardhome.enable = true;
  };
}
