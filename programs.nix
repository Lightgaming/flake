({ userConfig, pkgs, ... }: {
  environment.systemPackages = [ 
    pkgs.direnv
    pkgs.lxqt.lxqt-policykit 
    pkgs.typst
    pkgs.signal-desktop
    pkgs.nixpkgs-fmt
    pkgs.tinymist
    pkgs.rustscan
    pkgs.bottom
    pkgs.htop
  ];

  programs.zsh.shellAliases = {
    update = "sudo nixos-rebuild switch --flake ~/flake#nixos";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    times-newer-roman
  ];
})
