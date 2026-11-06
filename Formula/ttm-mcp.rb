class TtmMcp < Formula
  desc "ttm MCP server over stdio: workspace, Notee and Factory tools for Claude, Cursor, Codex and other MCP clients"
  homepage "https://toantranmei.com/help/ttm"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.2.0/ttm-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "910be06907cc76d0d5640ea6a9f8e98a1bbbd5135f780edee984397a79657946"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.2.0/ttm-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "0a1e3ec1ec39e402b6391ea82d482ed27eb324a591c0e9d55363948365087522"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.2.0/ttm-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "901f5e476ba68f78fda408cc936b4116bc85ec85c867648d132ae2de73e64653"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.2.0/ttm-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "92e337fb13c2c1494df92b7cdefce22e193df28abf360dfe97dde3c4745714f6"
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
