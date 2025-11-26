{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;

    # Use zsh integration
    enableZshIntegration = true;

    flags = [
      # no up arrow binding
      "--disable-up-arrow"
    ];

    # disable sync entirely
    settings = {
      sync = {
        enabled = false;
      };

      # Make search feel like "super ctrl-r"
      filter_mode = "host";          # or "global" / "session" / "directory"
      search_mode = "fuzzy";         # or "prefix" / "exact"
      keymap = "vim";                # or "emacs"
      # You can tweak these later with `atuin config set ...`
    };
  };

}
