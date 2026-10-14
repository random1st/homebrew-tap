require_relative "../lib/hellcode_private_release"

class Hellcode < Formula
  desc "Native iOS and Android device automation"
  homepage "https://github.com/random1st/hellcode"
  url "https://github.com/random1st/hellcode/releases/download/v0.2.1/hellcode-0.2.1-macos-arm64.tar.gz",
      using: HellcodePrivateReleaseDownloadStrategy
  sha256 "b9d80f79325d6f7214fd569c1dcf0a1483a0189c75c6c69451e2196ca711f8f3"

  depends_on "gh"
  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    libexec.install "hellcode", "Hellcode_DeviceCore.bundle", "Hellcode_DeviceContracts.bundle"
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
    assert_match "87dbd708", shell_output("#{bin}/hellcode contract catalog")
    assert_path_exists libexec/"Hellcode_DeviceContracts.bundle/Contents/Resources/agent-device-LICENSE.txt"
  end
end
