class TtmMcp < Formula
  desc "ttm MCP server over stdio: workspace, Notee and Factory tools for Claude, Cursor, Codex and other MCP clients"
  homepage "https://toantranmei.com/help/ttm"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.2/ttm-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "93fd6db1404c9e3b393636e1ae96e3a43b0467fa5dd9795c8bc592ae2d181ffd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.2/ttm-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "ff2918ad25c372e79492dba2bf2ee6b5fdac116c8d07d84c9da62bcf49dc6959"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.2/ttm-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f1b7bcf76cc4684104a4f2817b57302ce4c95c4534e6ae5798ba1dabdd21bde4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.2/ttm-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "138bd0d751c3c326af83e02f652e5fea1c746de9f0586c639cc65d6f5fd2f1d4"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ttm-mcp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ttm-mcp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ttm-mcp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ttm-mcp"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
