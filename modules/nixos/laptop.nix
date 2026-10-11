{
  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
  };

  services = {
    blueman.enable = true;
    fwupd.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };

  zramSwap.enable = true;
}
