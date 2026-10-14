require_relative "../lib/hellcode_private_release"

cask "hellcode-app" do
  version "0.2.1"
  sha256 "ed48e9f6cf66ec1120148c460c80917a2734d8a696c01db96866110a069201a2"

  url "https://github.com/random1st/hellcode/releases/download/v#{version}/Hellcode-#{version}-macos-arm64.zip",
      using: HellcodePrivateReleaseDownloadStrategy
  name "Hellcode"
  desc "Native device automation and setup wizard for iOS and Android"
  homepage "https://github.com/random1st/hellcode"

  depends_on formula: "gh"
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Hellcode.app"

  caveats <<~EOS
    This build is Developer ID signed and notarized.

    For a standalone CLI: brew install --cask random1st/tap/hellcode-cli
  EOS
end
