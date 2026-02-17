{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    karabiner-elements
  ];

  home.file.".config/karabiner/karabiner.json".text = builtins.toJSON {
    global = {
      show_in_menu_bar = true;
    };

    profiles = [
      {
        devices = [
          {
            identifiers = {
              is_keyboard = true;
              product_id = 11810;
              vendor_id = 7805;
            };
            ignore = true;
          }
        ];

        name = "Default profile";
        selected = true;

        virtual_hid_keyboard = {
          country_code = 0;
          keyboard_type_v2 = "iso";
        };
      }
    ];
  };

  # Auto-start Karabiner-Elements at login
  launchd.agents.karabiner-elements = {
    enable = true;
    config = {
      ProgramArguments = [
        "/usr/bin/open"
        "-a"
        "${config.home.homeDirectory}/Applications/Home Manager Apps/Karabiner-Elements.app"
      ];
      RunAtLoad = true;
      KeepAlive = false; # usually better for GUI apps
    };
  };
}
