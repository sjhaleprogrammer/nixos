{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {

        system = nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            ./systems/GV302XI/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        samuel = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./users/samuel.nix
          ];
        };

      };

    };

}
