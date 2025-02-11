# Main configuration
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {

  # Configure modules
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
   # ../../modules/optional/services
    ../../modules/common
    ../../modules/server
    inputs.disko.nixosModules.disko
    inputs.agenix.nixosModules.default
  ];

  networking.hostName = "vps"; ##TODO make variable control this
  networking.useDHCP = pkgs.lib.mkForce false;
  

  services.smartd.enable = lib.mkForce false;

  services.cloud-init = {
    enable = true;
    network.enable = true;
  };

  system.stateVersion = "24.11"; # Do not change!
}
