{ pkgs, ... }:
{
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
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ]; # Allow SSH connections.
  };

  system.stateVersion = "23.11";
}
