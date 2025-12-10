{ pkgs, ... }:

{
  users.users.jon = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  programs.gnupg.agent.enable = true;
}
