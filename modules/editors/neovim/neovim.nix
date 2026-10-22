{ pkgs-unstable, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
    # Home Manager's generated init.lua would land inside the out-of-store
    # `.config/nvim` symlink; load it through the wrapper instead.
    sideloadInitLua = true;

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
        p.diff
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
        p.helm
        p.html
        p.http
        p.javascript
        p.jsdoc
        p.json
        p.lua
        p.make
        p.markdown
        p.markdown_inline
        p.nix
        p.proto
        p.python
        p.regex
        p.sql
        p.terraform
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
    # LSP servers
    basedpyright
    bash-language-server
    gopls
    lua-language-server
    nixd
    terraform-ls
    typescript-language-server
    vscode-langservers-extracted # html, css, json, eslint
    yaml-language-server
    clang-tools # provides clangd

    # formatters
    stylua
    pgformatter
    nixfmt
    nixfmt-tree # for formatting whole directories
    shfmt
  ];

  # Symlink to the working tree (not the store) so Lua edits apply without a
  # switch; not pinned per generation. Falls back to the store copy when the
  # repo isn't cloned at ~/dev/nix (needs --impure for pathExists).
  home.file.".config/nvim".source =
    let
      live = "${config.home.homeDirectory}/dev/nix/modules/editors/neovim/config";
    in
    if builtins.pathExists live then config.lib.file.mkOutOfStoreSymlink live else ./config;

}
