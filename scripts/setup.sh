#!/bin/sh
set -e

# 1. 安装 Nix
sh <(curl -L https://nixos.org/nix/install) --daemon
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# 2. 用 nix shell 临时运行 chezmoi 应用 dotfiles
nix shell nixpkgs#chezmoi -c chezmoi init --apply https://github.com/BowenTew/dotfiles
