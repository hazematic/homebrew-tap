# hazematic/homebrew-tap

Homebrew tap for [Pegel](https://github.com/hazematic/pegel), local dictation for
macOS.

```bash
brew install --cask hazematic/tap/pegel
```

That is the whole installation. Pegel is not notarised by Apple, so the downloaded
archive carries macOS' quarantine flag and Gatekeeper would refuse the first launch;
the cask clears that flag in a `postflight` block. Homebrew used to have a
`--no-quarantine` option for this, but it was removed.

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
