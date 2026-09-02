cask "pegel" do
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/hazematic/pegel/releases/download/v#{version}/Pegel-#{version}.zip"
  name "Pegel"
  desc "Local dictation that puts the text at the cursor"
  homepage "https://github.com/hazematic/pegel"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "Pegel.app"

  caveats <<~EOS
    Pegel is not notarised by Apple. Install it with --no-quarantine, otherwise
    macOS refuses the first launch:

      brew install --cask --no-quarantine hazematic/tap/pegel

    If you already installed it without that flag:

      xattr -dr com.apple.quarantine /Applications/Pegel.app

    On first launch Pegel asks to download the speech model (461 MB) and needs
    Microphone, Accessibility and Input Monitoring permissions.
  EOS

  zap trash: [
    "~/Library/Preferences/io.github.hazematic.pegel.plist",
    "~/Library/Application Support/FluidAudio/Models/parakeet-tdt-0.6b-v3",
  ]
end
