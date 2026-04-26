# FAQ

## 一般问题

### Q: Axiom 支持哪些平台？

A: 目前 macOS (nix-darwin) 完全支持，NixOS 支持正在开发中。

| 平台 | 架构 | 状态 |
|------|------|------|
| macOS | `aarch64-darwin`, `x86_64-darwin` | ✅ 可用 |
| NixOS | `x86_64-linux`, `aarch64-linux` | 🚧 开发中 |

### Q: 如何更新系统配置？

A: 修改 `.nix` 文件后运行：

```sh
cd scripts
sh ./aarch64-darwin/build-switch
```

### Q: 如何回滚到之前的配置？

A:
```sh
cd scripts
sh ./aarch64-darwin/rollback
```

或者使用 nix-darwin 命令：
```sh
sudo darwin-rebuild switch --flake .#aarch64-darwin
```

### Q: 如何添加新的软件包？

A: 编辑 `modules/macos/packages.nix`，在对应的包组中添加包名，然后运行 `build-switch`。

## Nix 相关问题

### Q: Flakes 是什么？

A: Flakes 是 Nix 的实验性功能，提供：
- 可复现的依赖管理（通过 `flake.lock`）
- 标准化的 Nix 表达式接口
- 更好的缓存和共享

### Q: 如何更新 flake 输入？

A:
```sh
nix flake update
```

更新特定输入：
```sh
nix flake lock --update-input nixpkgs
```

### Q: build-switch 和 build 有什么区别？

A:
- `build` — 仅构建配置，生成 `result` 链接，不切换系统
- `build-switch` — 构建并立即切换到新配置

## 故障排查

### Q: Launchpad 显示已删除的应用？

A: 参见 [清理 Launchpad 残留图标](../sop/clean-launchpad.md)。

### Q: Neovim 配置修改后不生效？

A: 参见 [Neovim Lua 缓存问题](../sop/nvim-cache.md)。

### Q: 构建失败怎么办？

A:
1. 检查 `flake.nix` 语法：`nix flake check`
2. 查看详细错误：`sh ./aarch64-darwin/build-switch --show-trace`
3. 更新 flake 输入：`nix flake update`
4. 清理构建缓存：`nix-collect-garbage -d`
