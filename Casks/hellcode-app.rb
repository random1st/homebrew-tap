cask "hellcode-app" do
  version "0.1.1"
  sha256 "0c2d2fcc0c11b5c6fd2c3193ce32a1230bd85523cfb1522965a7e61c3df7b2b5"

  url "https://github.com/random1st/hellcode/releases/download/v#{version}/Hellcode-#{version}-macos-arm64.zip"
  name "Hellcode"
  desc "Native device automation and setup wizard for iOS and Android"
  homepage "https://github.com/random1st/hellcode"

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Hellcode.app"

  caveats <<~EOS
    This preview is ad hoc signed and has not been notarized.
    macOS may require approval in Privacy & Security before opening it.
    For a standalone CLI: brew install random1st/tap/hellcode
  EOS
end
