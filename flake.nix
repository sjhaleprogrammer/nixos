{
  description = "Nixos config flake";

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      chaotic,
      nix-proton-cachyos,
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

        gnome-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            #system
            ./systems/GV302XI/configuration.nix

            #compositor
            ./compositors/gnome.nix


            #nixpkgs
            ./nixpkgs/qemu.nix
            ./nixpkgs/podman.nix
            #./nixpkgs/darling.nix
            ./nixpkgs/steam.nix

            #home-manager
            home-manager.nixosModules.home-manager #user
            {
              home-manager = {

                sharedModules = [

                  #theme
                  ./themes/gnome/macos-theme/bigsur-dark.nix

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

      # Chaotic's Nyx
      "https://chaotic-nyx.cachix.org/"

      # Nix Gaming
      "https://nix-gaming.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8"
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  inputs = {
    #nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:sjhaleprogrammer/nixos-hardware/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-proton-cachyos.url = "github:kimjongbing/nix-proton-cachyos";
    

    #home-manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord.url = "github:kaylorben/nixcord";

  };




}
