{ userConfig, ... }:
{
  home.file = {
    # hyprland
    ".config/hypr/hyprland.conf" = {
        source = ./hyprland.conf;
        force = true;
        mutable = true;
    };
    # code
    ".config/Code/User/settings.json" = {
        source = ./code-settings.json;
        force = true;
        mutable = true;
    };
    # Waybar
    ".config/waybar/config.ctl" = {
        source = ./waybar-config.ctl;
        force = true;
        mutable = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1";
  };

  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

}