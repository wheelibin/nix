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
