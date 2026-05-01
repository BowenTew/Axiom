# 安装 Nix

Bootstrap 基于 Nix 包管理器，首先需要安装 Nix。

## 官方安装脚本

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

安装完成后，**重启终端**或运行：

```sh
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

## 验证安装

```sh
nix --version
```

## 启用 Flakes

Bootstrap 使用 Flakes，需要确保已启用：

```sh
mkdir -p ~/.config/nix
cat > ~/.config/nix/nix.conf << 'CONF'
experimental-features = nix-command flakes
CONF
```

## 下一步

- [macOS 配置 →](macos.md)
- [NixOS 配置 →](nixos.md)
