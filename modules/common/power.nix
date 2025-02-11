{
  pkgs,
  ...
}:{
  # Power management
  powerManagement.powertop.enable = true;
  services.tlp.enable = true;

}
