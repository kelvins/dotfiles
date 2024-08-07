{ pkgs, ... }:

{
  home.packages = with pkgs; [
      gcc
      rustup
      #cargo
      #rustc
      #rustfmt
  ];
}
