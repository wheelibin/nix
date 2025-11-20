#!/usr/bin/env bash
set -euo pipefail

# NixOS Configuration Refactoring Migration Script
# This script will reorganize your NixOS config into a cleaner structure

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="${SCRIPT_DIR}"

echo "🚀 Starting NixOS configuration refactoring..."
echo "Repository root: ${REPO_ROOT}"
echo ""

# Create backup branch
echo "📦 Creating backup branch..."
git checkout -b backup-before-refactor
git add -A
git commit -m "Backup before refactoring" || true

# Create new feature branch
echo "🌿 Creating refactor branch..."
git checkout -b refactor/modular-structure

# Create new directory structure
echo "📁 Creating new directory structure..."
mkdir -p hosts/mbp
mkdir -p modules/core
mkdir -p modules/hardware/apple
mkdir -p modules/desktop
mkdir -p home/profiles/jon
mkdir -p home/programs/shell
mkdir -p home/programs/editors
mkdir -p home/programs/terminal
mkdir -p home/programs/desktop
mkdir -p home/programs/git

# Keep dotfiles in place (just move them if needed)
if [ -d "home/dotfiles" ]; then
  echo "✅ Dotfiles directory already exists"
else
  echo "📁 Creating dotfiles directory..."
  mkdir -p home/dotfiles
fi

echo ""
echo "📝 Creating new configuration files..."

# ============================================================================
# Create flake.nix
# ============================================================================
cat > flake.nix << 'EOF'
{
  description = "NixOS configuration with multiple machines and user profiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, ... }:
    let
      system = "x86_64-linux";
      
      mkSpecialArgs = system: {
        inherit system;
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        mbp = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = mkSpecialArgs system;
          modules = [
            ./hosts/mbp
            nixos-hardware.nixosModules.apple-macbook-pro-11-5
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jon = import ./home/profiles/jon;
              home-manager.extraSpecialArgs = mkSpecialArgs system;
            }
          ];
        };
      };
    };
}
EOF

# ============================================================================
# Create hosts/mbp/default.nix
# ============================================================================
cat > hosts/mbp/default.nix << 'EOF'
{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core
    ../../modules/desktop/hyprland.nix
    ../../modules/hardware/apple
  ];

  networking.hostName = "mbp";

  system.stateVersion = "25.05";
}
EOF

# ============================================================================
# Move hardware configuration
# ============================================================================
if [ -f "hardware-configuration.nix" ]; then
  echo "📋 Moving hardware-configuration.nix..."
  cp hardware-configuration.nix hosts/mbp/hardware.nix
fi

# ============================================================================
# Create modules/core/default.nix
# ============================================================================
cat > modules/core/default.nix << 'EOF'
{ ... }:

{
  imports = [
    ./boot.nix
    ./nix.nix
    ./networking.nix
    ./users.nix
  ];
}
EOF

# ============================================================================
# Create modules/core/boot.nix
# ============================================================================
cat > modules/core/boot.nix << 'EOF'
{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
EOF

# ============================================================================
# Create modules/core/nix.nix
# ============================================================================
cat > modules/core/nix.nix << 'EOF'
{ pkgs, ... }:

{
  nix.package = pkgs.nixVersions.latest;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}
EOF

# ============================================================================
# Create modules/core/networking.nix
# ============================================================================
cat > modules/core/networking.nix << 'EOF'
{ ... }:

{
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
}
EOF

# ============================================================================
# Create modules/core/users.nix
# ============================================================================
cat > modules/core/users.nix << 'EOF'
{ pkgs, ... }:

{
  users.users.jon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  programs.gnupg.agent.enable = true;
}
EOF

# ============================================================================
# Create modules/hardware/apple/default.nix
# ============================================================================
cat > modules/hardware/apple/default.nix << 'EOF'
{ ... }:

{
  imports = [
    ./mbp.nix
    ./fans.nix
    ./wifi.nix
    ./power.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
EOF

# ============================================================================
# Create modules/hardware/apple/mbp.nix
# ============================================================================
cat > modules/hardware/apple/mbp.nix << 'EOF'
{ ... }:

{
  boot.kernelModules = [ "applesmc" "coretemp" ];
}
EOF

# ============================================================================
# Create modules/hardware/apple/fans.nix
# ============================================================================
cat > modules/hardware/apple/fans.nix << 'EOF'
{ ... }:

{
  services.mbpfan.enable = true;
}
EOF

# ============================================================================
# Create modules/hardware/apple/wifi.nix
# ============================================================================
cat > modules/hardware/apple/wifi.nix << 'EOF'
{ pkgs, ... }:

{
  boot.extraModprobeConfig = ''
    # Work around Broadcom suspend/resume issues
    options brcmfmac roamoff=1
  '';

  systemd.services.fix-wifi-resume = {
    description = "Reload WiFi module after resume";
    after = [ "network.target" "sleep.target" ];
    wantedBy = [ "sleep.target" ];

    serviceConfig.Type = "simple";
    serviceConfig.ExecStart = "${pkgs.kmod}/bin/modprobe -r brcmfmac";
    serviceConfig.ExecStartPost = "${pkgs.kmod}/bin/modprobe brcmfmac";
  };
}
EOF

# ============================================================================
# Create modules/hardware/apple/power.nix
# ============================================================================
cat > modules/hardware/apple/power.nix << 'EOF'
{ ... }:

{
  powerManagement.enable = true;
  services.tlp.enable = true;

  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "suspend";
}
EOF

# ============================================================================
# Create modules/desktop/hyprland.nix
# ============================================================================
cat > modules/desktop/hyprland.nix << 'EOF'
{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./common.nix
    ./fonts.nix
  ];

  services.xserver.enable = false;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;

  programs.hyprland.enable = true;
  security.pam.services.hyprlock = {};

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    rofi
    hyprpaper
    hypridle
    hyprlock
    hyprpolkitagent
    mako
    alacritty
    grim
    slurp
    wl-clipboard
    jq
    brightnessctl
    pamixer
    firefox
    neovim
    dropbox
    git
    gnupg
    gcc
    pkgs-unstable.sunsetr
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "jon";
      };
    };
  };
}
EOF

