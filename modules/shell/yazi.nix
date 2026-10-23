{ ... }:

let
  c = (import ../theme.nix).roles;
  fgOn = col: { fg = col; };
  main = bg: {
    fg = c.bg;
    inherit bg;
  };
  alt = fg: {
    inherit fg;
    bg = c.surface;
  };
in
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    theme = {
      mgr = {
        marker_copied = {
          fg = c.success;
          bg = c.success;
        };
        marker_cut = {
          fg = c.error;
          bg = c.error;
        };
        marker_marked = {
          fg = c.special;
          bg = c.special;
        };
        marker_selected = {
          fg = c.highlight;
          bg = c.highlight;
        };
        cwd = fgOn c.warning;
        find_keyword = {
          fg = c.highlight;
          bg = c.bg;
        };
        find_position = { };
        count_copied = main c.success;
        count_cut = main c.error;
        count_selected = main c.highlight;
        border_symbol = "│";
        border_style = fgOn c.muted;
      };
      indicator = {
        parent = {
          reversed = true;
        };
        current = {
          reversed = true;
        };
        preview = {
          reversed = true;
        };
      };
      tabs = {
        active = main c.accent;
        inactive = alt c.accent;
        sep_inner = {
          open = "";
          close = "";
        };
        sep_outer = {
          open = "";
          close = "";
        };
      };
      mode = {
        normal_main = main c.accent;
        normal_alt = alt c.accent;
        select_main = main c.special;
        select_alt = alt c.special;
        unset_main = main c.warning;
        unset_alt = alt c.warning;
      };
      status = {
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
        overall = {
          fg = c.subtle;
          bg = c.bg;
        };
        progress_label = {
          fg = c.accent;
          bold = true;
        };
        progress_normal = {
          fg = c.surface;
          bg = c.bg;
        };
        progress_error = {
          fg = c.error;
          bg = c.bg;
        };
        perm_type = fgOn c.success;
        perm_read = fgOn c.warning;
        perm_write = fgOn c.error;
        perm_exec = fgOn c.info;
        perm_sep = fgOn c.special;
      };
      pick = {
        border = fgOn c.border;
        active = {
          fg = c.special;
          bold = true;
        };
        inactive = { };
      };
      input = {
        border = fgOn c.border;
        title = { };
        value = { };
        selected = {
          reversed = true;
        };
      };
      completion = {
        border = fgOn c.border;
        active = {
          reversed = true;
        };
        inactive = { };
      };
      tasks = {
        border = fgOn c.border;
        title = { };
        hovered = fgOn c.special;
      };
      which = {
        cols = 2;
        separator = " - ";
        separator_style = fgOn c.muted;
        mask = {
          bg = c.bg;
        };
        rest = fgOn c.muted;
        cand = fgOn c.accent;
        desc = fgOn c.subtle;
      };
      help = {
        on = fgOn c.info;
        run = fgOn c.special;
        desc = { };
        hovered = {
          reversed = true;
          bold = true;
        };
        footer = {
          fg = c.bg;
          bg = c.text;
        };
      };
      notify = {
        title_info = fgOn c.success;
        title_warn = fgOn c.warning;
        title_error = fgOn c.error;
      };
      filetype.rules = [
        {
          mime = "image/*";
          fg = c.warning;
        }
        {
          mime = "{audio,video}/*";
          fg = c.special;
        }
        {
          mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
          fg = c.error;
        }
        {
          mime = "application/{pdf,doc,rtf,vnd.*}";
          fg = c.border;
        }
        {
          url = "*";
          is = "orphan";
          fg = c.error;
        }
        {
          url = "*";
          is = "exec";
          fg = c.success;
        }
        {
          url = "*";
          fg = c.text;
        }
        {
          url = "*/";
          fg = c.accent;
        }
      ];
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

        extract = [
          {
            run = ''unzip "$@"'';
            desc = "Extract zip";
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
            url = "*.md";
            use = [ "edit" ];
          }
          {
            url = "*.toml";
            use = [ "edit" ];
          }
          {
            url = "*.nix";
            use = [ "edit" ];
          }
          {
            url = "*.lua";
            use = [ "edit" ];
          }
          {
            url = "*.go";
            use = [ "edit" ];
          }
          {
            url = "*.rs";
            use = [ "edit" ];
          }
          {
            url = "*.ts";
            use = [ "edit" ];
          }
          {
            url = "*.tsx";
            use = [ "edit" ];
          }
          {
            url = "*.js";
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
          {
            mime = "application/zip";
            use = [ "extract" ];
          }
        ];
      };
    };
  };
}
