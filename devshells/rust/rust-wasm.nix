{ pkgs, fenix }:

pkgs.mkShell {
  packages = with pkgs; [
    # 使用 fenix 管理的 Rust 工具链，包含 WebAssembly 目标
    (with fenix.packages.${pkgs.system};
      combine [
        stable.toolchain          # rustc/cargo
        targets.wasm32-unknown-unknown.stable.rust-std   # WebAssembly 标准库
      ])
    
    # WebAssembly 工具链
    wasm-pack
    binaryen
    wabt
    
    # 链接器
    lld
    llvmPackages.lld
    
    # 开发工具
    git
    zsh
    
    # 可选：Node.js 用于测试
    nodejs_20
  ];

  # 设置 WebAssembly 链接器
  CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER = "lld";

  shellHook = ''
    export EDITOR=vim
    
    # 设置 WebAssembly 相关环境变量
    export WASM_PACK_CACHE_DIR="$HOME/.wasm-pack"
    
    # 确保 lld 在 PATH 中
    export PATH="${pkgs.llvmPackages.lld}/bin:$PATH"
    
    # 设置 WebAssembly 链接器
    export CARGO_TARGET_WASM32_UNKNOWN_UNKNOWN_LINKER = "lld";
    
    echo "🦀 Rust + WebAssembly 开发环境已加载 (使用 Fenix)"
    echo "链接器: $(which lld)"
    echo ""
    echo "可用命令:"
    echo "  wasm-pack build --target web --out-dir pkg"
    echo "  wasm-pack build --target nodejs --out-dir pkg"
    echo "  wasm-pack build --target bundler --out-dir pkg"
    echo "  wasm-pack test --node"
    echo "  wasm-pack test --headless --firefox"
    echo "  wasm-pack test --headless --chrome"
    echo ""
    echo "Rust WebAssembly 开发环境准备就绪！"
  '';
}
