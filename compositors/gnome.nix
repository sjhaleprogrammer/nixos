{
  pkgs,
  ...
}:

{

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [ ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # And ensure gnome-settings-daemon udev rules are enabled
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  #minimal gnome
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-console
      #gnome-text-editor
      #snapshot
      #loupe
      gnome-photos
      gnome-tour
      gnome-connections
      simple-scan
      gnome-usage
    ])
    ++ (with pkgs; [
      #gnome-calculator
      gnome-system-monitor
      #file-roller
      #baobab
      cheese
      #gnome-disk-utility
      gnome-logs
      seahorse
      eog
      gnome-maps
      gnome-font-viewer
      yelp
      gnome-calendar
      gnome-contacts
      gnome-music
      gnome-software
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      gnome-weather
      gnome-clocks
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  services.xserver.excludePackages = (with pkgs; [ xterm ]);

  environment.systemPackages = with pkgs; [

    switcheroo-control # dbus for dual gpu

    gnome-tweaks

    gnome-themes-extra

    #video player
    celluloid

    #recording
    obs-studio


    


    #libraries
    ntfs3g
    linuxHeaders
    linux-firmware
    fakeroot
    alsa-utils
    alsa-firmware
    gjs

    #utilities
    pywal
    killall
    pamixer
    brightnessctl
    upower
    streamlink
    wget
    unzip
    time
    socat
    rsync
    ripgrep
    fzf
    fastfetch
    mpc-cli
    mlocate
    inotify-tools
    groff
    ffmpegthumbnailer
    jellyfin-ffmpeg
    fd
    dialog
    bat
    which
    poppler_utils
    p7zip
    atool
    unrar
    odt2txt
    xlsx2csv
    jq
    mediainfo
    imagemagick
    libnotify
    mangohud

    appimage-run # runs appimages
    steam-run # runs linux binaries

  ];

  #dual gpu support services
  services.switcherooControl.enable = true;

}
