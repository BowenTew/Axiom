# 修复 rust-analyzer 不报错

## 问题表现

在 Neovim 中编辑 Rust 文件时，即使代码有明显语法错误，rust-analyzer 也不显示任何诊断信息。

## 根本原因

rust-analyzer 无法加载 workspace，整个 LSP 分析功能静默失效。具体有两个问题：

### 1. Cargo 版本冲突

系统中存在多个 cargo，rust-analyzer 调用了旧版：

| 来源 | 路径 | 版本 |
|------|------|------|
| rustup（旧） | `~/.cargo/bin/cargo` | 1.84.0 ❌ |
| Nix（散装） | `~/.nix-profile/bin/cargo` | 1.89.0 ✅ |

项目 `Cargo.toml` 指定 `edition = "2024"`（需要 Cargo ≥ 1.85），旧版 cargo 直接报错。

### 2. 缺少 rust-src

Nix 单独安装的 `pkgs.rustc` 不包含标准库源码，rust-analyzer 在 sysroot 下找不到 `lib/rustlib/src/rust/library/`。

## 排查思路

### 查看 LSP 日志

```bash
cat ~/.local/state/nvim/lsp.log | grep -i "rust.*error" | tail -20
```

关键错误信息：

```
ERROR FetchWorkspaceError: rust-analyzer failed to load workspace
ERROR can't load standard library, try installing `rust-src`
```

### 检查工具链

```bash
which -a cargo          # 是否有多个 cargo
cargo --version         # 当前版本是否够新

SYSROOT=$(rustc --print sysroot)
ls "$SYSROOT/lib/rustlib/src/rust/library/"   # rust-src 是否存在
```

## 解决方案

用 fenix 替换散装 Rust 包，提供包含 rust-src 的完整工具链。

### 修改 `modules/macos/packages.nix`

**Before：**

```nix
{ config, pkgs, ... }:

let
  RUST_DEVELOPMENT_PACKAGES = with pkgs; [
    rustc
    cargo
    clippy
    rust-analyzer
    rustfmt
  ];
```

**After：**

```nix
{ config, pkgs, inputs, ... }:

let
  fenixPkgs = inputs.fenix.packages.${pkgs.system};
  rust-toolchain = (fenixPkgs.toolchainOf {
    channel = "stable";
    date = "2025-09-18";
    sha256 = "sha256-SJwZ8g0zF2WrKDVmHrVG3pD2RGoQeo24MEXnNx5FyuI=";
    root = "https://mirrors.ustc.edu.cn/rust-static/dist";
  }).withComponents [
    "cargo"
    "clippy"
    "rustc"
    "rustfmt"
    "rust-src"
    "rust-analyzer"
  ];

  RUST_DEVELOPMENT_PACKAGES = [
    rust-toolchain
  ];
```

### 添加 fenix cachix 缓存

**`hosts/darwin.nix`：**

```nix
substituters = [
  "https://nix-community.cachix.org"
  "https://cache.nixos.org"
  "https://fenix.cachix.org"
];
trusted-public-keys = [
  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  "fenix.cachix.org-1:PpL1UNHViEFrcJzCDV+yl+S+c90I5hTqGq0G+1RP0wM="
];
```

**`~/.config/nix/nix.conf`**（用户级，立即生效）：

```
substituters = https://cache.nixos.org https://nix-community.cachix.org https://fenix.cachix.org
trusted-public-keys = cache.nixos.org-1:... nix-community.cachix.org-1:... fenix.cachix.org-1:PpL1UNHViEFrcJzCDV+yl+S+c90I5hTqGq0G+1RP0wM=
```

### Apply

```bash
cd ~/github/self/bootstrap && sh scripts/aarch64-darwin/build-switch
```

### 验证

```bash
rustc --version && cargo --version && rust-analyzer --version

SYSROOT=$(rustc --print sysroot)
ls "$SYSROOT/lib/rustlib/src/rust/library/"
# 应看到 alloc, core, std 等目录
```

### 清理旧的 rustup

```bash
rustup self uninstall   # 如果 command not found 则无需操作
```

## 构建踩坑

### 下载卡住

fenix 首次构建需从 `static.rust-lang.org` 下载工具链 tarball，国内可能很慢。

**手动从 USTC 镜像下载后替换：**

```bash
# 从镜像下载
curl -L -o /tmp/rustc.tar.gz \
  "https://mirrors.ustc.edu.cn/rust-static/dist/<date>/rustc-<ver>-aarch64-apple-darwin.tar.gz"
curl -L -o /tmp/rust-std.tar.gz \
  "https://mirrors.ustc.edu.cn/rust-static/dist/<date>/rust-std-<ver>-aarch64-apple-darwin.tar.gz"

# 停 daemon，替换，重启
sudo launchctl bootout system/org.nixos.nix-daemon
sudo pkill -9 -u _nixbld1 2>/dev/null
sudo pkill -9 -u _nixbld10 2>/dev/null
sudo cp /tmp/rustc.tar.gz /nix/store/<hash>-rustc-<ver>-aarch64-apple-darwin.tar.gz
sudo cp /tmp/rust-std.tar.gz /nix/store/<hash>-rust-std-<ver>-aarch64-apple-darwin.tar.gz
sudo rm -f /nix/store/<hash>*.lock
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sleep 3 && nix store ping
```

> store 路径中的 `<hash>` 从 build 日志的 `waiting for lock on` 行中获取。

### daemon 残留进程

之前中断的 build 可能在 daemon 中残留，重启后自动恢复并占用 worker。

```bash
sudo launchctl bootout system/org.nixos.nix-daemon
sudo pkill -9 -u _nixbld1 2>/dev/null
sudo pkill -9 -u _nixbld10 2>/dev/null
sudo rm -f /nix/store/<hash>*.lock
sudo rm -f /nix/store/<hash>-rustc-*.tar.gz
sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.nix-daemon.plist
```

### Connection refused

daemon 还没启动完就执行了 nix 命令，等几秒再试：

```bash
sleep 3 && nix store ping
```

## 更新工具链版本

```nix
rust-toolchain = (fenixPkgs.toolchainOf {
  channel = "stable";
  date = "<新日期>";
  sha256 = lib.fakeSha256;  # 先用假 hash
  root = "https://mirrors.ustc.edu.cn/rust-static/dist";
}).withComponents [ ... ];
```

构建报错会给出正确的 sha256，替换后再次构建即可。
