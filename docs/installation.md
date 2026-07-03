# Installation

Milestone 2 provides the installer framework only.

## Test the framework

```bash
./install.sh --dry-run
```

## Planned container creation

```bash
distrobox create \
  --name unity-dev \
  --image ubuntu:26.04 \
  --nvidia
```
