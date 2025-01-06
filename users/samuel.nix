{ lib, osConfig, pkgs, inputs, ... }:

{


  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "samuel";
  home.homeDirectory = "/home/samuel";
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


  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "samuel";
    userEmail = "samworlds1231337@gmail.com";
    extraConfig = {
      safe = {
        directory = "/etc/nixos";
      };
      credential = {
        credentialStore = "secretservice";
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      };
      push.autoSetupRemote = true;
    };
  };


  
  programs.ghostty.enable = true;

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        {
          name = "dracula/zsh";
          tags = [ "as:theme" ];
        }
      ];
    };

  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };






}
