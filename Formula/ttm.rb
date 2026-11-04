class Ttm < Formula
  desc "ttm: command line for toantranmei.com (sign in, workspaces, Notee, Factory sync and local agent runner)"
  homepage "https://toantranmei.com/help/ttm"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.5/ttm-cli-aarch64-apple-darwin.tar.xz"
      sha256 "685c15479159135fe441ca5d00e43f93a14c74534d4a17450ac188860e664e8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.5/ttm-cli-x86_64-apple-darwin.tar.xz"
      sha256 "cb3702c17871da4c743fb6da05836b8c587241a70f67c35809f1ff2f84525824"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.5/ttm-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "90d5ddf370401e423720958390b51d08da034c25e41a86db96e83e34a500a79c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toantranmei/ttm/releases/download/v0.1.5/ttm-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "757266bbd5118f7d7f07d33eae354966a753cdd3461ae5d114e13c1240c8ceb6"
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
