{
  pkgs,
  ...
}:

{

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];

  services.xserver.excludePackages = (with pkgs; [ xterm ]);

  environment.systemPackages = with pkgs; [




    #video player
    celluloid

    #zsh shit
    starship

    #recording
    obs-studio



  

    #school shit

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
