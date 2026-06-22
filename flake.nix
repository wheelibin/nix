{
  description = "Home Manager configuration for macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gitlogue.url = "github:unhappychoice/gitlogue";
    qrypad.url = "github:wheelibin/qrypad";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      gitlogue,
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

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations = {
        mac_home = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit system pkgs-unstable;
            gitlogue-pkg = gitlogue.packages.${system}.default;
            qrypad-pkg = qrypad.packages.${system}.default;
          };
          modules = [ ./profiles/mac_home ];
        };

        mac_work = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit system pkgs-unstable;
            gitlogue-pkg = gitlogue.packages.${system}.default;
            qrypad-pkg = qrypad.packages.${system}.default;
          };
          modules = [ ./profiles/mac_work ];
        };
      };

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
