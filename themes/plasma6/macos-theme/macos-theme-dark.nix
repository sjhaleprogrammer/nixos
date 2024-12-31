{
  pkgs,
  config,
  lib,
  ...
}:

{


  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";

      #macos font
      font-name = "SF Pro Display 13";
      document-font-name = "SF Pro Display 13";
      monospace-font-name = "SF Mono 13";

    };
  };


  home.packages = with pkgs; [
     application-title-bar
     plasma-panel-spacer-extended
  ];


  home.activation = {

    gtk-dark = ''
       ln -sf "$HOME/.config/gtk-4.0/gtk-Dark.css" "$HOME/.config/gtk-4.0/gtk.css"
    '';

  };





  home.file = {

    ".local/share/aurorae" = {
      source = ./aurorae;
      recursive = true;
    };

    ".local/share/color-schemes" = {
      source = ./color-schemes;
      recursive = true;
    };

    ".local/share/plasma" = {
      source = ./plasma;
      recursive = true;
    };

    ".local/share/kwin" = {
      source = ./kwin;
      recursive = true;
    };

    ".local/share/fonts" = {
      source = ./fonts;
      recursive = true;
    };

    ".local/share/icons" = {
      source = ./icons;
      recursive = true;
    };

    #cursor
    ".local/share/.icons" = {
      source = ./.icons;
      recursive = true;
    };




    ".themes" = {
      source = ./.themes;
      recursive = true;
    };





    ".gtkrc-2.0" = {
      source = ./.gtkrc-2.0;
    };

    ".gtkrc-2.0-kde4" = {
      source = ./.gtkrc-2.0-kde4;
    };



    ".config/" = {
      source = ./kde-config;
      recursive = true;
    };








  };


}
