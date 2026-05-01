<div align="left">
<img src="./assets/nix-icon.svg" alt="Bootstrap" width="100" />
<div>
<a href="https://nixos.org"><img src="https://img.shields.io/badge/Nix-flakes-blue?logo=nixos" alt="Nix Flakes" /></a>

<a href="https://opensource.org/licenses/MIT">
<img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT" />
</a>
<a href="https://beauvntu.github.io/Bootstrap">
<img src="https://img.shields.io/badge/Docs-mdBook-orange.svg" alt="Docs" />
</a>
</div>
<!-- <div> -->
<!-- [![CI](https://github.com/YOUR_GH_NAME/YOUR_REPO/actions/workflows/build.yml/badge.svg)](https://github.com/YOUR_GH_NAME/YOUR_REPO/actions) -->
<!-- </div> -->
</div>

# Bootstrap
One Flake to Rule Them All – for macOS (nix-darwin), NixOS, and home-manager.

Clone this repo, run a command, and watch your system configure itself. No more configuration chaos. More time for important things — like sipping coffee while your OS sets itself up.

✨ git clone your way to sanity  
⚡ nix run your way to glory

⚠️ Warning: Side effects may include unexpected happiness, extra free time, and the strange urge to show off your terminal to friends.

---

## 📖 TOC
- [📚 Docs](https://beauvntu.github.io/Bootstrap)
- [✨ Features](#-features)
- [📁 Folder Map](#-folder-map)
- [🚀 Quick Start](#-quick-start)
  - [Linux (NixOS)](#nixos)
  - [MacOS (nix-darwin)](#nix-darwin)
- [🧪 DevShells](#-devshells)
- [🤖 FAQ](#-faq)

## ✨ Features
- **Zero bootstrap scripts** – pure `nix` commands only
- **Multi-host, multi-user** – keep all machines in one repo
- **Deterministic** – lock file pins every bit
- **Modular** – mix & match common modules (`git`, `zsh`, `tmux`…)
- **Project templates** – `nix flake init -t` scaffolding for Deno, Java, Rust+WASM
- **Standalone Home Manager** – use without nix-darwin via `home-manager switch --flake .#<user>`

---

## 📁 Folder Map

```
.
├── assets/                  # Static assets (icons, images)
│   ├── linux.svg
│   ├── macos.svg
│   └── nix-icon.svg
├── docs/                    # mdBook documentation site
│   ├── book.toml
│   ├── book/                # Build output (GitHub Pages)
│   └── src/                 # Markdown source files
├── hosts/                   # Host configurations
│   ├── darwin.nix           # macOS system config entry
│   └── nixos.nix            # NixOS config template (WIP)
├── inventory/               # Identity data
│   └── default.nix
├── modules/                 # Modular configurations
│   ├── common/              # Cross-platform modules (Home Manager)
│   │   ├── default.nix
│   │   ├── git.nix
│   │   ├── packages.nix
│   │   ├── tmux.nix
│   │   └── zsh.nix
│   └── macos/               # macOS-specific modules
│       ├── default.nix
│       ├── home-manager.nix
│       ├── homebrew.nix
│       └── packages.nix
├── overlays/                # Nixpkgs overlay
│   └── README.md
├── scripts/                 # Build / deploy scripts
│   ├── aarch64-darwin/
│   ├── x86_64-darwin/
│   ├── x86_64-linux/
│   ├── apply.sh
│   └── setup.sh
├── templates/               # nix flake init project templates
│   ├── default.nix
│   ├── deno/
│   ├── java/
│   └── rust-wasm/
├── flake.lock               # Flake dependency lock
├── flake.nix                # Flake entrypoint
├── home.nix                 # Standalone Home Manager entrypoint
└── README.md
```

## 🚀 Quick Start

First, install Nix:

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Then enable Flakes:

```sh
mkdir -p ~/.config/nix
cat > ~/.config/nix/nix.conf << 'CONF'
experimental-features = nix-command flakes
CONF
```

### NixOS

> ⚠️ Linux (NixOS) support is currently under development. Stay tuned for future updates.

### nix-darwin

macOS setup guide:

```zsh
# Clone the repo
git clone git@github.com:BeauvnTu/Bootstrap.git

# Enter the folder
cd Bootstrap/scripts

# Apple Silicon
sh ./aarch64-darwin/build-switch

# Intel Mac
sh ./x86_64-darwin/build-switch
```

### Standalone Home Manager

You can also use Home Manager without nix-darwin:

```zsh
# Install home-manager first, then:
home-manager switch --flake .#moonshot
```

> Replace `moonshot` with your username defined in `inventory/default.nix`.

## 🧪 DevShells

This repo provides a docs development shell with mdbook:

```zsh
# Enter the docs devShell
nix develop -c zsh

# Serve docs locally
mdbook serve docs

# Build docs
mdbook build docs
```

For language-specific dev environments, use the project templates:

```zsh
# Scaffold a new Rust + WASM project
mkdir my-project && cd my-project
nix flake init -t github:BeauvnTu/Bootstrap#rust-wasm
nix develop

# Or Java
nix flake init -t github:BeauvnTu/Bootstrap#java
nix develop

# Or Deno
nix flake init -t github:BeauvnTu/Bootstrap#deno
nix develop
```

## 🤖 FAQ

- **⚠️ After running build and switch, `~/.zshrc` and `~/.oh-my-zsh` package are still missing**

  1. Make sure `~/.zshrc.backup` does not exist; with `home-manager.backupFileExtension = "backup"` Home Manager will refuse to proceed if it sees that file.
  2. Home Manager installs Oh-My-Zsh into the Nix store and only references it from `~/.zshrc`, so you won't find an `oh-my-zsh` folder in your home directory.

- **⚠️ `attribute 'inputs' missing` error**

  This happens when `modules/common/` requires `inputs` (for `fenix` Rust toolchain) but it's not passed through. Ensure `flake.nix`, `home.nix`, and `modules/macos/home-manager.nix` all pass `inputs` in their `extraSpecialArgs` / module arguments.
