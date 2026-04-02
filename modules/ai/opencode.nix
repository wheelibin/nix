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
      plugin = [ "superpowers@git+https://github.com/obra/superpowers.git#v5.0.7" ];
      provider.amazon-bedrock = {
        options = {
          region = "us-east-1";
          profile = "bedrock";
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

}
