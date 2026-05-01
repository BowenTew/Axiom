# 常用命令

## Nix 基础

| 命令 | 说明 |
|------|------|
| `nix --version` | 查看 Nix 版本 |
| `nix flake check` | 检查 flake 配置 |
| `nix flake update` | 更新所有 flake 输入 |
| `nix flake lock --update-input <name>` | 更新特定输入 |
| `nix-collect-garbage -d` | 删除旧 generations 并清理 |
| `nix-store --gc --print-roots` | 查看 gc roots |
| `nix-shell -p <pkg>` | 临时进入含某包的 shell |

## Bootstrap 构建

| 命令 | 说明 |
|------|------|
| `sh ./aarch64-darwin/build` | 仅构建 |
| `sh ./aarch64-darwin/build-switch` | 构建并切换 |
| `sh ./aarch64-darwin/rollback` | 回滚配置 |
| `sh ./aarch64-darwin/apply` | 交互式应用配置 |

## nix-darwin

| 命令 | 说明 |
|------|------|
| `darwin-rebuild switch --flake .#<host>` | 切换配置 |
| `darwin-rebuild build --flake .#<host>` | 仅构建 |
| `darwin-rebuild changelog --flake .#<host>` | 查看更新日志 |

## Home Manager

| 命令 | 说明 |
|------|------|
| `home-manager switch --flake .#<user>` | 切换用户配置 |
| `home-manager generations` | 查看 generations |
| `home-manager news` | 查看更新信息 |

## 模板使用

| 命令 | 说明 |
|------|------|
| `nix flake init -t github:BeauvnTu/Bootstrap#<template>` | 初始化项目 |
| `nix flake init -t github:BeauvnTu/Bootstrap#deno` | Deno 项目 |
| `nix flake init -t github:BeauvnTu/Bootstrap#rust-wasm` | Rust + WASM 项目 |

## 文档开发

| 命令 | 说明 |
|------|------|
| `nix develop -c zsh` | 进入 docs devShell |
| `mdbook serve docs` | 本地预览文档 |
| `mdbook build docs` | 构建文档 |
