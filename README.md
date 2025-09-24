<div align="left">
<img src="./assets/nix-icon.svg" alt="Axiom" width="100" />
<div>
<a href="https://nixos.org"><img src="https://img.shields.io/badge/Nix-flakes-blue?logo=nixos" alt="Nix Flakes" /></a>

<a href="https://opensource.org/licenses/MIT">
<img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT" />
</a>
</div>
<!-- <div> -->
<!-- [![CI](https://github.com/YOUR_GH_NAME/YOUR_REPO/actions/workflows/build.yml/badge.svg)](https://github.com/YOUR_GH_NAME/YOUR_REPO/actions) -->
<!-- </div> -->
</div>

# Axiom
One flake to build them all: **macOS** (nix-darwin) + **NixOS** + **home-manager**. Clone and switch it, then go touching grass.

---

## 📖 TOC
- [✨ Features](#-features)
- [📁 Folder Map](#-folder-map)
- [🚀 Quick Start](#-quick-start)
  - [MacOS (nix-darwin)](#macos)
  - [Linux (NixOS)](#linux)
- [🧪 DevShells](#-devshells)
- [🤖 FAQ](#-faq)
- [🛠️ Development Tools](#-development-tools)
---

## ✨ Features
- **Zero bootstrap scripts** – pure `nix` commands only
- **Multi-host, multi-user** – keep all machines in one repo
- **Deterministic** – lock file pins every bit
- **Modular** – mix & match common modules (`desktop`, `dev`, `docker`, `gaming`…)
- **CI cached** – GitHub Actions builds your system closure nightly → cachix push

---

## 📁 Folder Map

```
.
├── apps
│   ├── aarch64-darwin
│   ├── aarch64-linux -> x86_64-linux
│   ├── x86_64-darwin
│   └── x86_64-linux
├── assets
│   ├── brew-casks.txt
│   ├── brew-formulae.txt
│   ├── Brewfile
│   ├── linux.svg
│   ├── macos.svg
│   └── nix-icon.svg
├── devshells
│   ├── deno
│   ├── devshell.nix
│   ├── go
│   ├── java
│   ├── node
│   └── rust
├── flake.lock
├── flake.nix
├── hosts
│   ├── darwin
│   └── nixos
├── modules
│   ├── darwin
│   ├── nixos
│   └── shared
├── overlays
│   ├── 10-feather-font.nix
│   └── README.md
└── README.md
```
## 🚀 Quick Start

Axiom is a declarative system configuration management tool built on Nix, supporting both macOS (nix-darwin) and Linux (NixOS). It enables rapid deployment of complete development environments through simple commands, encompassing system configuration, development tools, and desktop environments.

### <img src="./assets/macos.svg" alt="Axiom" width="24" />  MacOS (nix-darwin)

```zsh
# Clone the repo
git clone git@github.com:BeauvnTu/Axiom.git

# enter the repo
cd Axiom

# Apple  Chip
# apply the your info 
sh ./aarch64-darwin/apply 

# build the system
sh ./aarch64-darwin/build

# or build and switch
sh ./aarch64-darwin/build-switch
```

### <img src="./assets/linux.svg" alt="Axiom" width="24" />  Linux (NixOS)

```zsh
# Clone the repo
git clone git@github.com:BeauvnTu/Axiom.git

# enter the repo
cd Axiom

# apply the your info 
sh ./x86_64-linux/apply 

# build and switch
sh ./x86_64-linux/build-switch
```

## 🧪 DevShells

Provide reproducible, stack-specific dev environments without global installs. Enter with nix develop to get the exact toolchains and PATH you need (preferring project-local node_modules/.bin) for Node, Rust, Go, Java, Deno, and more.

The environment entered by runing nix develop xxx use bash as default shell-env.You can use `nix develop -c zsh xxx` to enter the zsh-env.

```zsh
# Default devShell: minimal dependencies (zsh, git), no language toolchains.
nix develop -c zsh

# Node devShell: Node.js (20/22) with Corepack (pnpm, Yarn) enabled; prefers project-local node_modules/.bin.
nix develop .#node22 -c zsh

# Rust devShell: Rust toolchain (rustup, cargo, clippy, rustfmt, rust-analyzer); reproducible, no global installs.
nix develop .#rust -c zsh

# Go devShell: Go toolchain (go, gopls, delve, go-tools, gotestsum); reproducible, no global installs.
nix develop .#go -c zsh

# Java devShell: JDK (8/11/17), Maven, Gradle; reproducible, no global installs.
nix develop .#java17 -c zsh 
```

You can also explicitly specify the system for different architectures: 

```zsh
nix develop .#frontend --system aarch64-darwin -c zsh
nix develop .#rust --system x86_64-linux' -c zsh
```

It’s recommended to place a .envrc (with direnv) or a devenv.yaml in the project subdirectory so the corresponding devShell is auto-activated when entering the directory.


## 🤖 FAQ

- **⚠️ After running build and switch, `~/.zshrc` and `~/.oh-my-zsh` package are still missing**  
  
  1. In your Home-Manager config, quote the plugin name exactly like this: programs.zsh.oh-my-zsh = "oh-my-zsh"; (double quotes around the string).
  2. Make sure ~/.zshrc.backup does not exist; with home-manager.backupFileExtension = "backup" Home-Manager will refuse to proceed if it sees that file.
  3. Home-Manager installs Oh-My-Zsh into the Nix store and only references it from ~/.zshrc, so you won't find an oh-my-zsh folder in your home directory.

## 🛠️ Development Tools
A curated collection of essential software, frameworks, and utilities that empower developers to build, test, debug, and deploy applications efficiently across diverse platforms and environments.

### Windows Only
* [Scoop](https://scoop.sh/): Windows Software Management.
* [bandzip](https://en.bandisoft.com/bandizip/): Bandizip is a powerful archiver that provides an ultrafast processing speed and convenient features.It is available for free, and the paid editions offers a variety of advanced features.
* [Visual Studio](https://visualstudio.microsoft.com/zh-hans/): Microsoft Powerful IDE.

### Mac Only
* [HomeBrew](https://brew.sh/):Mac Software Management.
* [Xcode](https://developer.apple.com/xcode/): build the App runing at Apple OS platform.
* [Kitty](https://sw.kovidgoyal.net/kitty/): The fast, feature-rich, GPU based terminal emulator.

### Editor
* [Neovim](https://neovim.io/): Vim with many useful plugin.
* [Vscode](https://code.visualstudio.com/): The most widely used editor with rich ecosystem plugin.Then install the `code` command to launch the editor fast.
* [Cursor](https://cursor.com/en): AI vscde with powerful code assistance.
* [Zed](https://zed.dev/): A high-performance editor, but with a limited plugin ecosystem.

### Broswer
* [Chrome](https://www.google.com/chrome/): Best Browser.
* [Arc Broswer](https://arc.net/): The Broswer with the best tab management experoence.
* [Edge](https://www.microsoft.com/en-us/edge/mac): Microsoft Browser.

### Develop
* [Git](https://git-scm.com/): software version management. git built-in on Mac, but windows should run the shell command to install by yourself.
  ``` shell
  # on windows
  scoop install git
  ```
* [Vim](https://www.vim.org/): text editor. vim built-in mac，but windows should run the shell command to install by yourself.
  ```shell
  # on windows
  scoop install vim
  ```
* [NVM](https://github.com/nvm-sh/nvm): Node Version Management
  ```shell
  # on Mac Use nix-homebrew

  # on Windows
  scoop bucket add main
  scoop install nvm
  ```
* [NodeJS](https://nodejs.org/zh-cn): Run JS Everywhere, use nvm install different version.At the same time, [npm](https://www.npmjs.com/) command is also install in your machine.
* [SwitchHost](https://switchhosts.vercel.app/zh): Host management.
* [Synergy](https://symless.com/synergy):use a single keyboard and mouse between multiple computers.
* [Android Studio](https://developer.android.com/studio?hl=zh-cn): build the App runing at Android platform.
* [Docker](https://www.docker.com/): Docker helps developers build, share, run, and verify applications anywhere — without tedious environment configuration or management.
  ```shell
  # on Mac Use nix-homebrew

  # on windows
  scoop install docker
  ```
* [tig command](https://github.com/jonas/tig)：Tig is an ncurses-based text-mode interface for git. It functions mainly as a Git repository browser, but can also assist in staging changes for commit at chunk level and act as a pager for output from various Git commands.
  ```shell
  # on Mac Use nix-homebrew

  # on windows
  scoop install tig
  ```
* [Charles](https://www.charlesproxy.com/): Charles is an HTTP proxy / HTTP monitor / Reverse Proxy that enables a developer to view all of the HTTP and SSL / HTTPS traffic between their machine and the Internet.
* [Wireshark](https://www.wireshark.org/): dive deep into network.
