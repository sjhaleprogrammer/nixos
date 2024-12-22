{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

{

  imports = [
    ./hardware-configuration.nix
    ./kernel.nix
    inputs.nixos-hardware.nixosModules.asus-flow-gv302xi-amdgpu
    inputs.nixos-hardware.nixosModules.asus-flow-gv302xi-nvidia
    ./update-on-shutdown.nix
    ./../../modules/nixpkgs/qemu.nix
    ./../../modules/nixpkgs/podman.nix
  ];

  


  system = {
    stateVersion = "23.05";
    activationScripts.linkBash = {
      text = ''
        ln -sf ${pkgs.bash}/bin/bash /bin/bash
      '';
    };

  };

  nix = {

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
      persistent = true;
    };

    #optimise.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

  };


  programs.xwayland.enable = true;
  environment = {
    shells = with pkgs; [
      zsh
      bash
      dash
    ];
    binsh = "${pkgs.dash}/bin/dash";

    sessionVariables = rec {
      #NIXOS_OZONE_WL = "1"; # in the future issue -> https://github.com/electron/electron/issues/44540
      ELECTRON_OZONE_PLATFORM_HINT = "x11";
      
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [ "${XDG_BIN_HOME}" ];

    };

  };
  


  services = {

    #sound
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    #touchpad
    libinput.enable = true;

    # Enable CUPS to print documents.
    #printing.enable = true;

    #openssh = {
    #enable = true;
    #ports = [ 22552 ];
    #settings = {
    #PermitRootLogin = "no";
    #PasswordAuthentication = false;
    #KbdInteractiveAuthentication = false;
    #};

  };

  #bootloader
  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
        device = "nodev";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

  };


  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    #2 in 1 laptop
    sensor.iio.enable = true;

    logitech.wireless.enable = true;
    pulseaudio.enable = false;

    #Bluetooth
    #bluetooth.enable = true;

  };

  networking = {

    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    enableIPv6 = true;

    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "enp3s0";
      internalInterfaces = [ "wg0" ];
    };

    firewall = {
      enable = true;
      #allowedTCPPorts = [ 53 ];
      #allowedUDPPorts = [ 53 51820 ];
    };

  };

  #time
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };


  programs.zsh.enable = true;

  #users
  users = {
      mutableUsers = true;
      groups = {
        samuel.gid = 1000;
      };
  
      users.samuel = {
        isNormalUser = true;
        home = "/home/samuel";
        password = "test";
        shell = pkgs.zsh;
        uid = 1000;
        group = "samuel";
        extraGroups = [
          "wheel"
          "networkmanager"
          "gamemode"
        ]; # Enable ‘sudo’ for the user.
      };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  security = {

    sudo = {
      enable = true;
      extraRules = [
        {
          commands = [
            {
              command = "${pkgs.systemd}/bin/systemctl suspend";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.systemd}/bin/reboot";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.systemd}/bin/poweroff";
              options = [ "NOPASSWD" ];
            }
          ];
          groups = [ "wheel" ];
        }
      ];
    };

    #emulator memory
    pam.loginLimits = [
      {
        domain = "*";
        type = "hard";
        item = "memlock";
        value = "unlimited";
      }
      {
        domain = "*";
        type = "soft";
        item = "memlock";
        value = "unlimited";
      }
    ];

    #sound
    rtkit.enable = true;

  };


  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize =  8192; 
      cores = 8;         
    };
    virtualisation.resolution = {
      x = 1280;
      y = 1024;
    };
    virtualisation.qemu.options = [
      # Better display option
      "-vga virtio"
      "-display gtk,zoom-to-fit=false"
      # Enable copy/paste
      # https://www.kraxel.org/blog/2021/05/qemu-cut-paste/
      "-chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on"
      "-device virtio-serial-pci"
      "-device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0"
    ];
  };

  

}
