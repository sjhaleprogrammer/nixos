{
  pkgs,
  config,
  lib,
  ...
}:

{

  gtk = {
    theme = {
      name = "Yaru-dark";
    };
  };

  home.packages = with pkgs; [
    ubuntu-sans
    ubuntu-sans-mono
    yaru-theme

    gnomeExtensions.appindicator
    gnomeExtensions.screen-rotate # 2 in 1 display extension
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.gtk4-desktop-icons-ng-ding
    gnomeExtensions.dash-to-dock
  

  ];

  dconf.settings = {

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        user-themes.extensionUuid 
        appindicator.extensionUuid
        screen-rotate.extensionUuid
        gnome-40-ui-improvements.extensionUuid
        gtk4-desktop-icons-ng-ding.extensionUuid
        dash-to-dock.extensionUuid
      ];
    };

    "org/gnome/deskop/a11y" = {
      always-show-universal-access-status = true;
    };

    "org/gnome/desktop/interface" = {
        accent-color = "orange";
        avatar-directories = [];
        can-change-accels = false;
        clock-format = "24h";
        clock-show-date = true;
        clock-show-seconds = false;
        clock-show-weekday = false;
        color-scheme = "prefer-dark";
        cursor-blink = true;
        cursor-blink-time = 1200;
        cursor-blink-timeout = 10;
        cursor-size = 24;
        cursor-theme = "Yaru";
        document-font-name = "Sans 11";
        enable-animations = true;
        enable-hot-corners = false;
        font-antialiasing = "rgba";
        font-hinting = "slight";
        font-name = "Ubuntu Sans 11";
        font-rgba-order = "rgb";
        gtk-color-palette = "black:white:gray50:red:purple:blue:light blue:green:yellow:orange:lavender:brown:goldenrod4:dodger blue:pink:light green:gray10:gray30:gray75:gray90";
        gtk-color-scheme = "";
        gtk-enable-primary-paste = true;
        gtk-im-module = "";
        gtk-im-preedit-style = "callback";
        gtk-im-status-style = "callback";
        gtk-key-theme = "Default";
        gtk-theme = "Yaru-dark";
        gtk-timeout-initial = 200;
        gtk-timeout-repeat = 20;
        icon-theme = "Yaru-dark";
        locate-pointer = false;
        menubar-accel = "F10";
        menubar-detachable = false;
        menus-have-tearoff = false;
        monospace-font-name = "Ubuntu Sans Mono 13";
        overlay-scrolling = true;
        scaling-factor = 0;
        show-battery-percentage = false;
        text-scaling-factor = 1.0;
        toolbar-detachable = false;
        toolbar-icons-size = "large";
        toolbar-style = "both-horiz";
        toolkit-accessibility = false;
    };

    #window control button layout
    "org/gnome/desktop/wm/preferences" = {
        action-double-click-titlebar = "toggle-maximize";
        action-middle-click-titlebar = "lower";
        action-right-click-titlebar = "menu";
        audible-bell = true;
        auto-raise = false;
        auto-raise-delay = 500;
        button-layout = ":minimize,maximize,close";
        disable-workarounds = false;
        focus-mode = "click";
        focus-new-windows = "smart";
        mouse-button-modifier = "<Super>";
        num-workspaces = 4;
        raise-on-click = true;
        resize-with-right-button = false;
        theme = "Adwaita";
        titlebar-font = "Ubuntu Sans Bold 11";
        titlebar-uses-system-font = false;
        visual-bell = false;
        visual-bell-type = "fullscreen-flash";
        workspace-names = [];
    };

    "org/gnome/mutter" = {
        attach-modal-dialogs = true;
        auto-maximize = true;
        center-new-windows = false;
        check-alive-timeout = 5000;
        draggable-border-width = 10;
        dynamic-workspaces = true;
        edge-tiling = true;
        experimental-features = [];
        focus-change-on-pointer-rest = true;
        locate-pointer-key = "Control_L";
        overlay-key = "Super_L";
        workspaces-only-on-primary = true;

    };

    "org/gnome/shell/extensions/appindicator" = {
        custom-icons = [ ];
        icon-brightness = 0.0;
        icon-contrast = 0.0;
        icon-opacity = 240;
        icon-saturation = 0.0;
        icon-size = 0;
        icon-spacing = 12;
        legacy-tray-enabled = true;
        tray-order = 1;
        tray-pos = "right";
    };

    #gtk4-ding extension
    "org/gnome/shell/extensions/gtk4-ding" = {
        add-volumes-opposite = true;
        arrangeorder = "DESCENDINGNAME";
        check-x11wayland = true;
        dark-text-in-labels = false;
        icon-size = "standard";
        keep-arranged = false;
        keep-stacked = false;
        show-drop-place = true;
        show-home = true;
        show-link-emblem = true;
        show-network-volumes = false;
        show-trash = false;
        show-volumes = false;
        sort-special-folders = false;
        start-corner = "bottom-right";
        unstackedtypes = [];
        use-nemo = false;
    };
    
    #dash to dock extension
    "org/gnome/shell/extensions/dash-to-dock" = {
        activate-single-window = true;
        always-center-icons = false;
        animate-show-apps = true;
        animation-time = 0.2;
        app-ctrl-hotkey-1 = [ "<Ctrl><Super>1" ];
        app-ctrl-hotkey-10 = [ "<Ctrl><Super>0" ];
        app-ctrl-hotkey-2 = [ "<Ctrl><Super>2" ];
        app-ctrl-hotkey-3 = [ "<Ctrl><Super>3" ];
        app-ctrl-hotkey-4 = [ "<Ctrl><Super>4" ];
        app-ctrl-hotkey-5 = [ "<Ctrl><Super>5" ];
        app-ctrl-hotkey-6 = [ "<Ctrl><Super>6" ];
        app-ctrl-hotkey-7 = [ "<Ctrl><Super>7" ];
        app-ctrl-hotkey-8 = [ "<Ctrl><Super>8" ];
        app-ctrl-hotkey-9 = [ "<Ctrl><Super>9" ];
        app-hotkey-1 = [ "<Super>1" ];
        app-hotkey-10 = [ "<Super>0" ];
        app-hotkey-2 = [ "<Super>2" ];
        app-hotkey-3 = [ "<Super>3" ];
        app-hotkey-4 = [ "<Super>4" ];
        app-hotkey-5 = [ "<Super>5" ];
        app-hotkey-6 = [ "<Super>6" ];
        app-hotkey-7 = [ "<Super>7" ];
        app-hotkey-8 = [ "<Super>8" ];
        app-hotkey-9 = [ "<Super>9" ];
        app-shift-hotkey-1 = [ "<Shift><Super>1" ];
        app-shift-hotkey-10 = [ "<Shift><Super>0" ];
        app-shift-hotkey-2 = [ "<Shift><Super>2" ];
        app-shift-hotkey-3 = [ "<Shift><Super>3" ];
        app-shift-hotkey-4 = [ "<Shift><Super>4" ];
        app-shift-hotkey-5 = [ "<Shift><Super>5" ];
        app-shift-hotkey-6 = [ "<Shift><Super>6" ];
        app-shift-hotkey-7 = [ "<Shift><Super>7" ];
        app-shift-hotkey-8 = [ "<Shift><Super>8" ];
        app-shift-hotkey-9 = [ "<Shift><Super>9" ];
        application-counter-overrides-notifications = true;
        apply-custom-theme = false;
        apply-glossy-effect = true;
        autohide = true;
        autohide-in-fullscreen = false;
        background-color = "#ffffff";
        background-opacity = 0.8;
        bolt-support = true;
        click-action = "focus-or-appspread";
        custom-background-color = false;
        custom-theme-customize-running-dots = false;
        custom-theme-running-dots-border-color = "#ffffff";
        custom-theme-running-dots-border-width = 0;
        custom-theme-running-dots-color = "#ffffff";
        custom-theme-shrink = true;
        customize-alphas = false;
        dance-urgent-applications = true;
        dash-max-icon-size = 48;
        default-windows-preview-to-open = false;
        disable-overview-on-startup = true;
        dock-fixed = true;
        dock-position = "LEFT";
        extend-height = true;
        force-straight-corner = false;
        height-fraction = 0.9;
        hide-delay = 0.2;
        hide-tooltip = false;
        hot-keys = true;
        hotkeys-overlay = true;
        hotkeys-show-dock = true;
        icon-size-fixed = true;
        intellihide = true;
        intellihide-mode = "ALL_WINDOWS";
        isolate-locations = true;
        isolate-monitors = false;
        isolate-workspaces = false;
        manualhide = false;
        max-alpha = 0.8;
        middle-click-action = "launch";
        min-alpha = 0.2;
        minimize-shift = true;
        multi-monitor = false;
        preferred-monitor = -2;
        preferred-monitor-by-connector = "primary";
        pressure-threshold = 100.0;
        preview-size-scale = 0.0;
        require-pressure-to-show = true;
        running-indicator-dominant-color = false;
        running-indicator-style = "DOTS";
        scroll-action = "switch-workspace";
        scroll-switch-workspace = true;
        scroll-to-focused-application = true;
        shift-click-action = "launch";
        shift-middle-click-action = "minimize";
        shortcut = [ "<Super>q" ];
        shortcut-text = "<Super>q";
        shortcut-timeout = 2.0;
        show-apps-always-in-the-edge = true;
        show-apps-at-top = false;
        show-delay = 0.25;
        show-dock-urgent-notify = true;
        show-favorites = true;
        show-icons-emblems = true;
        show-icons-notifications-counter = true;
        show-mounts = true;
        show-mounts-network = true;
        show-mounts-only-mounted = false;
        show-running = true;
        show-show-apps-button = true;
        show-trash = true;
        show-windows-preview = true;
        transparency-mode = "DEFAULT";
        unity-backlit-items = false;
        workspace-agnostic-urgent-windows = true;
        workspace-agnostic-windows = true;
    };
      
  };

    

}



