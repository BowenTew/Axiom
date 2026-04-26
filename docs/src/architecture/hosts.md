# Hosts

Hosts 目录定义了不同机器的系统配置。

## darwin.nix

macOS 主机配置入口，导入 `darwin` 输入并定义系统配置。

## nixos.nix

NixOS 主机配置入口（开发中）。

## 多主机管理

Axiom 的设计目标是支持多主机、多用户。所有机器配置集中在一个仓库，通过不同的 host 文件区分。
