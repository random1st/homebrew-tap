class Axela < Formula
  desc "Smart macOS network firewall with AI-powered traffic analysis"
  homepage "https://github.com/random1st/axela"
  license "MIT"
  head "https://github.com/random1st/axela.git", branch: "main"

  depends_on :macos
  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags:), "-o", bin/"axelad", "./cmd/axelad"
  end

  service do
    run [opt_bin/"axelad", "--log-file", var/"log/axela/daemon.log", "--data-dir", var/"db/axela"]
    keep_alive true
    require_root true
    log_path var/"log/axela/homebrew.stdout.log"
    error_log_path var/"log/axela/homebrew.stderr.log"
    working_dir var/"db/axela"
  end

  def post_install
    (var/"log/axela").mkpath
    (var/"db/axela").mkpath
  end

  def caveats
    <<~EOS
      Axela requires root privileges to manage macOS Packet Filter.

      Start the daemon:
        sudo brew services start axela

      Or run manually:
        sudo axelad

      Web UI: http://127.0.0.1:8080

      Enable AI-powered analysis (optional):
        sudo axelad --llm --llm-provider local --download-model

      Configuration: ~/.axela/config.yaml
    EOS
  end

  test do
    assert_match "axelad", shell_output("#{bin}/axelad --help 2>&1", 0)
  end
end
