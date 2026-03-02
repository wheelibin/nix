{ pkgs, ... }:

let
  kanagawaFlavor = pkgs.fetchFromGitHub {
    owner = "dangooddd";
    repo = "kanagawa.yazi";
    rev = "04985d12842b06bdb3ad5f1b3d7abc631059b7f5";
    hash = "sha256-Yz0zRVzmgbrk0m7OkItxIK6W0WkPze/t09pWFgziNrw=";
  };
in
{
  programs.yazi = {
    enable = true;
    flavors = {
      # name becomes ~/.config/yazi/flavors/kanagawa.yazi
      kanagawa = kanagawaFlavor;
    };
    theme = {
      flavor = {
        dark = "kanagawa";
      };
    };
    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "natural";
        sort_sensitive = false;
        scrolloff = 6;
        ratio = [
          1
          4
          3
        ];
        linemode = "size";
      };

      preview = {
        wrap = "yes";
        tab_size = 2;
        max_width = 1400;
        max_height = 900;
        image_delay = 5;
      };

      tasks = {
        micro_workers = 10;
        macro_workers = 4;
      };

      opener = {
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
            desc = "Neovim";
          }
        ];

        open = [
          {
            run = ''open "$@"'';
            desc = "Open";
          }
        ];

        reveal = [
          {
            run = ''open -R "$1"'';
            desc = "Reveal in Finder";
          }
        ];
      };

      open = {
        rules = [
          {
            mime = "text/*";
            use = [ "edit" ];
          }
          {
            mime = "application/json";
            use = [ "edit" ];
          }
          {
            mime = "application/x-yaml";
            use = [ "edit" ];
          }

          {
            name = "*.md";
            use = [ "edit" ];
          }
          {
            name = "*.toml";
            use = [ "edit" ];
          }
          {
            name = "*.nix";
            use = [ "edit" ];
          }
          {
            name = "*.lua";
            use = [ "edit" ];
          }
          {
            name = "*.go";
            use = [ "edit" ];
          }
          {
            name = "*.rs";
            use = [ "edit" ];
          }
          {
            name = "*.ts";
            use = [ "edit" ];
          }
          {
            name = "*.tsx";
            use = [ "edit" ];
          }
          {
            name = "*.js";
            use = [ "edit" ];
          }

          {
            mime = "image/*";
            use = [ "open" ];
          }
          {
            mime = "application/pdf";
            use = [ "open" ];
          }
        ];
      };
    };
  };
}
