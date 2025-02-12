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

      #configuration user    
      user = "samuel";
      email = "samworlds1231337@gmail.com";
      terminal = "ghostty";
      shell = "zsh";

    in
    {
      nixosConfigurations = {

        gnome-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs system user shell;
          };
          modules = [
            #system
            ./systems/GV302XI/configuration.nix

            #compositor
            ./compositors/gnome.nix

            #qemu
            ./nixpkgs/qemu.nix

            #podman
            ./nixpkgs/podman.nix


            #./nixpkgs/darling.nix
            #./nixpkgs/steam.nix

            #home-manager
            home-manager.nixosModules.home-manager #user
            {
              home-manager = {

                sharedModules = [

                  #theme
                  ./themes/gnome/ubuntu/ubuntu-dark.nix

                  #terminal
                  ./home-manager/${terminal}.nix

                  #shell
                  ./home-manager/${shell}.nix

                  #git
                  ./home-manager/git.nix

                  #direnv
                  ./home-manager/direnv.nix

                  #nixcord
                  ./home-manager/nixcord.nix

                ];
                extraSpecialArgs = {
                  inherit inputs system user email terminal;
                };
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./users/user.nix;

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
    color-schemes = {
      url = "github:mbadolato/iTerm2-Color-Schemes";
      flake = false;
    };

  };




}
