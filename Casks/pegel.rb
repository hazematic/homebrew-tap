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

  # Pegel ist nicht notarisiert, und das heruntergeladene Archiv bringt das
  # Quarantäne-Merkmal mit, das die entpackte App erbt. Ohne diesen Schritt
  # verweigert Gatekeeper den ersten Start. Bewusst hier und nicht als Hausaufgabe
  # für den Nutzer: wer dieses Tap hinzufügt, hat die Entscheidung schon getroffen.
  # In homebrew-cask selbst wäre das nicht erwünscht.
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

  # Der dicke Brocken ist der Core-ML-Cache: macOS kompiliert das Modell beim ersten
  # Lauf für die Neural Engine und legt dafür rund 1,2 GB unter Caches ab, also mehr
  # als das Modell selbst. Ohne diesen Eintrag bliebe das nach dem Deinstallieren
  # liegen. Vom FluidAudio-Ordner nur das eigene Modell: silero-vad und alles andere
  # dort kann anderen Programmen gehören.
  zap trash: [
    "~/Library/Caches/io.github.hazematic.pegel",
    "~/Library/HTTPStorages/io.github.hazematic.pegel",
    "~/Library/Preferences/io.github.hazematic.pegel.plist",
    "~/Library/Application Support/FluidAudio/Models/parakeet-tdt-0.6b-v3",
  ]
end
