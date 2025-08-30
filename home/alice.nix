# home/alice.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    wofi
    swaybg
    brightnessctl
    pamixer
    playerctl
    xdg-utils
  ];

  programs.home-manager.enable = true;

  # Shell
  programs.bash.enable = true;
  programs.bash.shellAliases = {
    ll = "ls -la";
    vim = "nvim";
  };

  # Terminal
  programs.kitty.enable = true;

  # XDG
  xdg.userDirs.enable = true;

  # Wayland environment variables
  home.sessionVariables = {
    GTK_USE_PORTAL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
