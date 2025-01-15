{
  pkgs,
  config,
  lib,
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
      enable-hot-corners = false;


      #macos font
      font-name = "SF Pro Display 13";
      document-font-name = "SF Pro Display 13";
      monospace-font-name = "SF Mono 13";

    };

    #window control button layout
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:";
      titlebar-font = "SF Pro Display 13";

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
      menu-button-terminal = "mate-terminal";
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
      height-fraction = 1.0;
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

  };

  home.file = {

    ".local/share/fonts" = {
      source = ./fonts;
      recursive = true;
    };
    
  };

  home.activation = {
    

    rounded-window-corners-reborn = ''
       ${pkgs.dconf}/bin/dconf write /org/gnome/shell/extensions/rounded-window-corners-reborn/global-rounded-corner-settings "@a{sv} {'padding': <@a{sv} {'left': <uint32 1>, 'right': <uint32 1>, 'top': <uint32 1>, 'bottom': <uint32 1>}>, 'keepRoundedCorners': <@a{sv} {'maximized': <true>, 'fullscreen': <false>}>, 'borderRadius': <uint32 12>, 'smoothing': <0.0>, 'enabled': <true>}"

    '';
    
    
    
    installThemes = lib.hm.dag.entryAfter [ "writeBoundary" "installPackages" "git" ] ''
      # Check for internet connectivity by pinging a reliable host
      if ${pkgs.iputils}/bin/ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        ${pkgs.git}/bin/git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git 
        ${pkgs.git}/bin/git clone https://github.com/vinceliuice/WhiteSur-firefox-theme.git
        
        theme_dir="$HOME/WhiteSur-gtk-theme"
        install_script="$theme_dir/install.sh"

        if [ -f "$install_script" ]; then
          echo "Attempting to install WhiteSur GTK Theme..."

          # Ensure the script is executable
          chmod +x "$install_script"

          # Set up the required library paths and link them to the environment
          export PATH=${pkgs.sassc}/bin:${pkgs.which}/bin:${pkgs.getent}/bin:${pkgs.util-linux}/bin:${pkgs.glib.dev}/bin:${pkgs.libxml2.bin}/bin:${pkgs.sudo}/bin:$PATH

          # Run the installation script as the current user directly
          cd "$theme_dir"
          ${pkgs.bash}/bin/bash -c "bash $install_script -l" 
          
          # Clean up after installation
          rm -rf "$theme_dir"
        else
          echo "Theme installation script not found at $install_script"
        fi

        
        theme_dir="$HOME/WhiteSur-firefox-theme"
        install_script="$theme_dir/install.sh"

        if [ -f "$install_script" ]; then
          echo "Attempting to install WhiteSur Firefox Theme..."
          
          # Ensure the script is executable
          chmod +x "$install_script"
          
          # Run the installation script as the current user directly
          cd "$theme_dir"
          ${pkgs.bash}/bin/bash -c "export PATH=${pkgs.getent}/bin:${pkgs.firefox}/bin:${pkgs.sudo}/bin:${pkgs.gawk}/bin:\$PATH; bash $install_script -m"
          rm -rf "$theme_dir"
        else
          echo "Theme installation script not found at $install_script"
        fi
      else
        echo "No internet connection available. Skipping theme installation."
      fi
    '';

  };

}
