class Ttm < Formula
  desc "ttm: command line for toantranmei.com (sign in, workspaces, Notee, Factory sync and local agent runner)"
  homepage "https://toantranmei.com/help/ttm"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.2/ttm-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f877514f9ad7ccca5d3262ef7a8bb15271df8a1d0a96d4e3d20b1aa4f7764d3d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.2/ttm-cli-x86_64-apple-darwin.tar.xz"
      sha256 "795671826e7fffcab0c8fee6171706a11b223e74141fe97510dbdc81048aab19"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.2/ttm-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bcb5151fca78be9388a73c7baef825c0eb67a1a423f521a6b0a4ab7ace83e29f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.2/ttm-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "961d00aec3692b48f3bf62167690acbd1483768877db00ffdfa47e213103753f"
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
