class Ttm < Formula
  desc "ttm: command line for toantranmei.com (sign in, workspaces, Notee, Factory sync and local agent runner)"
  homepage "https://toantranmei.com/help/ttm"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.2.0/ttm-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d9c7c90a5b84fa5020f844f44eeddf68a6d793fa9bbdf53df5fc14d2f5070033"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.2.0/ttm-cli-x86_64-apple-darwin.tar.xz"
      sha256 "31988ebf9f168027a52e5d70caf01658c2e38afe6e39e54d6c2eb5c3c5dca007"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.2.0/ttm-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6068621e488f3d2aa76bad08cb131f3d68d86f0a0c189231f1973d2d0c4ed198"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.2.0/ttm-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9a664dba1b22f057ca7d4e191617e751d9e5dc1f7b0aa519148d6f53301b21a7"
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
      bin.install "ttm"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ttm"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ttm"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ttm"
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
