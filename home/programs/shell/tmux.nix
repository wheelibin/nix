{ pkgs, config, ... }:


let
  tmux-kanagawa = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-kanagawa";
    version = "master";  # or a commit hash
    src = pkgs.fetchFromGitHub {
      owner = "Nybkox";
      repo = "tmux-kanagawa";
      rev = "master"; # You can pin to a commit later
      # run "nix build" once without sha256 to get the correct hash
      sha256 = "sha256-BcPErvbG7QwhxXgc3brSQKw3xd3jO5MHNxUj595L0uk=";
    };
    # IMPORTANT: match the actual filename in the repo
    rtpFilePath = "kanagawa.tmux";
  };
in
{
  home.file.".config/tmux/tmux-session-menu".source = ../../dotfiles/tmux/tmux-session-menu;
  home.file.".config/tmux/tmux-sessionizer".source = ../../dotfiles/tmux/tmux-sessionizer;

  # needed in case tmux looks here for the config
  home.file.".tmux.conf".source = config.xdg.configHome + "/tmux/tmux.conf";

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    baseIndex = 1;
    mouse = true;

    plugins = [
      pkgs.tmuxPlugins.sensible
      tmux-kanagawa
    ];

    # Your keybindings and extra config go here
    extraConfig = ''
      set -g default-shell "$SHELL"
      set -g default-command "$SHELL -l"

      # make colors inside tmux look the same as outside tmux
      set-option -ga terminal-overrides ",xterm-256color:Tc"

      # escape-time fix
      set-option -s escape-time 0

      # prefix M-space instead of C-b
      unbind-key C-b
      set-option -g prefix M-space
      bind-key M-space send-prefix

      # config reload
      bind-key r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # clear scrollback
      bind-key k clear-history

      # ---- pane functions ----
      bind-key -n 'M-H' split-window -h
      bind-key -n 'M-V' split-window -v
      bind-key -n 'M-enter' resize-pane -Z

      # vim-aware navigation
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'M-m' if-shell "$is_vim" 'send-keys M-m' 'select-pane -L'
      bind-key -n 'M-n' if-shell "$is_vim" 'send-keys M-n' 'select-pane -D'
      bind-key -n 'M-e' if-shell "$is_vim" 'send-keys M-e' 'select-pane -U'
      bind-key -n 'M-i' if-shell "$is_vim" 'send-keys M-i' 'select-pane -R'

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      # utils
      bind-key "M-space" display-popup -E -w 128 -h 32 -b "rounded" "~/.config/tmux/tmux-session-menu"
      bind -r f display-popup -E -w 64 -h 24 -b "rounded" "~/.config/tmux/tmux-sessionizer"
      bind -r g display-popup -h 80% -w 80% -E "lazygit"

      # Theme configs
      set -g @kanagawa-ignore-window-colors true
      set -g @kanagawa-theme 'dragon'
    '';
  };
}
