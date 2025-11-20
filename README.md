# NixOS Configuration

Modular NixOS configuration for multiple machines and user profiles.

## Structure

```
.
├── flake.nix                      # Main entry point
├── hosts/                         # Per-machine configurations
│   └── mbp/                      # MacBook Pro
│       ├── default.nix           # Machine-specific config
│       └── hardware.nix          # Hardware configuration
├── modules/                       # Reusable system modules
│   ├── core/                     # Essential system config
│   ├── hardware/                 # Hardware-specific modules
│   │   └── apple/               # Apple hardware quirks
│   └── desktop/                  # Desktop environments
└── home/                         # Home-manager configurations
    ├── profiles/                # User profiles
    │   └── jon/                # Jon's profile
    ├── programs/                # Per-program configs
    │   ├── shell/
    │   ├── editors/
    │   ├── terminal/
    │   ├── desktop/
    │   └── git/
    └── dotfiles/                # Config files
```

## Usage

### Build and switch

```bash
sudo nixos-rebuild switch --flake .#mbp
```

### Update flake inputs

```bash
nix flake update
```

### Add a new machine

1. Copy `hosts/mbp/` to `hosts/new-machine/`
2. Update `hardware.nix` with correct UUIDs
3. Modify `default.nix` imports as needed
4. Add to `flake.nix` under `nixosConfigurations`

### Add a new user profile

1. Create `home/profiles/username/default.nix`
2. Import desired program modules
3. Add profile to machine config in `flake.nix`

### Add packages

- **System-wide**: Add to appropriate module in `modules/`
- **User-specific**: Add to `home/profiles/username/packages.nix`
- **New program config**: Create module in `home/programs/`
