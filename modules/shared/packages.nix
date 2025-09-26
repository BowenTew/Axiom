{ pkgs }:


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
  PYTHON_PACKAGES = with pkgs; [
    python3
    virtualenv
  ];
  DEVELOPMENT_PACKAGES = with pkgs; [
    neovim
    git
    tig
    git-lfs
  ];
  TOOLS_PACKAGES = with pkgs; [
    tree
    home-manager
  ];
  FONTS_PACKAGES = with pkgs; [
    hack-font
    meslo-lgs-nf
    noto-fonts
    noto-fonts-emoji
  ];
  ALL_PACKAGE_GROUPS = [
    GO_DEVELOPMENT_PACKAGES
    RUST_DEVELOPMENT_PACKAGES
    # PYTHON_PACKAGES
    DEVELOPMENT_PACKAGES
    TOOLS_PACKAGES
    FONTS_PACKAGES
  ];
in

with pkgs; [
  # General packages for development and system management
  # alacritty
  # aspell
  # aspellDicts.en
  # bash-completion
  # bat
  # btop
  # coreutils
  # killall
  # neofetch
  # openssh
  # sqlite
  # wget
  # zip

  # # Cloud-related tools and SDKs
  # docker
  # docker-compose

  # # Text and terminal utilities
  # htop
  # hunspell
  # iftop
  # jetbrains-mono
  # jq
  # ripgrep
  # tree
  # tmux
  # unrar
  # unzip

  # Include development packages
] ++ lib.concatLists ALL_PACKAGE_GROUPS
