{
  description = "NixOS on MacBookPro11,5 (base flake)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }: {
    nixosConfigurations.mbp = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./hosts/mbp/default.nix

        # Hardware quirks & sensors for MacBookPro11,5
        nixos-hardware.nixosModules.apple-macbook-pro-11-5

        # Home Manager integrated into NixOS
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jon = import ./home/jon.nix;
        }
      ];
    };

    # (We’ll add macOS home config later down here)
  };
}
