{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      #config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      FWL13-L = lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/FWL13-L
                    home-manager.nixosModules.home-manager {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager.users.sophie = import ./hosts/FWL13-L/home.nix;
                    }
                  ];
      };
    };
    hmConfig = {
      sophie = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "sophie";
        homeDirectory = "/home/sophie";
        #configuration = {
          #imports = [
            #./home.nix
          #];
        #};
      };
    };
  };

}
