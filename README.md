# Nix Configuration

Home Manager configuration for macOS.

## Structure

```
.
├── flake.nix                      # Main entry point
├── profiles/                      # User profiles
│   ├── common/                    # Shared profile config
│   ├── mac_home/                  # Personal macOS profile
│   └── mac_work/                  # Work macOS profile
└── modules/                       # Home Manager modules
    ├── shell/
    ├── editors/
    ├── terminal/
    ├── desktop/
    ├── languages/
    ├── docker/
    ├── ai/
    └── git/
```

## Bootstrapping a New macOS Machine

### 1. Install Nix

https://install.determinate.systems/determinate-pkg/stable/Universal

### 2. Clone this repository

```bash
cd ~/dev
git clone git@github.com:wheelibin/nix.git
```

### 3. Bootstrap Home Manager

This will apply the home manager profile, installing apps and configs, as well as the `home-manager` command for future updates.

**NOTE: make sure you change the profile name at the end of the command**

```bash
nix run github:nix-community/home-manager/release-25.11 -- switch --impure --flake ~/dev/nix#mac_home
```

### 4. Re-applying after changes

After the bootstrap build you can simply run the shell alias `hm` to reapply.

## Usage

```bash
home-manager switch --impure --flake .#mac_home
home-manager switch --impure --flake .#mac_work
```

### Update flake inputs

```bash
nix flake update
```

This updates all flake inputs (nixpkgs, home-manager, etc.) to their latest versions and regenerates `flake.lock`. Run `home-manager switch` afterwards to apply the updates.

### Format nix files

```bash
nix fmt
```

## Adding New Configurations

### Add a new profile

1. Create `profiles/username/default.nix`
2. Import `../common` for shared base config
3. Add profile-specific imports and settings
4. Add to `flake.nix` under `homeConfigurations`

### Add packages

- **User-specific**: Add to `profiles/username/packages.nix`
- **New module**: Create module in `modules/`
