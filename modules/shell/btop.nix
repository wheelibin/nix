{ ... }:

let
  c = (import ../theme.nix).roles;
  # start/mid/end gradient from three roles
  grad = name: s: m: e: ''
    theme[${name}_start]="${s}"
    theme[${name}_mid]="${m}"
    theme[${name}_end]="${e}"
  '';
in
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "shared";
      theme_background = false;
    };
    themes.shared = ''
      theme[main_bg]="${c.bg}"
      theme[main_fg]="${c.text}"
      theme[title]="${c.text}"
      theme[hi_fg]="${c.accent}"
      theme[selected_bg]="${c.selection}"
      theme[selected_fg]="${c.text}"
      theme[inactive_fg]="${c.muted}"
      theme[graph_text]="${c.subtle}"
      theme[meter_bg]="${c.surface}"
      theme[proc_misc]="${c.special}"
      theme[cpu_box]="${c.muted}"
      theme[mem_box]="${c.muted}"
      theme[net_box]="${c.muted}"
      theme[proc_box]="${c.muted}"
      theme[div_line]="${c.muted}"
      ${grad "temp" c.success c.warning c.error}
      ${grad "cpu" c.success c.warning c.error}
      ${grad "free" c.success c.success c.success}
      ${grad "cached" c.info c.info c.info}
      ${grad "available" c.warning c.warning c.warning}
      ${grad "used" c.error c.error c.error}
      ${grad "download" c.info c.accent c.special}
      ${grad "upload" c.special c.accent c.info}
      ${grad "process" c.success c.warning c.error}
    '';
  };
}
