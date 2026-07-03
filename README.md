# DevBox Unity

**A professional Unity development environment for immutable Linux.**

DevBox Unity creates a reproducible Unity development workstation using Distrobox and an Ubuntu container on immutable Linux distributions such as Bazzite.

It is designed to be simple enough for someone installing Unity on Linux for the first time, while remaining robust enough for professional Unity development.

## Why DevBox Unity Exists

Immutable Linux distributions are reliable, easy to maintain, and difficult to accidentally break.

Unfortunately, game development tools often assume a traditional Linux installation. Unity Hub, Rider, browser sign-in flows, NVIDIA passthrough, Android tooling, and desktop integration can all require manual workarounds.

DevBox Unity exists to make that experience predictable.

The goal is simple:

> Spend your time building games, not configuring your computer.

## Principles

DevBox Unity respects the developer.

That means:

- No telemetry
- No advertising
- No paid features
- No vendor lock-in
- Open source from day one
- Reproducible installations
- Safe defaults
- Clear documentation

Donations may support future development and infrastructure, but DevBox Unity itself remains free.

## Target Setup

### Host

- Bazzite or another immutable Linux distribution
- Distrobox
- NVIDIA support where applicable
- GNOME desktop integration

### Container

- Ubuntu 26.04
- Unity Hub
- Unity 6 LTS
- JetBrains Rider support
- Firefox without Snap
- .NET SDK
- Git and Git LFS
- Optional GitKraken support

## Planned Install Flow

```bash
git clone https://github.com/YOUR-USERNAME/devbox-unity.git
cd devbox-unity
./install.sh
```

The installer will guide the user through host checks, container setup, package installation, Unity Hub integration, and desktop launcher exports.

## Unity Folder Layout

DevBox Unity uses a single Unity root directory:

```text
~/Unity/
├── Projects
├── Editors
├── Downloads
├── Cache
└── Licenses
```

## Current Status

Milestone 1: repository foundation.

The installer framework is present but intentionally does not perform a full installation yet.

## License

MIT License.
