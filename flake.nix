{
  description = "Flake.nix - defines system configurations. Mostly used as an input section.";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";    
    
    #secrets.url = "./secrets";
    #secrets.flake = false;
  };

  outputs = inputs@{
    self,
    disko,
    home-manager,
    nixpkgs,
    nixpkgs-unstable,
    agenix,
    ...
  }: let
    inherit (self) outputs;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      vps  = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/vps/configuration.nix
        ];
      };
    };
  }; 
}
