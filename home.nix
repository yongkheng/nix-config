{ config, pkgs, ... }:

{
  # Define user account
  users.users.dummy = {
    isNormalUser = true;
    description = "Dummy User";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "input"
      "storage"
    ];
    shell = pkgs.bash;
  };

  # Auto login (optional, remove if you want login screen)
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "dummy";

  # Workaround for GNOME autologin
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
