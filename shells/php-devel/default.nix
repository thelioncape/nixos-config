{ pkgs, mkShell, ... }:
mkShell {
  packages = with pkgs; [
    php
  ];
}
