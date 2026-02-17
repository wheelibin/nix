# NixOS Configuration

Modular NixOS configuration for multiple machines and user profiles.

## Structure

```
.
├── flake.nix                      # Main entry point
├── hosts/                         # Per-machine configurations
│   └── mbp/                       # MacBook Pro (NixOS)
│       ├── default.nix            # Machine-specific config
│       └── hardware.nix           # Hardware configuration
├── modules/                       # Reusable NixOS modules
│   ├── core/                      # Essential system config
│   ├── hardware/                  # Hardware-specific modules
│   │   └── apple/                 # Apple hardware quirks
│   └── desktop/                   # Desktop environments
└── home/                          # Home-manager configurations
    ├── profiles/                  # User profiles
    │   ├── common/                # Shared profile modules
    │   │   └── darwin.nix         # Base config for Darwin profiles
    │   ├── jon_mac/               # macOS personal profile
    │   ├── jon_nix/               # NixOS profile
    │   └── work/                  # Work macOS profile
    ├── programs/                  # Per-program configs
    │   ├── shell/
    │   ├── editors/
    │   ├── terminal/
    │   ├── desktop/
    │   ├── languages/
    │   ├── docker/
    │   ├── ai/
    │   └── git/
    └── dotfiles/                  # Config files
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

### NixOS (mbp)

```bash
sudo nixos-rebuild switch --flake .#mbp
```

### Home Manager (macOS)

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

### Add a new machine

1. Copy `hosts/mbp/` to `hosts/new-machine/`
2. Update `hardware.nix` with correct UUIDs
3. Modify `default.nix` imports as needed
4. Add to `flake.nix` under `nixosConfigurations`

### Add a new Darwin profile

1. Create `home/profiles/username/default.nix`
2. Import `../common/darwin.nix` for shared base config
3. Add profile-specific imports and settings
4. Add to `flake.nix`: `username = mkHomeConfig darwinSystem "username";`

### Add a new NixOS profile

1. Create `home/profiles/username/default.nix`
2. Import desired program modules
3. Add profile to machine config in `flake.nix` under `home-manager.users`

### Add packages

- **System-wide**: Add to appropriate module in `modules/`
- **User-specific**: Add to `home/profiles/username/packages.nix`
- **New program config**: Create module in `home/programs/`
