# hosts/vm/default.nix
{ config, pkgs, ... }:

{
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  # Basic system
  networking.hostName = "hypr-vm";
  time.timeZone = "Asia/Kuala_Lumpur";  # ← change to your zone
  i18n.defaultLocale = "en_US.UTF-8";

  # Networking
  networking.networkmanager.enable = true;

  # User (replace 'alice' with your username)
  users.users.alice = {
    isNormalUser = true;
    description = "Alice";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
  };

  # Root password (optional)
  users.users.root.initialPassword = "password";

  # Disable X11 + Plasma
  services.xserver.enable = false;
  services.displayManager.sddm.enable = false;

  # Enable Hyprland
  services.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.x86_64-linux.hyprland;
  };

  services.displayManager.defaultSession = "hyprland";

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
  ];

  # Flatpak & XDG
  services.flatpak.enable = true;
  xdg.enable = true;

  # Common packages
  environment.systemPackages = with pkgs; [
    firefox
    kitty
    neovim
    git
    wget
    unzip
    fastfetch  # nice for terminal info
  ];

  # Bootloader (adjust if UEFI or different disk)
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  swapDevices = [ ];

  # Firewall
  networking.firewall.enable = false;

  # SSH
  services.openssh.enable = true;

  # Flake features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;  # enable proprietary software
}
