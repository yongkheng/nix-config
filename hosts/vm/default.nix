# hosts/vm/default.nix
{ config, pkgs, lib, ... }:

{
  # Hostname
  networking.hostName = "hypr-vm";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "UTC";  # Change if needed

  # Networking
  networking.networkmanager.enable = true;

  # User (change 'alice' to your username)
  users.users.dummy = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
  };

  # Root password (optional)
  users.users.root.initialPassword = "password";

  # Disable KDE
  services.xserver.enable = false;
  services.displayManager.sddm.enable = false;

  # Install Hyprland
  environment.systemPackages = with pkgs; [
    inputs.hyprland.packages.x86_64-linux.hyprland
    kitty      # terminal
    wofi       # app launcher
    waybar     # status bar
    pipewire   # audio
    nixpkgs-fmt # config formatting
  ];

  # Register Hyprland as a session
  services.xserver.displayManager.sessionCommands = ''
    mkdir -p "$XDG_RUNTIME_DIR/wayland-sessions"
    cat > "$XDG_RUNTIME_DIR/wayland-sessions/hyprland.desktop" << EOF
    [Desktop Entry]
    Name=Hyprland
    Comment=Hyprland Wayland compositor
    Exec=${inputs.hyprland.packages.x86_64-linux.hyprland}/bin/Hyprland
    Type=Application
    Keywords=wayland;hypr;
    EOF
  '';

  # Default session
  services.displayManager.defaultSession = "hyprland";

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Fonts
  fonts.fonts = with pkgs; [ noto-fonts noto-fonts-emoji fira-code ];

  # Bootloader (adjust if UEFI)
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  swapDevices = [ ];

  # SSH
  services.openssh.enable = true;

  # Flake features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}
