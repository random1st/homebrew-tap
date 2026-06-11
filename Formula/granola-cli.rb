class GranolaCli < Formula
  desc "CLI client for Granola's official MCP server — meetings, transcripts, and notes"
  homepage "https://github.com/random1st/granola-cli"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/random1st/granola-cli/releases/download/v0.1.1/granola-aarch64-apple-darwin.tar.gz"
      sha256 "25e045c7179e80557ed064569b0242b9fe715ba4d33eb72d14b969f9f36b71e1"
    end
    on_intel do
      url "https://github.com/random1st/granola-cli/releases/download/v0.1.1/granola-x86_64-apple-darwin.tar.gz"
      sha256 "457c0c0261c59a44c8d8ef63c25e573605826e9afcb9d6a7f4acc9ae77ba917c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/random1st/granola-cli/releases/download/v0.1.1/granola-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "904ca60abda2534fc85077489db750ea2cfb70ccb6394530ea8604d3dfaaf3d5"
    end
  end

  def install
    bin.install "granola"
  end

  def caveats
    <<~EOS
      One-time setup (opens a browser for Granola OAuth):
        granola login
    EOS
  end

  test do
    assert_match "granola", shell_output("#{bin}/granola --help")
  end
end
