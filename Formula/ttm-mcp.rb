class TtmMcp < Formula
  desc "ttm MCP server over stdio: workspace, Notee and Factory tools for Claude, Cursor, Codex and other MCP clients"
  homepage "https://toantranmei.com/help/ttm"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.5/ttm-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "3a163dba61e7f8a48630fcab17acb09d0d535942d957a66464fdc38182f39eb2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.5/ttm-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "7388ffbe7e3847e481e88ce82f46ad2b3063adb7cb5302bce833d4a2e2e6b607"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.5/ttm-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "37e1666eb5dbca72a94a171b019043cd9cc042e365f1b765a2ee8580157a3bf4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.5/ttm-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6075981df5c245a108c1049264bf0fdfffe4ef6e178ebd951a6ac1c6dbb09fe7"
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
