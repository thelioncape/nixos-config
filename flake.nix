{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    snowfall-lib = {
      url = "github:thelioncape/lib/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    apple-fonts.url = "github:braindefender/nix-apple-fonts";
    catppuccin.url = "github:catppuccin/nix";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "dotfiles";
          title = "dotfiles";
        };

        namespace = "custom";
      };
    };
  in
    lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allow-unfree = true;
      };

      overlays = with inputs; [];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        catppuccin.nixosModules.catppuccin
      ];

      homes.modules = with inputs; [
        catppuccin.homeManagerModules.catppuccin
      ];

      templates = import ./templates {};
    };
}
