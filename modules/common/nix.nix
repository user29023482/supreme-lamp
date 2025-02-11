{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  user = "TabascoAnthill";
  flakePath = "/home/${user}/nixos/nixos?ref=dev";
in {

  # Enable flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # Trusted users
    trusted-users = [ "root" "${user}" ];
  };

  # Enable git
  programs.git.enable = true;

  # Add unstable to flake registry to use locally (e.g. `nix run nixpkgs-unstable#hatch`)
  nix.registry.nixpkgs-unstable.flake = inputs.nixpkgs-unstable;

  # Allow unfree packages and pulling some packages from stable
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      stable = import inputs.nixpkgs {
        config = config.nixpkgs.config;
        system = "x86_64-linux";
      };
      unstable = import inputs.nixpkgs-unstable {
        config = config.nixpkgs.config;
        system = "x86_64-linux";
      };
    };
    permittedInsecurePackages = [
    ];
  };

  # Show nix updates
  environment.shellAliases = {
    nd = "nix profile diff-closures --profile /nix/var/nix/profiles/system";
    ni = "nix-store --query --requisites /run/current-system/sw | cut -d- -f2- | sort | less";
  };

  # System maintenance
  system.autoUpgrade = {
    enable = true;
    flake = "${flakePath}#${config.networking.hostName}";
    flags = [
      "-L"
    ];
    dates = "04:40";
    persistent = true;
    randomizedDelaySec = "45min";
  };

  # Allow nixos-upgrade to restart on failure
  systemd.services.nixos-upgrade = {
    preStart = "${pkgs.host}/bin/host google.com";  # Check network connectivity
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "120";
    };
    unitConfig = {
      StartLimitIntervalSec = 600;
      StartLimitBurst = 2;
    };
    after = ["flake-update.service"];
    wants = ["flake-update.service"];
    path = [pkgs.host];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise.automatic = true;
}
