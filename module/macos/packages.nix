{ config, pkgs, user, ... }:

let
  GO_DEVELOPMENT_PACKAGES = with pkgs; [
    go
    gopls
    delve
    go-tools
    gotestsum
  ];

  RUST_DEVELOPMENT_PACKAGES = with pkgs; [
    rustc
    cargo
    clippy
    rust-analyzer
    rustfmt
  ];

  JAVASCRIPT_DEVELOPMENT_PACKAGES = with pkgs; [
    nodejs_22
    pnpm
  ];

  PYTHON_PACKAGES = with pkgs; [
    uv
    python3
  ];

  DEVELOPMENT_PACKAGES = with pkgs; [
    git
    git-lfs
    tig
    ripgrep
    wget
    fd
    fzf
  ];

  TERMINAL_PACKAGES = with pkgs; [
    tmux
    kitty
  ];

  SYSTEM_PACKAGES = with pkgs; [
    bat
    tree
    coreutils
    zip
    unzip
  ];

  FONTS_PACKAGES = with pkgs; [
    hack-font
    meslo-lgs-nf
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.roboto-mono
    powerline
  ];

  HOME_MANAGER_PACKAGE_GROUPS = [
    GO_DEVELOPMENT_PACKAGES
    RUST_DEVELOPMENT_PACKAGES
    JAVASCRIPT_DEVELOPMENT_PACKAGES
    DEVELOPMENT_PACKAGES
    TERMINAL_PACKAGES
    SYSTEM_PACKAGES
    FONTS_PACKAGES
    PYTHON_PACKAGES
  ];
in
{
  config.home-manager.users.${user} = {
    home.packages = pkgs.lib.concatLists HOME_MANAGER_PACKAGE_GROUPS;
  };
  
  config.environment.systemPackages = with pkgs; [
    zsh
  ];
  
}