# Nix Configuration

Home Manager configuration for macOS.

## Structure

```
.
├── flake.nix                      # Main entry point
└── home/                          # Home-manager configurations
    ├── profiles/                  # User profiles
    │   ├── common/                # Shared profile config
    │   │   └── default.nix        # Base config for all profiles
    │   ├── jon_mac/               # Personal macOS profile
    │   └── work/                  # Work macOS profile
    └── programs/                  # Per-program configs
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
nix run github:nix-community/home-manager/release-25.11 -- switch --impure --flake ~/dev/nix#work
```

### 4. Re-applying after changes

After the bootstrap build you can simply run the shell alias `hm` to reapply.

## Usage

```bash
home-manager switch --impure --flake .#jon_mac
home-manager switch --impure --flake .#work
```

### Update flake inputs

```bash
nix flake update
```

### Format nix files

```bash
nix fmt
```

## Adding New Configurations

### Add a new profile

1. Create `home/profiles/username/default.nix`
2. Import `../common` for shared base config
3. Add profile-specific imports and settings
4. Add to `flake.nix` under `homeConfigurations`

### Add packages

- **User-specific**: Add to `home/profiles/username/packages.nix`
- **New program config**: Create module in `home/programs/`
