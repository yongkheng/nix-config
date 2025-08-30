{ config, pkgs, ... }:

{
  # Enable essential services
  services = {
    # Network management
    networkmanager.enable = true;

    # SSH (optional)
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

    # Print service (if needed)
    printing.enable = true;

    # Location service for automatic timezone/night light
    geoclue2.enable = true;

    # Thumbnail generation
    tumbler.enable = true;

    # GVFS for file manager
    gvfs.enable = true;

    # UDisks for automatic mounting
    udisks2.enable = true;

    # Power management
    thermald.enable = true;
    tlp.enable = true;
  };

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize nix store
  nix.settings.auto-optimise-store = true;
}
