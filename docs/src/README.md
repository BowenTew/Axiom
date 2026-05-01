# Bootstrap

One Flake to Rule Them All – for macOS (nix-darwin), NixOS, and home-manager.

克隆仓库，运行一条命令，看着你的系统按你的意愿配置好。不再有配置混乱，有更多时间做重要的事——比如看着终端自动配置时品一杯咖啡。

✨ git clone 你的理智之路  
⚡ nix run 你的荣耀之路

---

## 特性

- **零启动脚本** — 纯 `nix` 命令，无需额外脚本
- **多主机、多用户** — 所有机器配置集中在一个仓库
- **确定性** — lock 文件锁定每一个比特
- **模块化** — 自由组合 common 模块（`git`、`zsh`、`tmux`…）
- **项目模板** — `nix flake init -t` 脚手架，支持 Deno、Java、Rust+WASM
- **独立 Home Manager** — 不依赖 nix-darwin，通过 `home-manager switch --flake` 使用

## 支持平台

| 平台 | 架构 | 状态 |
|------|------|------|
| macOS (nix-darwin) | `aarch64-darwin`, `x86_64-darwin` | ✅ 可用 |
| NixOS | `x86_64-linux`, `aarch64-linux` | 🚧 开发中 |
| Standalone Home Manager | 所有平台 | ✅ 可用 |

## 快速链接

- [GitHub 仓库](https://github.com/BeauvnTu/Bootstrap)
- [快速开始 →](quickstart/install-nix.md)
- [常见问题](reference/faq.md)
