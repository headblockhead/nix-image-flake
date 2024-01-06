# Uncomment all the commented lines below and run:
# nix build .\#images.sdcard
# to build an aarch64 SD card image. (For the Raspberry Pi or similar.)

{
  description = "Nix flake for building a NixOS ISO";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { nixpkgs, ... }:
    let
      nixosConfigurations.system = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64-new-kernel-no-zfs-installer.nix"
          # {
          #   nixpkgs.config.allowUnsupportedSystem = true;
          #   nixpkgs.crossSystem.system = "aarch64-linux";
          # }

          "${nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix"
          ./configuration.nix
        ];
      };
    in
    {
      images.iso = nixosConfigurations.system.config.system.build.isoImage;
      # images.sdcard = nixosConfigurations.system.config.system.build.sdImage;
    };
}
