# flake.nix
{
  description = "Minimal NixOS + Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    hyprland.url = "github:hyprwm/Hyprland";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ nixpkgs, hyprland, utils, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/vm/default.nix

          # Optional: if you want home-manager later
          # {
          #   home-manager.users.youruser = { pkgs, ... }: {
          #     home.stateVersion = "25.05";
          #   };
          # }
        ];
      };

      devShell = pkgs.mkShell {
        buildInputs = [ pkgs.git ];
      };
    };
}
