{
  description = "Nixos config flake";

  inputs = {
    #nixos
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    
    #modules
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:sjhaleprogrammer/nixos-hardware/master";
    nixcord.url = "github:kaylorben/nixcord";


  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixcord,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
    in
    {
      nixosConfigurations = {

        samuel = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            ./systems/GV302XI/configuration.nix #system
            ./modules/nixpkgs/gnome.nix #compositer
            home-manager.nixosModules.home-manager #user
            {
              home-manager.sharedModules = [
                inputs.nixcord.homeManagerModules.nixcord
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.samuel = import ./users/samuel.nix;
            }
            
          ];
        };


        # TODO: Add other configurations here if needed


        
      };
  };
     

}
