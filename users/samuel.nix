{ pkgs, ... }:

{
  
  imports = [
    #./../modules/home-manager/neovim/neovim.nix
    ./../modules/home-manager/nixcord.nix
    ./../modules/home-manager/macos-theme/gnome-macos-theme-dark.nix
  ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "samuel";
  home.homeDirectory = "/home/samuel";
  home.stateVersion = "23.05";
  
  services.home-manager.autoUpgrade.enable = true;
  services.home-manager.autoUpgrade.frequency = "daily";

  home.packages = with pkgs; [
  
  
    #terminal
    mate.mate-terminal
    
    #browser
    firefox

    
    #editor
    code-cursor
    nixfmt-rfc-style
    
    

    #fonts
    font-awesome
    iosevka
    noto-fonts-cjk-sans
    jetbrains-mono
    nerdfonts
    cascadia-code
  ];

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
      credential.helper = "${pkgs.git-credential-manager}/bin/git-credential-manger";
    };
  };

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
  };
  
  dconf.settings = {
    "org/mate/terminal/profiles/default" = {
      font = "JetBrainsMono Nerd Font 13";
      title = "samuel";
      default-show-menubar = false;
      
    };
  };

  /*
    gtk = {
      enable = true;

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      theme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };

    };
  */

  /*
    home.pointerCursor = let
      getFrom = url: hash: name: {
        gtk.enable = true;
        x11.enable = true;
        name = name;
        size = 26;
        package = pkgs.runCommand "moveUp" { } ''
          mkdir -p $out/share/icons
          ln -s ${
            pkgs.fetchzip {
              url = url;
              hash = hash;
            }
          } $out/share/icons/${name}
        '';
      };
    in getFrom
    "https://github.com/manu-mannattil/adwaita-cursors/releases/download/v1.2/adwaita-cursors.tar.gz"
    "sha256-zKa55zn4UO/cCTx2Es0xKxUwjFe5/k5xWI9RLJYpvsQ=" "Adwaita";
  */

}
