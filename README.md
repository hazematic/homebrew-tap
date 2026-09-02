# hazematic/homebrew-tap

Homebrew tap for [Pegel](https://github.com/hazematic/pegel), local dictation for
macOS.

```bash
brew install --cask --no-quarantine hazematic/tap/pegel
```

`--no-quarantine` is needed because the app is not notarised by Apple. Without it
macOS refuses the first launch and you have to clear the flag by hand.

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
