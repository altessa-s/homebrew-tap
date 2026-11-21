# altessa-s Homebrew tap

Homebrew formulae for command-line tools from [altessa-s](https://github.com/altessa-s).

```sh
brew install altessa-s/tap/rmctl
brew install altessa-s/tap/snctl
```

Or tap once and install by name:

```sh
brew tap altessa-s/tap
brew install rmctl
```

| Formula | What it is |
|---|---|
| [`rmctl`](https://github.com/altessa-s/rmctl) | Command-line client for the reMarkable cloud: list, fetch, upload and inspect documents |
| [`snctl`](https://github.com/altessa-s/snctl) | Command-line client for the Supernote cloud: list, fetch, upload, mirror and render notebooks |

Each tool also has a `-lite` formula (`rmctl-lite`, `snctl-lite`): the same client without the notebook renderer and its
native libraries.

The formulae install the prebuilt macOS and Linux binaries attached to each tool's GitHub release. They are written by the
tools' release workflows; changes made here by hand are overwritten by the next release.

## License

MIT; see [LICENSE](LICENSE). reMarkable is a trademark of reMarkable AS. Supernote is a trademark of Ratta Software. These
tools are not affiliated with, endorsed by or sponsored by reMarkable AS or Ratta Software.
