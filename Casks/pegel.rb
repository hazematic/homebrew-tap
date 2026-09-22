cask "pegel" do
  version "0.1.1"
  sha256 "fc3abddb59eadb81869d8a389b624d784dabf880de948ef405c9b7900e8afbcb"

  url "https://github.com/hazematic/pegel/releases/download/v#{version}/Pegel-#{version}.zip"
  name "Pegel"
  desc "Local dictation that puts the text at the cursor"
  homepage "https://github.com/hazematic/pegel"

  livecheck do
    url :url
    strategy :github_latest
  end

  # No auto_updates: Sparkle checks are off by default, and with it brew upgrade
  # would skip the app.

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Pegel.app"

  # Not notarised: clear the quarantine flag the archive passes on to the app.
  # Acceptable in a tap the user adds deliberately, not in homebrew-cask.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Pegel.app"],
                   must_succeed: false
  end

  caveats <<~EOS
    Pegel is not notarised by Apple, so the download carries macOS' quarantine
    flag and Gatekeeper would refuse the first launch. This cask clears that flag
    after installing, which is why no extra step is needed. If you would rather do
    it yourself, remove the postflight block from the cask and run

      xattr -dr com.apple.quarantine /Applications/Pegel.app

    On first launch Pegel asks to download the speech model (461 MB) and needs
    Microphone, Accessibility and Input Monitoring permissions.
  EOS

  # The Core ML cache (~1.2 GB) outlives the app otherwise. Only Pegel's own model
  # from the FluidAudio folder; the rest may belong to other apps.
  zap trash: [
    "~/Library/Caches/io.github.hazematic.pegel",
    "~/Library/HTTPStorages/io.github.hazematic.pegel",
    "~/Library/Preferences/io.github.hazematic.pegel.plist",
    "~/Library/Application Support/FluidAudio/Models/parakeet-tdt-0.6b-v3",
  ]
end
