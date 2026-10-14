require_relative "../lib/hellcode_private_release"

cask "hellcode-cli" do
  version "0.2.1"
  sha256 "b9d80f79325d6f7214fd569c1dcf0a1483a0189c75c6c69451e2196ca711f8f3"

  url "https://github.com/random1st/hellcode/releases/download/v#{version}/hellcode-#{version}-macos-arm64.tar.gz",
      using: HellcodePrivateReleaseDownloadStrategy
  name "Hellcode CLI"
  desc "Headless iOS and Android device automation"
  homepage "https://github.com/random1st/hellcode"

  depends_on formula: "gh"
  depends_on arch: :arm64
  depends_on macos: :sonoma

  binary "hellcode"

  caveats <<~EOS
    Run hellcode setup to configure device tools.
    iOS requires Xcode; Android requires Android SDK Platform Tools.
    Install either this cask or the hellcode formula; both provide the same command.
    The GUI is available separately: brew install --cask random1st/tap/hellcode-app
  EOS
end
