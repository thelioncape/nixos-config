{ options, config, lib, pkgs, ... }:
with lib;
with lib.custom; let
  cfg = config.custom.archetypes.proxmox-lxc;
in {
  options.custom.archetypes.proxmox-lxc = with types; {
    enable = mkBoolOpt false "Whether or not to enable the proxmox-lxc archetype.";
  };

  config = mkIf cfg.enable {
    # Supress systemd units that don't work because of LXC
    systemd.suppressedSystemUnits = [
      "dev-mqueue.mount"
      "sys-kernel-debug.mount"
      "sys-fs-fuse-connections.mount"
    ];
    # start tty0 on serial console
    systemd.services."getty@tty1" = {
      enable = lib.mkForce true;
      wantedBy = [ "getty.target" ]; # to start at boot
      serviceConfig.Restart = "always"; # restart when session is closed
    };
    boot.isContainer = true;
    snowfallorg.users.sophie.home.enable = false;
  };
}
