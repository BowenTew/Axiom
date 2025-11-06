{ pkgs }:

let
  # 语言开发环境
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
    nodejs_22 # default version is 22
    pnpm
  ];

  PYTHON_PACKAGES = with pkgs; [
    python3
    virtualenv
  ];

  # 基础开发工具
  DEVELOPMENT_PACKAGES = with pkgs; [
    git
    git-lfs
    tig
    neovim
    ripgrep
    wget
  ];

  # 终端和界面工具
  TERMINAL_PACKAGES = with pkgs; [
    tmux
    kitty
  ];

  # 系统工具
  SYSTEM_PACKAGES = with pkgs; [
    bat
    tree
    coreutils
    zip
    unzip
  ];

  # 字体包
  FONTS_PACKAGES = with pkgs; [
    hack-font
    meslo-lgs-nf
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.roboto-mono  
    powerline               
  ];

  # 容器工具
  DOCKER_PACKAGES = with pkgs; [
    docker
    docker-compose
  ];

  # 所有包组
  HOME_MANAGER_PACKAGE_GROUPS = [
    GO_DEVELOPMENT_PACKAGES
    RUST_DEVELOPMENT_PACKAGES
    JAVASCRIPT_DEVELOPMENT_PACKAGES
    DEVELOPMENT_PACKAGES
    TERMINAL_PACKAGES
    SYSTEM_PACKAGES
    FONTS_PACKAGES
    # PYTHON_PACKAGES
    # DOCKER_PACKAGES
  ];
in

{
  systemPackages =  with pkgs; [
    home-manager
  ];

  homeManagerPackages = pkgs.lib.concatLists HOME_MANAGER_PACKAGE_GROUPS;
}
