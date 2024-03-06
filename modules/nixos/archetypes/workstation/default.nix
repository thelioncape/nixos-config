{ options, config, lib, pkgs, ... }:
with lib; let
  cfg = config.custom.archetypes.workstation;
in {
  options.custom.archetypes.workstation = with types; {
    enable = mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };
}

