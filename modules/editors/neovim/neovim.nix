{ pkgs-unstable, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;

    # Treesitter parsers + queries are provided by nix (compiled into the
    # store, pinned by flake.lock) rather than installed at runtime via
    # `:TSUpdate`. The native Neovim engine handles highlight/indent/fold;
    # this just supplies the grammars + query files on the runtimepath.
    # This list is the single source of truth for installed languages.
    plugins = [
      (pkgs-unstable.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.bash
        p.c
        p.comment
        p.cpp
        p.css
        p.csv
        p.dockerfile
        p.git_config
        p.git_rebase
        p.gitattributes
        p.gitcommit
        p.gitignore
        p.go
        p.gomod
        p.gosum
        p.gotmpl
        p.gowork
        p.graphql
        p.hcl
        p.html
        p.http
        p.javascript
        p.jsdoc
        p.json
        p.lua
        p.make
        p.markdown
        p.markdown_inline
        p.proto
        p.python
        p.regex
        p.sql
        p.toml
        p.tsx
        p.typescript
        p.vim
        p.xml
        p.yaml
      ]))
    ];
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
    shfmt
  ];

  home.file.".config/nvim".source = ./config;

}
