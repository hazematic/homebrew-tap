# hazematic/homebrew-tap

Homebrew tap for [Pegel](https://github.com/hazematic/pegel), local dictation for
macOS.

```bash
brew install --cask hazematic/tap/pegel
xattr -dr com.apple.quarantine /Applications/Pegel.app
```

The second line is needed because the app is not notarised by Apple. Homebrew no
longer sets the quarantine flag itself, but the downloaded archive already carries
it and the unpacked app inherits it, so Gatekeeper refuses the first launch. There
used to be a `--no-quarantine` option for this; it was removed from Homebrew.

## Releasing a new version

```bash
cd ../pegel
./build-app.sh release --zip          # writes build/Pegel-<version>.zip
```

Attach that ZIP to a GitHub release tagged `v<version>`, then:

```bash
./update-cask.sh ../pegel/build/Pegel-<version>.zip
git commit -am "pegel <version>" && git push
```

The repository has to be named `homebrew-tap` for `hazematic/tap` to resolve.
