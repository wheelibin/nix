{ ... }:

let
  c = (import ../theme.nix).roles;
in
{
  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
      gui.nerdFontsVersion = "3";
      git.commit.autoWrapCommitMessage = false;
      gui.theme = {
        activeBorderColor = [
          c.border
          "bold"
        ];
        inactiveBorderColor = [ c.muted ];
        optionsTextColor = [ c.accent ];
        selectedLineBgColor = [ c.selection ];
        selectedRangeBgColor = [ c.selection ];
        cherryPickedCommitBgColor = [ c.surface ];
        cherryPickedCommitFgColor = [ c.border ];
        unstagedChangesColor = [ c.error ];
        defaultFgColor = [ c.text ];
        searchingActiveBorderColor = [
          c.warning
          "bold"
        ];
      };
    };
  };
}
