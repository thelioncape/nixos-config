{ lib, inputs, ... }:
let
  inherit (lib) assertMsg;
  inherit (lib) asserts;
in
with lib; rec {
    ## Create a NixOS module option.
    ##
    ## ```nix
    ## lib.mkopt nixpkgs.lib.types.str "My default" "Description of my option."
    ## ```
    ##
    #@ Type -> Any -> String
    mkOpt = type: default: description:
      mkOption { inherit type default description; };
  
    ## Create a NixOS moudle option without a description
    ##
    ## ```nix
    ## lib.mkOpt' nixpkgs.lib.types.str "My default"
    ## ```
    ##
    #@ Type -> Any -> String
    mkOpt' = type: default: mkOpt type default null;
  
    ## Create a boolean NixOS module option.
    ##
    ## ```nix
    ## lib.mkBoolOpt true "Description of my option."
    ## ```
    ##
    #@ Type -> Any -> String
    mkBoolOpt = mkOpt types.bool;
  
    ## Get theme from nix-colors
    getTheme = theme:
      assert (theme != null && builtins.typeOf theme == "string");
        inputs.nix-colors.colorSchemes.${theme}.palette;
}

