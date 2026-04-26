# NixOS 配置

> ⚠️ Linux (NixOS) 支持目前正在开发中，敬请期待后续更新。

## 计划中的功能

- 完整的 NixOS 系统配置
- Disko 磁盘分区自动化
- 多主机配置管理

## 相关输入

Axiom 的 `flake.nix` 已包含以下 NixOS 相关输入：

- `disko` — 声明式磁盘分区
- `home-manager` — 用户环境管理

## 当前状态

NixOS hosts 配置位于 `hosts/nixos.nix`，但尚未完善。
