class Hellcode < Formula
  desc "Native iOS and Android device automation"
  homepage "https://github.com/random1st/hellcode"
  url "https://github.com/random1st/hellcode/releases/download/v0.1.1/hellcode-0.1.1-macos-arm64.tar.gz"
  sha256 "7beb2c9c23af95bd72bd3d2f46fdef7dfaac88e4fd613a29c70df84466cffb8a"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    libexec.install "hellcode", "Hellcode_DeviceCore.bundle"
    bin.write_exec_script libexec/"hellcode"
  end

  def caveats
    <<~EOS
      Run hellcode setup to configure device tools.
      iOS requires Xcode; Android requires Android SDK Platform Tools.
      The GUI is available separately: brew install --cask random1st/tap/hellcode-app
    EOS
  end

  test do
    assert_match "Usage: hellcode", shell_output("#{bin}/hellcode --help")
    ENV["HELLCODE_HOME"] = (testpath/"state").to_s
    assert_equal [], JSON.parse(shell_output("#{bin}/hellcode sessions"))
    assert_path_exists libexec/"Hellcode_DeviceCore.bundle/Contents/Resources/AppleRunner/Runner.swift"
  end
end
