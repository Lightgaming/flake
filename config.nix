{
  username = "saint";
  gitUser = "Florian Lotz";
  gitEmail = "lightgaminglp@gmail.com";
  host = "nixos";
  /*
    Default password is required for sudo support in systems
    !REMEMBER TO USE passwd TO CHANGE THE PASSWORD!
  */
  defaultPassword = "Test123";
  timezone = "Europe/Vienna";
  locale = "de_AT.UTF-8";

  # hardware config - sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
  hardwareConfig = (toString ./hardware-configuration.nix);

  # List of drivers to install in ./hosts/nixos/drivers.nix
  drivers = [
    "amdgpu"
    "intel"
    # "nvidia"
    # "amdcpu"
    # "intel-old"
  ];

  /*
    These will be imported after the default modules and override/merge any conflicting options
    !Its very possible to break hydenix by overriding options
    eg:
      # lets say hydenix has a default of:
      {
        services.openssh.enable = true;
        environment.systemPackages = [ pkgs.vim ];
      }
      # your module
      {
        services.openssh.enable = false;  #? This wins by default (last definition)
        environment.systemPackages = [ pkgs.git ];  #? This gets merged with hydenix
      }
  */
  # List of nix modules to import in ./hosts/nixos/default.nix
  nixModules = [
    (toString ./programs.nix)
    # in my-module.nix you can reference this userConfig
    # ({ userConfig, pkgs, ... }: {
    #    environment.systemPackages = [ pkgs.direnv ];
    # })
  ];
  # List of nix modules to import in ./lib/mkConfig.nix
  homeModules = [
    (toString ./home.nix)
  ];

  hyde = rec {
    sddmTheme = "Candy"; # or "Corners"

    enable = true;

    # wallbash config, sets extensions as active
    wallbash = {
      vscode = true;
    };

    # active theme, must be in themes list
    activeTheme = "Catppuccin Mocha";

    # list of themes to choose from
    themes = [
      # -- Default themes
      "Catppuccin Mocha"
      "Catppuccin Latte"
      "Decay Green"
      "Edge Runner"
      "Frosted Glass"
      "Graphite Mono"
      "Gruvbox Retro"
      "Material Sakura"
      "Nordic Blue"
      "Rose Pine"
      "Synth Wave"
      "Tokyo Night"

      # -- Themes from hyde-gallery (use with caution)
      # "Abyssal-Wave"
      # "AbyssGreen"
      # "Bad Blood"
      # "Cat Latte"
      # "Dracula"
      # "Edge Runner"
      # "Green Lush"
      # "Greenify"
      # "Hack the Box"
      # "Ice Age"
      # "Mac OS"
      # "Monokai"
      # "One Dark"
      # "Oxo Carbon"
      # "Paranoid Sweet"
      # "Rain Dark"
      # "Red Stone"
      # "Rose Pine"
      # "Scarlet Night"
      # "Sci-fi"
      # "Solarized Dark"
      # "Windows 11"
      # "Monterey Frost"
      # TODO: fix pixel dream icon build
      # "Pixel Dream"
    ];

    # Exactly the same as hyde.conf
    conf = {
      hydeTheme = activeTheme;
      wallFramerate = 60;
      wallTransDuration = 0.4;
      wallAddCustomPath = "";
      enableWallDcol = 2;
      wallbashCustomCurve = "";
      skip_wallbash = [ ];
      themeSelect = 2;
      rofiStyle = 11;
      rofiScale = 9;
      wlogoutStyle = 1;
      userPrefsDir = "/home/saint/.configOverride";
    };
  };

  vm = {
    # 4 GB minimum
    memorySize = 4096;
    # 2 cores minimum
    cores = 2;
    # TODO: review, it also seems to matter which vm is run
    # 30GB minimum for one theme - 50GB for multiple themes - more for development and testing
    diskSize = 20000;
  };
}
