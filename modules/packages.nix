{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Essential tools
    wget
    curl
    git
    vim
    nano
    htop
    tree
    unzip
    zip

    # Hyprland essentials
    waybar          # Status bar
    wofi           # Application launcher
    dunst          # Notifications
    swww           # Wallpaper daemon
    grim           # Screenshot
    slurp          # Area selection for screenshots
    wl-clipboard   # Clipboard utilities
    swaylock-effects # Screen locker

    # Terminal
    kitty          # Terminal emulator

    # File management
    dolphin        # File manager

    # Media
    pavucontrol    # Audio control
    brightnessctl  # Brightness control

    # Development
    vscode

    # Internet
    firefox

    # System utilities
    networkmanagerapplet
    bluez
    bluez-tools

    # Themes and appearance
    gtk3
    gtk4
    adwaita-icon-theme
    papirus-icon-theme
  ];

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
