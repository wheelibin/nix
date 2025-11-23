{ ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
      gui.nerdFontsVersion = "3";
      git.commit.autoWrapCommitMessage = false;
    };
  };
}
