# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# NixOS rebuild (on mbp machine)
sudo nixos-rebuild switch --flake .#mbp

# Home Manager (macOS)
home-manager switch --impure --flake .#jon_mac
home-manager switch --impure --flake .#work

# Update flake inputs
nix flake update

# Format nix files
nix fmt

# Check flake validity
nix flake check
```

## Architecture

This is a Nix flake configuration supporting both NixOS and standalone Home Manager on macOS.

### Key Concepts

- **NixOS configs** (`nixosConfigurations`): Full system configuration for Linux machines
- **Home Manager configs** (`homeConfigurations`): User environment configuration, used standalone on macOS

### Module Organization

- `modules/` - NixOS system modules (boot, networking, desktop environments, hardware)
- `home/programs/` - Home Manager program modules (shell tools, editors, languages)
- `home/profiles/` - User profiles that compose program modules
- `hosts/` - Per-machine NixOS configurations

### Profile Inheritance

Darwin profiles inherit from `home/profiles/common/darwin.nix` which provides:
- Common program imports (shell, neovim, ghostty, git, languages, fonts)
- XDG, username/home directory setup
- SSH configuration

Individual profiles add their specific packages and program imports on top.

### Flake Helpers

- `mkPkgs system` - Creates nixpkgs with allowUnfree for a system
- `mkSpecialArgs system` - Provides `pkgs-unstable` to modules
- `mkHomeConfig system profile` - Creates a home-manager configuration for Darwin
