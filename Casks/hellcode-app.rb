cask "hellcode-app" do
  version "0.1.0"
  sha256 "5bafe33193c2baf6a8ca5c25bb0df7a83e0909cfabf76ac015c9a75718c2849d"

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
