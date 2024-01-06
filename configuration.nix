{ pkgs, lib, ... }:
{
  networking = {
    hostName = "systemhostname";
  };

  environment.systemPackages = [
    pkgs.git
  ];

  users.users.headb = {
    isNormalUser = true;
    group = "users";
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICvr2FrC9i1bjoVzg+mdytOJ1P0KRtah/HeiMBuKD3DX cardno:23_836_181''
    ];
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = lib.mkForce "no";
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ]; # Allow SSH connections.
  };

  hardware.enableRedistributableFirmware = true;
  networking.wireless = {
    enable = true;
    networks = {
      #"wifi-ssid" = {
      #  psk = "wifi-password";
      #};
    };
  };

  nix = {
    # Garbage collection for small SD cards.
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

  system.stateVersion = "23.11";
}
