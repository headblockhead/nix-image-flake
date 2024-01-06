{
  description = "Nix flake for building a NixOS image";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };

  outputs = { nixpkgs, ... }:
    let
      nixosConfigurations = {
        # Build an ISO image.
        isoSystem = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # build on x86_64-linux, for x86_64-linux.
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix"
            ./configuration.nix
          ];
        };

        # Build an SD card image.
        sdSystem = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # build on x86_64-linux, cross-compile to aarch64-linux.
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64-new-kernel-no-zfs-installer.nix"
            ./configuration.nix

            # Cross-compile to aarch64-linux.
            {
              nixpkgs.config.allowUnsupportedSystem = true;
              nixpkgs.crossSystem.system = "aarch64-linux";
            }
          ];
        };

      };
    in
    {
      images.iso = nixosConfigurations.isoSystem.config.system.build.isoImage;
      images.sd = nixosConfigurations.sdSystem.config.system.build.sdImage;
    };
}
