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

  # # Encryption and security tools
  # age
  # age-plugin-yubikey
  # gnupg
  # libfido2

  # # Cloud-related tools and SDKs
  # docker
  # docker-compose

  # # Media-related packages
  # dejavu_fonts
  # ffmpeg
  # fd
  # font-awesome
  # hack-font
  # noto-fonts
  # noto-fonts-emoji
  # meslo-lgs-nf

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

  # # Python packages
  # python3
  # virtualenv

  # Include development packages
] ++ GO_DEVELOPMENT_PACKAGES ++ DEVELOPMENT_PACKAGES ++ TOOLS_PACKAGES
