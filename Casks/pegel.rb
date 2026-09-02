cask "pegel" do
  version "0.1.0"
  sha256 "2a7f20db21dbfb5df8a33878da151f6f7e1c84e72d6749e607644a91a152ffe2"

  url "https://github.com/hazematic/pegel/releases/download/v#{version}/Pegel-#{version}.zip"
  name "Pegel"
  desc "Local dictation that puts the text at the cursor"
  homepage "https://github.com/hazematic/pegel"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Pegel.app"

  caveats <<~EOS
    Pegel is not notarised by Apple. The download carries the quarantine flag,
    so macOS refuses the first launch. Clear it once:

      xattr -dr com.apple.quarantine /Applications/Pegel.app

    On first launch Pegel asks to download the speech model (461 MB) and needs
    Microphone, Accessibility and Input Monitoring permissions.
  EOS

  zap trash: [
    "~/Library/Preferences/io.github.hazematic.pegel.plist",
    "~/Library/Application Support/FluidAudio/Models/parakeet-tdt-0.6b-v3",
  ]
end
