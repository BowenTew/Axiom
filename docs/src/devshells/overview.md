# Templates 概览

Axiom 提供了一系列 `nix flake init` 模板，用于快速初始化各语言的开发环境。

## 使用方式

```sh
# 使用模板初始化项目
nix flake init -t github:BeauvnTu/Axiom#<template-name>
```

## 可用模板

| 模板 | 说明 | 使用 |
|------|------|------|
| [Deno](deno.md) | Deno 运行时 | `nix flake init -t github:BeauvnTu/Axiom#deno` |
| [Java 8](java.md) | JDK 8 + Maven + Gradle | `nix flake init -t github:BeauvnTu/Axiom#java8` |
| [Java 11](java.md) | JDK 11 + Maven + Gradle | `nix flake init -t github:BeauvnTu/Axiom#java11` |
| [Java 17](java.md) | JDK 17 + Maven + Gradle | `nix flake init -t github:BeauvnTu/Axiom#java17` |
| [Rust + WASM](rust-wasm.md) | Rust + WebAssembly | `nix flake init -t github:BeauvnTu/Axiom#rust-wasm` |

## 通用特性

所有模板都支持以下平台：
- `aarch64-darwin` (Apple Silicon)
- `x86_64-darwin` (Intel Mac)
- `aarch64-linux`
- `x86_64-linux`

## 定义位置

模板在 `flake.nix` 中定义：

```nix
templates = {
  deno = {
    path = ./templates/deno;
    description = "Deno project";
  };
  # ...
};
```
