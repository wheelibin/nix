{ ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
      gui.nerdFontsVersion = "3";
      git.commit.autoWrapCommitMessage = false;
      gui.theme = {
        activeBorderColor = [
          "#7aa89f"
          "bold"
        ]; # wave aqua
        inactiveBorderColor = [ "#727169" ]; # wave sumiInk4
        optionsTextColor = [ "#7e9cd8" ]; # wave crystalBlue
        selectedLineBgColor = [ "#2d4f67" ]; # wave waveBlue1
        selectedRangeBgColor = [ "#2d4f67" ];
        cherryPickedCommitBgColor = [ "#181616" ]; # wave sumiInk0
        cherryPickedCommitFgColor = [ "#7aa89f" ];
        unstagedChangesColor = [ "#e82424" ]; # wave samuraiRed
        defaultFgColor = [ "#dcd7ba" ]; # wave fujiWhite
        searchingActiveBorderColor = [
          "#ff9e3b"
          "bold"
        ]; # wave roninYellow
      };
    };
  };
}
