# flake.nix
{
  description = "My NixOS Configuration with Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ nixpkgs, home-manager, hyprland, utils, ... }:
    utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hostname = "vm";  # corresponds to hosts/vm/
      in
      {
        nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${hostname}/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alice = import ./home/alice.nix;  # ← change 'alice'
            }
          ];
        };

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [ nixpkgs-fmt git ];
        };
      });
}
