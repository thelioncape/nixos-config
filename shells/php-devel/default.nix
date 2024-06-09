{ pkgs, mkShell, ... }:
mkShell {
  packages = with pkgs; [
    php
  ];
  shellHook = ''
    export PS1='\[\e[92m\][php-devel@\h:\w]\\$\[\e[0m\] '
  '';
}
