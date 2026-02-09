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
