{
  description = "Nixos config flake";

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
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

        samuel-plasma = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            #system
            ./systems/GV302XI/configuration.nix

            #compositor
            ./compositors/plasma6.nix


            #nixpkgs
            ./nixpkgs/qemu.nix
            ./nixpkgs/podman.nix

            #userspace
            home-manager.nixosModules.home-manager #user
            {
              home-manager = {

                sharedModules = [

                  #theme
                  #./themes/plasma6/macos-theme/macos-theme-dark.nix

                  #terminal

                  #nixcord
                  ./home-manager/nixcord.nix


                ];
                extraSpecialArgs = {
                  inherit inputs system;
                };
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.samuel = import ./users/samuel.nix;

              };
            }

          ];
        };


        # TODO: Add other configurations here if needed


      };
  };



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
    #nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:sjhaleprogrammer/nixos-hardware/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    

    #home-manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord.url = "github:kaylorben/nixcord";

  };




}
