# nix-image-flake

A nix flake that generates an image running NixOS.

## Tasks

### Build-iso

Builds the image.

```bash
nix build .\#images.iso
```

### Build-sd

Builds the image for aarch64.

```bash
nix build .\#images.sd
```
