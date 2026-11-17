{
  description = "Home Manager configuration for macOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qrypad = {
      url = "github:wheelibin/qrypad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      qrypad,
      ...
    }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "lima-full-1.2.2"
          "lima-additional-guestagents-1.2.2"
        ];
      };

      # Behind Zscaler, buildGoModule's dependency download fails TLS because nixpkgs' cacert doesn't
      # trust it. Evaluate qrypad's own flake against a nixpkgs whose cacert does.
      qrypad-work =
        ((import "${qrypad}/flake.nix").outputs {
          self = qrypad;
          flake-utils = qrypad.inputs.flake-utils;
          nixpkgs.legacyPackages.${system} = import nixpkgs {
            inherit system;
            overlays = [
              (final: prev: {
                cacert = prev.cacert.override {
                  extraCertificateFiles = [ ./profiles/mac_work/zscaler-root-ca.pem ];
                };
              })
            ];
          };
        }).packages.${system}.default;
    in
    {
      homeConfigurations = {
        mac_home = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit system;
            qrypad-pkg = qrypad.packages.${system}.default;
          };
          modules = [ ./profiles/mac_home ];
        };

        mac_work = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit system;
            qrypad-pkg = qrypad-work;
          };
          modules = [ ./profiles/mac_work ];
        };
      };

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
