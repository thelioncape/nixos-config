{ lib, pkgs, ... }:
with lib;
with lib.custom; {
  custom = {
    suites.server-common.enable = true;
  };
}