# ============================================================================
# Create modules/desktop/common.nix
# ============================================================================
cat > modules/desktop/common.nix << 'EOF'
{ ... }:

{
  # Common desktop settings
}
EOF

# ============================================================================
# Create modules/desktop/fonts.nix
# ============================================================================
cat > modules/desktop/fonts.nix << 'EOF'
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
EOF

# ============================================================================
# Create home/profiles/jon/default.nix
# ============================================================================
cat > home/profiles/jon/default.nix << 'EOF'
{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ../../programs/shell
    ../../programs/editors/neovim.nix
    ../../programs/terminal/alacritty.nix
    ../../programs/desktop/hyprland.nix
    ../../programs/desktop/waybar.nix
    ../../programs/git
  ];

  home.username = "jon";
  home.homeDirectory = "/home/jon";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        host = "github.com";
        identityFile = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
        extraOptions = {
          AddKeysToAgent = "yes";
        };
      };
    };
  };

  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox daemon";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
EOF

# ============================================================================
# Create home/profiles/jon/packages.nix
# ============================================================================
cat > home/profiles/jon/packages.nix << 'EOF'
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    jellyfin-media-player
    legcord
    btop
    eza
    fd
    ripgrep
    pass
  ];
}
EOF

# ============================================================================
# Create home/programs/shell/default.nix
# ============================================================================
cat > home/programs/shell/default.nix << 'EOF'
{ ... }:

{
  imports = [
    ./zsh.nix
    ./starship.nix
    ./fzf.nix
  ];
}
EOF

# ============================================================================
# Create home/programs/shell/zsh.nix
# ============================================================================
cat > home/programs/shell/zsh.nix << 'EOF'
{ ... }:

{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ ];
    };

    initExtra = ''
      # Fix TERM from Ghostty when SSH-ing
      if [[ "$TERM" = "xterm-ghostty" ]]; then
        export TERM="xterm-256color"
      fi
      export EDITOR="nvim"
      alias ll="eza -l"
      alias gs="git status"
      
      export ELECTRON_ENABLE_WAYLAND=1
    '';
  };
}
EOF

# ============================================================================
# Create home/programs/shell/starship.nix
# ============================================================================
cat > home/programs/shell/starship.nix << 'EOF'
{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/starship.toml".source = ../../dotfiles/starship.toml;
}
EOF

# ============================================================================
# Create home/programs/shell/fzf.nix
# ============================================================================
cat > home/programs/shell/fzf.nix << 'EOF'
{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
EOF

# ============================================================================
# Create home/programs/editors/neovim.nix
# ============================================================================
cat > home/programs/editors/neovim.nix << 'EOF'
{ ... }:

{
  home.file.".config/nvim".source = ../../dotfiles/nvim;
}
EOF

# ============================================================================
# Create home/programs/terminal/alacritty.nix
# ============================================================================
cat > home/programs/terminal/alacritty.nix << 'EOF'
{ ... }:

{
  home.file.".config/alacritty".source = ../../dotfiles/alacritty;
}
EOF

# ============================================================================
# Create home/programs/desktop/hyprland.nix
# ============================================================================
cat > home/programs/desktop/hyprland.nix << 'EOF'
{ ... }:

{
  home.file.".config/hypr".source = ../../dotfiles/hypr;
}
EOF

# ============================================================================
# Create home/programs/desktop/waybar.nix
# ============================================================================
cat > home/programs/desktop/waybar.nix << 'EOF'
{ ... }:

{
  home.file.".config/waybar".source = ../../dotfiles/waybar;
}
EOF

# ============================================================================
# Create home/programs/git/default.nix
# ============================================================================
cat > home/programs/git/default.nix << 'EOF'
{ ... }:

{
  programs.git = {
    enable = true;
    # Add your git config here:
    # userName = "Your Name";
    # userEmail = "your.email@example.com";
  };
}
EOF

# ============================================================================
# Create README
# ============================================================================
cat > README.md << 'EOF'
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
EOF

echo ""
echo "✅ File structure created successfully!"
echo ""

# Remove old files
echo "🗑️  Removing old configuration files..."
[ -f "modules/base.nix" ] && git rm -f modules/base.nix || true
[ -f "modules/desktop-hyprland.nix" ] && git rm -f modules/desktop-hyprland.nix || true
[ -f "home/jon.nix" ] && git rm -f home/jon.nix || true

echo ""
echo "📊 Checking git status..."
git add -A
git status

echo ""
echo "✅ Migration complete!"
echo ""
echo "Next steps:"
echo "1. Review the changes with: git diff --cached"
echo "2. Test the configuration: sudo nixos-rebuild test --flake .#mbp"
echo "3. Commit the changes: git commit -m 'refactor: modular configuration structure'"
echo "4. Push and create PR: git push -u origin refactor/modular-structure"
echo ""
echo "After pushing, go to your repository on GitHub and create a Pull Request."
