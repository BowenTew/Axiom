# Rust + WebAssembly

Rust WebAssembly 开发环境模板。

## 使用

```sh
nix flake init -t github:BeauvnTu/Axiom#rust-wasm
```

## 包含

| 包 | 说明 |
|----|------|
| `stable.toolchain` | Rust 稳定版工具链 |
| `wasm32-unknown-unknown` | WASM 目标 |
| `wasm-pack` | WASM 打包工具 |
| `binaryen` | WASM 优化工具 |
| `wabt` | WASM 二进制工具 |
| `lld` | LLVM 链接器 |
| `git` | 版本控制 |
| `nodejs_20` | Node.js |
| `rust-analyzer` | Rust LSP |

## 环境变量

| 变量 | 值 |
|------|-----|
| `EDITOR` | `vim` |
| `WASM_PACK_CACHE_DIR` | `$HOME/.wasm-pack` |
| `CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER` | `lld` |
