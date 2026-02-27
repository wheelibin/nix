{ pkgs, ... }:

{
  imports = [
    ./lazygit.nix
  ];

  home.packages = with pkgs; [
    delta
    git-lfs
    gh
    git-filter-repo
  ];

  programs.git = {
    enable = true;
    settings = {
      # --- Core ---
      core.pager = "delta"; # use delta for all paged output
      core.fsmonitor = true; # speed up status/diff in large repos (requires watchman)

      # --- Local config ---
      include.path = "~/.config/git/local.config"; # machine-specific overrides

      # --- UI/UX ---
      help.autocorrect = "prompt"; # ask before running typo-corrected commands
      commit.verbose = true; # show diff in commit message editor

      # --- Sorting ---
      branch.sort = "-committerdate"; # show recently used branches first
      tag.sort = "version:refname"; # sort tags semantically (v1.9 < v1.10)

      # --- Pull/Rebase ---
      pull.rebase = true; # rebase instead of merge on pull
      rebase = {
        autoStash = true; # stash dirty worktree before rebase, pop after
        autoSquash = true; # auto-reorder fixup!/squash! commits
        updateRefs = true; # update stacked branch refs during rebase
      };

      # --- Merge ---
      merge = {
        keepBackup = false; # don't create .orig backup files
        tool = "nvimdiff"; # nvim built-in 3-way merge
        conflictStyle = "zdiff3"; # show base version in conflicts
      };
      rerere.enabled = true; # remember conflict resolutions for reuse

      # --- Diff ---
      diff.tool = "nvimdiff2"; # default diff tool
      interactive.diffFilter = "delta --color-only"; # colorize interactive diffs

      # --- Delta (pager/diff viewer) ---
      delta = {
        syntax-theme = "ansi";
        navigate = true; # use n/N to jump between diff sections
        # side-by-side = true; # two-column diff view
        line-numbers = true; # show line numbers in diffs
        hyperlinks = true; # clickable links to repo
      };

      # --- Merge tool config ---
      mergetool = {
        prompt = false; # don't ask to confirm each file
        keepBackup = false; # don't create .orig files
      };

      # --- Diff tool config ---
      difftool = {
        prompt = false; # don't ask to confirm each file
        nvimdiff2.cmd = ''nvim -d "$LOCAL" "$REMOTE"'';
      };

      # --- Performance ---
      gc.writeCommitGraph = true; # speed up graph operations
      commitGraph.generationVersion = 2; # use newer commit-graph format

      # --- Git LFS ---
      filter.lfs = {
        clean = "git-lfs clean -- %f"; # convert to pointer on add
        smudge = "git-lfs smudge -- %f"; # fetch content on checkout
        process = "git-lfs filter-process"; # batch filter for speed
        required = true; # fail if lfs not installed
      };

      # --- Aliases ---
      alias = {
        co = "checkout";
        st = "status";
        lg = "!git log --oneline --graph";
        rbm = "!git fetch origin && git rebase origin/HEAD --ignore-date"; # rebase on remote main
        leaderboard = "shortlog -s -n"; # commit count per author
        apply-gitignore = "!git ls-files -ci --exclude-standard -z | xargs -0r git rm --cached"; # remove ignored files from index
      };
    };
  };

}
