class GranolaCli < Formula
  desc "CLI client for Granola's official MCP server — meetings, transcripts, and notes"
  homepage "https://github.com/random1st/granola-cli"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/random1st/granola-cli/releases/download/v0.1.1/granola-aarch64-apple-darwin.tar.gz"
      sha256 "fdac3f3783e52d04b68285d3edf0603fe7e3d07bc164ae90999dc65d78d33419"
    end
    on_intel do
      url "https://github.com/random1st/granola-cli/releases/download/v0.1.1/granola-x86_64-apple-darwin.tar.gz"
      sha256 "db40bdac60f6a97a1e5d9e060e039fcf7af67ec100fd6c8c1764add5e7e1231f"
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
