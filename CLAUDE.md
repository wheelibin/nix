# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
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

This is a Nix flake configuration for standalone Home Manager on macOS.

### Module Organization

- `home/programs/` - Home Manager program modules (shell tools, editors, languages)
- `home/profiles/` - User profiles that compose program modules

### Profile Inheritance

Profiles inherit from `home/profiles/common` which provides:
- Common program imports (shell, neovim, ghostty, git, languages, fonts)
- XDG, username/home directory setup
- SSH configuration

Individual profiles (`jon_mac`, `work`) add their specific packages and program imports on top.
