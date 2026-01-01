{
  description = "NixOS configuration with multiple machines and user profiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      ...
    }:
    let
      linuxSystem = "x86_64-linux";
      darwinSystem = "aarch64-darwin";

      mkSpecialArgs = system: {
        inherit system;
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        mbp = nixpkgs.lib.nixosSystem {
          system = linuxSystem;
          specialArgs = mkSpecialArgs linuxSystem;
          modules = [
            ./hosts/mbp
            nixos-hardware.nixosModules.apple-macbook-pro-11-5
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jon = import ./home/profiles/jon_nix;
              home-manager.extraSpecialArgs = mkSpecialArgs linuxSystem;
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };
      };

      homeConfigurations = {
        work = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = darwinSystem;
            config.allowUnfree = true;
          };
          extraSpecialArgs = mkSpecialArgs darwinSystem;
          modules = [
            ./home/profiles/work
          ];
        };
        jon_mac = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = darwinSystem;
            config.allowUnfree = true;
          };
          extraSpecialArgs = mkSpecialArgs darwinSystem;
          modules = [
            ./home/profiles/jon_mac
          ];
        };
      };
    };
}
