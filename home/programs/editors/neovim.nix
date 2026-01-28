{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs; [
    pgformatter
    nixfmt
    nixfmt-tree # for formatting whole directories
    chafa # for image previews in fzf-lua
  ];

  home.file.".config/nvim".source = ../../dotfiles/nvim;

  programs.zsh = {
    enable = true;

    initContent = ''
      export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"
    '';
  };

}
