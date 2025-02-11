{
  config,
  agenix,
  ...
}:{
  # Wireguard systemd-networkd
  networking.firewall.checkReversePath = "loose";  # Allow tunneling all wireguard traffic
  networking.firewall.allowedUDPPorts = [51820];

  age.secrets.vps-wg-private-key = {
    owner = "systemd-network";
  };
  age.secrets.wg-public-key = {
    owner = "systemd-network";
  };
  systemd.network = {
    enable = true;
    netdevs = {
      "10-wg0" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
        };
        wireguardConfig = {
          # Must be readable by the systemd.network user
          PrivateKeyFile = "${config.age.secrets.vps-wg-private-key.path}";
          ListenPort = 51820;
        };
        wireguardPeers = [
          {
            # Pfsense
            PublicKey = "gPdBMM+fw4z7XFep7C1WNyLf+jY7433E/RJu+7daJ2w=";
            PresharedKeyFile = "${config.age.secrets.wg-public-key.path}";
            AllowedIPs = ["10.200.200.1/24"];
            Endpoint = "wg.peacocks.me:51820";
          }
        ];
      };
    };
    networks.wg0 = {
      matchConfig.Name = "wg0";
      address = ["10.200.200.2/32"]; # todo variable to control
      DHCP = "no";
      dns = ["10.200.200.1"];
      linkConfig.RequiredForOnline = "no";
      networkConfig = {
        IPv4Forwarding = "yes";
      };
    };
  };
}
