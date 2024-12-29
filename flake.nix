{
  description = "Nixos config flake";


  nixConfig = {
    substituters = [
      "https://cache.nixos.org"

      # nix community's cache server
      "https://nix-community.cachix.org"

      # sjhaleprogrammer's cache server
      "https://sjhaleprogrammer.cachix.org"

      # Chaotic's Nyx
      "https://chaotic-nyx.cachix.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "sjhaleprogrammer.cachix.org-1:Yxwp/6ytc91ydFbxWE8JunnPioBLb5VbdIn+jnMtHkg="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8"
    ];
  };

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
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";


  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixcord,
      chaotic,
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
            chaotic.nixosModules.default
            home-manager.nixosModules.home-manager #user
            {
              home-manager.sharedModules = [
                #./modules/home-manager/macos-theme/gnome-macos-theme-dark.nix #gnometheme
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
