{
  pkgs,
  config,
  lib,
  terminal,
  ...
}:

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

    gtk2.extraConfig = ''
      gtk-modules="appmenu-gtk-module"
    '';

    gtk3.extraConfig = {
      gtk-modules="appmenu-gtk-module";
    };

   

  };


  home.packages = with pkgs; [

    gnomeExtensions.appindicator
    gnomeExtensions.screen-rotate # 2 in 1 display extension
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.user-themes
    gnomeExtensions.blur-my-shell
    gnomeExtensions.logo-menu
    gnomeExtensions.just-perfection
    gnomeExtensions.compiz-alike-magic-lamp-effect
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.search-light
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.gtk4-desktop-icons-ng-ding
    gnomeExtensions.dash-to-dock

  ];

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";

      clock-format = "12h";
      clock-show-weekday = true;
      enable-hot-corners = false;


      #macos font
      font-name = "SF Pro Display 13";
      document-font-name = "SF Pro Display 13";
      monospace-font-name = "SF Mono 13";

    };

    "org/gnome/deskop/a11y" = {
      always-show-universal-access-status = true;
    };

    #window control button layout
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:";
      titlebar-font = "SF Pro Display 13";

    };

    "org/gnome/mutter" = {
      edge-tiling = true;
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
        just-perfection.extensionUuid
        compiz-alike-magic-lamp-effect.extensionUuid
        gnome-40-ui-improvements.extensionUuid
        search-light.extensionUuid
        rounded-window-corners-reborn.extensionUuid
        gtk4-desktop-icons-ng-ding.extensionUuid
        dash-to-dock.extensionUuid

      ];
    };

    #User theme extension
    "org/gnome/shell/extensions/user-theme" = {
      name = "WhiteSur-Dark";
    };

    #Logo menu extension
    "org/gnome/shell/extensions/Logo-menu" = {
      menu-button-terminal = "${terminal}";
      show-power-options = true;
    };

    #just perfection
    "org/gnome/shell/extensions/just-perfection" = {
      activities-button = false;
      alt-tab-icon-size = 0;
      alt-tab-small-icon-size = 0;
      alt-tab-window-preview-size = 0;
      clock-menu-position = 1;
      clock-menu-position-offset = 20;
      dash-icon-size = 0;
      looking-glass-width = 0;
      notification-banner-position = 2;
      panel-notification-icon = false;
      panel-icon-size = 0;
      panel-size = 0;
      startup-status = 0;
      window-demands-attention-focus = true;
      workspace = false;
      workspace-peek = false;
      workspace-popup = false;
      workspaces-in-app-grid = false;
      workspace-switcher-should-show = false;
      workspace-thumbnail-to-main-view  = false;
      workspace-wrap-around = false;
      power-icon = true;
      quick-settings = true;
      quick-settings-dark-mode = true;

    };

    #gtk4-ding extension
    "org/gnome/shell/extensions/gtk4-ding" = {
      free-position-icons = true;
      show-volumes = true;
      show-trash = false;
      show-home = false;
      start-corner = "top-right";
    };
    
    #dash to dock extension
    "org/gnome/shell/extensions/dash-to-dock" = {
      application-counter-overrides-notifications = true;
      apply-custom-theme = true;
      autohide = false;
      autohide-in-fullscreen = false;
      background-opacity = 0.45;
      click-action = "focus-minimize-or-previews";
      custom-background-color = false;
      custom-theme-shrink = true;
      customize-alphas = true;
      dance-urgent-applications = true;
      dash-max-icon-size = 64;
      disable-overview-on-startup = true;
      dock-fixed = false;
      extend-height = false;
      height-fraction = 0.90;
      hide-tooltip = false;
      hot-keys = false;
      icon-size-fixed = false;
      intellihide = true;
      intellihide-mode = "MAXIMIZED_WINDOWS";
      isolate-workspaces = false;
      max-alpha = 0.75;
      min-alpha = 0.4;
      multi-monitor = false;
      preview-size-scale = 0.0;
      running-indicator-style = "DOTS";
      scroll-to-focused-application = true;
      show-apps-always-in-the-edge = true;
      show-apps-at-top = true;
      show-favorites = true;
      show-icons-emblems = true;
      show-icons-notifications-counter = true;
      show-running = true;
      show-show-apps-button = true;
      transparency-mode = "DYNAMIC";
      workspace-agnostic-urgent-windows = true;
    };

     #search light extension
    "org/gnome/shell/extensions/search-light" = {
      #shortcut-search = ['<Control>space'];
      show-panel-icon = true;
    };

  };

  home.file = {

    ".local/share/fonts" = {
      source = ./fonts;
      recursive = true;
    };
    
  };





}