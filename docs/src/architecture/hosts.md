# Hosts

Hosts 目录定义了不同机器的系统配置。

## darwin.nix

macOS 主机配置入口，导入 `darwin` 输入并定义系统配置。

主要配置：
- **用户配置** — 创建系统用户，设置 shell 为 zsh
- **Nix 配置** — substituters、trusted keys、自动 GC
- **系统设置** — 状态版本、NSGlobalDomain 默认行为
- **系统字体** — Hack、Meslo Nerd Font、Noto、Roboto Mono Nerd Font 等

支持 `aarch64-darwin` 和 `x86_64-darwin` 两个架构。

## nixos.nix

NixOS 主机配置模板（开发中），目前仅包含注释掉的示例配置。

## home.nix

独立的 Home Manager 配置入口，不依赖 nix-darwin。

用于：
- 在非 NixOS Linux 上使用 Home Manager
- 在 macOS 上仅管理用户环境而不管理系统

```nix
{ axiomIdentity, pkgs, inputs, ... }:
{
  imports = [ ./modules/common ];
  home = {
    username = axiomIdentity.user;
    homeDirectory = if pkgs.stdenv.isDarwin then
      "/Users/${axiomIdentity.user}"
    else
      "/home/${axiomIdentity.user}";
  };
  programs.home-manager.enable = true;
}
```

## 多主机管理

设计目标是支持多主机、多用户。所有机器配置集中在一个仓库，通过不同的 host 文件区分。
