{
  services = {
    printing.enable = true;

    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
  };
}
