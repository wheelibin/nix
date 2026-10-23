{ ... }:

let
  c = (import ../theme.nix).roles;
in
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # bg/fg left to the terminal so transparency still works
    colors = {
      "bg+" = c.selection;
      "fg+" = c.text;
      hl = c.accent;
      "hl+" = c.accent;
      info = c.muted;
      prompt = c.accent;
      pointer = c.special;
      marker = c.success;
      spinner = c.special;
      header = c.muted;
      border = c.muted;
    };
  };
}
