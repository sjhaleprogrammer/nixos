{ pkgs, config, ... }:

{

  gtk = {

    enable = true;

    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
      size = 32; 
    };

    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };

    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };

  };

  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.screen-rotate # 2 in 1 display extension
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.user-themes
    gnomeExtensions.blur-my-shell
    gnomeExtensions.logo-menu

  ];

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";

      #macos font
      font-name = "SF Pro Display 14";
      document-font-name = "SF Pro Display 14";
      monospace-font-name = "SF Mono 13";

    };

    #window control button layout
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        screen-rotate.extensionUuid
        quick-settings-audio-panel.extensionUuid
        user-themes.extensionUuid
        blur-my-shell.extensionUuid
        logo-menu.extensionUuid
        
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "WhiteSur-Dark";
    };

  };

  home.file = {

    ".config/gtk-4.0" = {
      source = ./gtk-4.0;
      recursive = true;
    };

    ".local/share/fonts" = {
      source = ./fonts;
      recursive = true;
    };
    
    #for firefox users
    ".mozilla/firefox/firefox-themes" = {
      source = ./firefox-themes;
      recursive = true;
    };

  };

}
