{
  pkgs,
  pkgs-unstable,
  config,
  ...
}:

{
  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;
    settings = {
      theme = "kanagawa";
      plugin = [ "superpowers@git+https://github.com/obra/superpowers.git#v6.0.2" ];
      provider.amazon-bedrock = {
        options = {
          region = "us-east-1";
          endpoint = "{env:AI_GATEWAY_URL}/bedrock";
        };
      };
      mcp.fff = {
        type = "local";
        command = [ "fff-mcp" ];
        enabled = true;
      };
      instructions = [ "~/.config/opencode/fff.md" ];
    };
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  programs.zsh = {
    enable = true;
    initContent = ''
      [ -f "$HOME/.env.ai" ] && source "$HOME/.env.ai"
    '';
  };
}
