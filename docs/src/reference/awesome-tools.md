# 🛠️ 开发工具推荐

一份精心整理的开发者必备软件、框架和工具集，帮助你在不同平台和环境下高效地构建、测试、调试和部署应用。

---

## Windows 专属

- [Scoop](https://scoop.sh/)：Windows 包管理器，命令行安装软件。
- [Bandizip](https://en.bandisoft.com/bandizip/)：强大的压缩/解压工具，免费版功能已很完善。
- [Visual Studio](https://visualstudio.microsoft.com/zh-hans/)：微软官方 IDE，功能全面。

## macOS 专属

- [Homebrew](https://brew.sh/)：macOS 包管理器（本项目通过 nix-homebrew 集成）。
- [Xcode](https://developer.apple.com/xcode/)：开发 Apple 平台应用的官方 IDE。
- [Kitty](https://sw.kovidgoyal.net/kitty/)：基于 GPU 的高性能终端模拟器。
- [Ghostty](https://ghostty.org/)：用 Zig 编写的现代化终端模拟器，启动速度快，渲染性能优秀。

## 编辑器

- [Neovim](https://neovim.io/)：Vim 的现代化分支，插件生态丰富。
- [VS Code](https://code.visualstudio.com/)：目前最流行的编辑器，插件生态极其丰富。建议安装 `code` 命令以便快速启动。
- [Cursor](https://cursor.com/en)：基于 VS Code 的 AI 编辑器，代码辅助能力强大。
- [Zed](https://zed.dev/)：高性能编辑器，但插件生态相对有限。
- [Sublime Text](https://www.sublimetext.com/)：轻量、快速、跨平台的代码编辑器，界面简洁。
- [Android Studio](https://developer.android.com/studio?hl=zh-cn)：Google 官方 Android 开发 IDE，内置模拟器和调试工具，适用于 Windows、macOS 和 Linux 上的完整 Android 开发工作流。
- [Xcode](https://developer.apple.com/xcode/)：Apple 官方 macOS/iOS 开发 IDE，仅 macOS 可用。集成代码编辑、UI 设计、模拟器、调试和发布工具，是 Apple 生态开发的必备工具。
- [Fleet](https://www.jetbrains.com/fleet/)：JetBrains 下一代 IDE，支持 AI 辅助和分布式协作开发。

## 浏览器

- [Chrome](https://www.google.com/chrome/)：Google 浏览器，开发者工具完善。
- [Arc Browser](https://arc.net/)：以标签页管理体验著称的浏览器。
- [Edge](https://www.microsoft.com/en-us/edge/mac)：微软浏览器，基于 Chromium。

## 开发工具

- [Git](https://git-scm.com/)：版本控制工具。macOS 自带，Windows 需自行安装：
  ```shell
  scoop install git
  ```
- [Vim](https://www.vim.org/)：文本编辑器。macOS 自带，Windows 需自行安装：
  ```shell
  scoop install vim
  ```
- [NVM](https://github.com/nvm-sh/nvm)：Node.js 版本管理器。
  ```shell
  # macOS 可通过 nix-homebrew 安装
  # Windows
  scoop bucket add main
  scoop install nvm
  ```
- [Node.js](https://nodejs.org/zh-cn)：JavaScript 运行时，配合 NVM 可安装多版本。安装后自动附带 [npm](https://www.npmjs.com/)。
- [Android Studio](https://developer.android.com/studio?hl=zh-cn)：构建 Android 平台应用。
- [SwitchHosts](https://switchhosts.vercel.app/zh)：Hosts 文件管理工具。
- [Synergy](https://symless.com/synergy)：一套键鼠控制多台电脑。
- [Docker](https://www.docker.com/)：容器化平台，简化应用构建和部署。
- [OrbStack](https://orbstack.dev/)：macOS 上 Docker Desktop 的轻量替代品，启动极快，资源占用低，同时支持容器和 Linux 虚拟机。
  ```shell
  # macOS 可通过 nix-homebrew 安装
  # Windows
  scoop install docker
  ```
- [tig](https://github.com/jonas/tig)：基于 ncurses 的 Git 文本界面，适合浏览仓库和分块提交。
  ```shell
  # macOS 可通过 nix-homebrew 安装
  # Windows
  scoop install tig
  ```
- [Charles](https://www.charlesproxy.com/)：HTTP/HTTPS 代理和抓包工具。
- [Wireshark](https://www.wireshark.org/)：网络协议深度分析工具。
- [Postman](https://www.postman.com/)：API 开发平台，用于测试、文档化和协作 REST/GraphQL 接口。
- [Fork](https://git-fork.com/)：简洁易用的 Git 图形客户端。

## AI 助手

- [ChatGPT](https://chatgpt.com/download/)：AI 对话助手，可用于编程求助、问题解决和创意任务。
- [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)：Anthropic 推出的终端 AI 编程助手，支持代码编辑、调试和自动化任务。
- [Codex](https://github.com/openai/codex)：OpenAI 官方 CLI 工具，基于 GPT-4o 的终端 AI 编程助手。
- [Lark CLI](https://www.npmjs.com/package/@larksuite/cli)：飞书（Lark）官方命令行工具，用于开发和管理飞书应用。
- [Kimi Code CLI](https://github.com/MoonshotAI/kimi-cli)：月之暗面（Moonshot AI）推出的终端 AI 编程助手，支持代码读写、Shell 命令执行、网页搜索和自主任务规划。
- [OpenClaw](https://github.com/claw-ai/openclaw)：AI 驱动的 CLI 工具，支持多种 AI 模型和自动化工作流。
