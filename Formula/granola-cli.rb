class GranolaCli < Formula
  desc "CLI client for Granola's official MCP server — meetings, transcripts, and notes"
  homepage "https://github.com/random1st/granola-cli"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/random1st/granola-cli/releases/download/v0.1.2/granola-aarch64-apple-darwin.tar.gz"
      sha256 "b852892844fb6f777e4a2a314c92302d6bd11f7ed455433e7de7f733907bef95"
    end
    on_intel do
      url "https://github.com/random1st/granola-cli/releases/download/v0.1.2/granola-x86_64-apple-darwin.tar.gz"
      sha256 "d76e7f6e917d6c3a39bfa65e833bf692c74c1e6cf5e1e93f7f18ea7d1b02701d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/random1st/granola-cli/releases/download/v0.1.2/granola-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "43cf3af9e49548bcb54a334a7a79aaf0e6036948d804d9abb7513eb854f4d01a"
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
