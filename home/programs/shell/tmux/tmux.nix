{ pkgs, config, ... }:

{
  home.file.".config/tmux/tmux-session-menu".source = ./tmux-session-menu;
  home.file.".config/tmux/tmux-sessionizer".source = ./tmux-sessionizer;

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    baseIndex = 1;
    mouse = true;
    clock24 = true;
    prefix = "M-space";
    escapeTime = 0;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = kanagawa;
        extraConfig = ''
          set -g @kanagawa-ignore-window-colors true
          set -g @kanagawa-theme 'dragon'
          set -g @kanagawa-show-battery false
          set -g @kanagawa-show-powerline true
          set -g @kanagawa-refresh-rate 10
          set -g @kanagawa-plugins "time git"
        '';
      }
    ];

    # Your keybindings and extra config go here
    extraConfig = ''
      # ensure login shell is used
      set -g default-shell "$SHELL"
      set -g default-command "$SHELL -l"

      # make colors inside tmux look the same as outside tmux
      set-option -ga terminal-overrides ",xterm-256color:Tc"

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
      bind -r f display-popup -E -w 48 -h 24 -b "rounded" "~/.config/tmux/tmux-sessionizer"
      bind -r g display-popup -h 80% -w 80% -E "lazygit"

    '';
  };

  programs.zsh = {
    enable = true;
    initContent = ''
      # Auto-attach tmux (safe: only for interactive shells, and only if not already inside tmux)
      if [[ -z "$TMUX" && -o interactive ]]; then
        tmux attach -t default || tmux new -s default
      fi
    '';
  };
}
