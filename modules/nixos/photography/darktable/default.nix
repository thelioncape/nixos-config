{ options, config, lib, pkgs, ... }:
with lib;
with lib.custom; let
  cfg = config.custom.photography.darktable;
in {
  options.custom.photography.darktable = with types; {
    enable = mkBoolOpt false "Whether or not to enable darktable";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ darktable gphoto2 gphoto2fs libgphoto2 ];
    services.gvfs.enable = true;
    programs.gphoto2.enable = true;
    users.users.sophie.extraGroups = [ "camera" ];
  };
}

