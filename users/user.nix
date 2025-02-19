{ lib, osConfig, pkgs, inputs, user, email, terminal, ... }:

{


  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.05";

  services.home-manager.autoUpgrade.enable = true;
  services.home-manager.autoUpgrade.frequency = "daily";

  home.packages = with pkgs; [


    #browser
    firefox

    vscode-fhs


    #fonts
    font-awesome
    iosevka
    noto-fonts-cjk-sans
    jetbrains-mono
    cascadia-code
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  #dont touch
  fonts.fontconfig.enable = true;

  #nix package manager configuration
  nix = {

    gc = {
      automatic = true;
    };

    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    settings.trusted-users = [ "root" user ];

    extraOptions = ''
         extra-substituters = https://devenv.cachix.org
         extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';

  };


 


  






}
