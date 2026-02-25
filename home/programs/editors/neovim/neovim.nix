{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    pgformatter
    nixfmt-rfc-style
    nixfmt-tree # for formatting whole directories
    chafa # for image previews in fzf-lua
  ];

  home.file.".config/nvim".source = ./config;

  programs.zsh = {
    enable = true;

    initContent = ''
      export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
    '';
  };

}
