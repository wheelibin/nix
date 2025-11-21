{ ... }:

{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ ];
    };

    initContent = ''
      # Fix TERM from Ghostty when SSH-ing
      if [[ "$TERM" = "xterm-ghostty" ]]; then
        export TERM="xterm-256color"
      fi
      export EDITOR="nvim"
      
      export ELECTRON_ENABLE_WAYLAND=1
    '';
  };
}
