# DevBox Unity

**A professional Unity development environment for immutable Linux.**

DevBox Unity creates a reproducible Unity development workstation using Distrobox and an Ubuntu container on immutable Linux distributions such as Bazzite.

It is designed to be simple enough for someone installing Unity on Linux for the first time, while remaining robust enough for professional Unity development.

## Why DevBox Unity Exists

Immutable Linux distributions are reliable, easy to maintain, and difficult to accidentally break.

Unfortunately, game development tools often assume a traditional Linux installation. Unity Hub, Rider, browser sign-in flows, NVIDIA passthrough, Android tooling, and desktop integration can all require manual workarounds.

DevBox Unity exists to make that experience predictable.

> Spend your time building games, not configuring your computer.

## Principles

- No telemetry
- No advertising
- No paid features
- No vendor lock-in
- Open source from day one
- Reproducible installations
- Safe defaults
- Clear documentation

## Current Status

Milestone 4 adds Firefox installation from Mozilla's official APT repository.

The installer currently provides:

- Base Ubuntu development packages
- Firefox from Mozilla's official DEB repository
- Configuration loading
- Logging and environment checks
- Dry-run support
- Host/container mode detection
- Unity development directory creation

Unity Hub, Rider, GitKraken, and Android tooling are not installed yet.

## Planned Install Flow

```bash
./install.sh
```

Useful options:

```bash
./install.sh --help
./install.sh --dry-run
./install.sh --mode host
./install.sh --mode container
```

## Unity Folder Layout

```text
~/Unity/
├── Projects
├── Editors
├── Downloads
├── Cache
└── Licenses
```

## License

MIT License.
