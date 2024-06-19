{ pkgs, mkShell, ... }:
mkShell {
  packages = with pkgs; [
    php
    phpactor
    php82Packages.composer
    npm
  ];
  shellHook = ''
    export PS1='\[\e[92m\][php-devel@\h:\w]\\$\[\e[0m\] '
  '';
}
