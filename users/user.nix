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


 


  






}
