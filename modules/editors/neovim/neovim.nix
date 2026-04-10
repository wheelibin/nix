{ pkgs-unstable, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.packages = with pkgs-unstable; [
    chafa # for image previews in fzf-lua

    # LSP servers
    basedpyright
    gopls
    lua-language-server
    terraform-ls
    typescript-language-server
    vscode-langservers-extracted # html, css, json, eslint
    yaml-language-server

    # formatters
    stylua
    pgformatter
    nixfmt
    nixfmt-tree # for formatting whole directories
  ];

  home.file.".config/nvim".source = ./config;

}
