{ pkgs, lib, config, inputs, ... }:

{
  packages = [
    pkgs.talosctl
    pkgs.omnictl
    pkgs.kubectl
  ];
}
