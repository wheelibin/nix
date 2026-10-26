{ pkgs-unstable, ... }:

{
  home.packages = [ pkgs-unstable.omniwm ];

  launchd.agents.omniwm = {
    enable = true;
    config = {
      ProgramArguments = [ "${pkgs-unstable.omniwm}/bin/OmniWM" ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  # To manage settings declaratively:
  # 1. Launch OmniWM and configure via GUI
  # 2. Copy ~/.config/omniwm/settings.toml to modules/desktop/omniwm-settings.toml
  # 3. Uncomment:
  home.file.".config/omniwm/settings.toml".source = ./omniwm-settings.toml;
}
