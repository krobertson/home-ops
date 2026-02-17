{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  packages = [
    pkgs.talosctl
    pkgs.omnictl
    pkgs.kubectl
    pkgs.kubelogin-oidc
    pkgs.fluxcd
    pkgs.kubernetes-helm
    pkgs.helmfile
  ];
}
