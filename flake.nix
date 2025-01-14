{
  description = "template for hydenix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hydenix = {
      # Available inputs:
      # Main: github:richen604/hydenix
      # Dev: github:richen604/hydenix/dev
      # Commit: github:richen604/hydenix/<commit-hash>
      # Version: github:richen604/hydenix/v1.0.0
      url = "github:richen604/hydenix";
    };
  };

  outputs =
    {
      hydenix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      hydenixConfig = hydenix.lib.mkConfig {
        userConfig = import ./config.nix;
        # inputs without nixpkgs to prevent override
        extraInputs = removeAttrs inputs [ "nixpkgs" ];
      };
    in
    {

      # NixOS build - sudo nixos-rebuild switch/test --flake .
      nixosConfigurations.${hydenixConfig.userConfig.host} = hydenixConfig.nixosConfiguration;

      packages.${system} = {
        # Packages below load your config in ./config.nix

        # defaults to nix-vm - nix run .
        default = hydenixConfig.nix-vm.config.system.build.vm;

        # EXPERIMENTAL VM BUILDERS - nix run .#arch-vm / nix run .#fedora-vm
        arch-vm = hydenixConfig.arch-vm;
        fedora-vm = hydenixConfig.fedora-vm;
      };
    };
}
