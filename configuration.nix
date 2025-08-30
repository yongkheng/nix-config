{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/hyprland.nix
    ./modules/packages.nix
    ./modules/services.nix
    ./users/dummy
  ];

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "America/New_York"; # Change to your timezone
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Disable KDE/Plasma (since you're switching to Hyprland)
  services.xserver.displayManager.sddm.enable = false;
  services.xserver.desktopManager.plasma5.enable = false;
  services.xserver.enable = false; # We'll use Wayland instead

  # Enable necessary services for Hyprland
  services.dbus.enable = true;
  xdg.portal.enable = true;

  # Security
  security.polkit.enable = true;

  system.stateVersion = "23.11"; # Don't change this after initial install
}
