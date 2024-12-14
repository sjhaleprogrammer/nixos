{ config, pkgs, ... }: {
  systemd.services.custom-system-update = {
    description = "Custom System Update and Maintenance Script on Shutdown";
    wantedBy = [ "shutdown.target" ];
    before = [ "shutdown.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.coreutils}/bin/true";
      ExecStop = "${pkgs.writeShellScript "system-update-script" ''
        #!/bin/sh
        set -e

        # Logging
        LOG_FILE="/var/log/system-update.log"
        exec > >(tee -a "$LOG_FILE") 2>&1

        echo "Starting system update at $(date)"

        # Define the path to your flake.nix file
        FLAKE_PATH="/etc/nixos/"

        # Update the flake
        echo "Updating flake..."
        nix flake update --flake "$FLAKE_PATH"

        # Run the NixOS rebuild
        echo "Rebuilding NixOS..."
        sudo nixos-rebuild boot --flake "$FLAKE_PATH#GV302XI"

        # Run home-manager rebuild
        echo "Rebuilding home-manager for samuel..."
        sudo -u samuel home-manager switch --flake "$FLAKE_PATH#samuel"

        # Collect garbage
        echo "Collecting garbage..."
        nix-collect-garbage -d

        echo "System update completed at $(date)"
      ''}";
    };
  };

}
