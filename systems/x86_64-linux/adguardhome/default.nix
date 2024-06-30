{ lib, pkgs, ... }:
with lib;
with lib.custom; {
  custom = {
    archetypes.proxmox-lxc.enable = true;
    suites.server-common.enable = true;
    services.adguardhome.enable = true;
  };
}
