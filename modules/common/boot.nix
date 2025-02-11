{
  config,
  lib,
  ...
}:{
  # Grub Configuration
  boot = {
    consoleLogLevel = 0;
    kernelParams = ["quiet" "udev.log_level=3"];
    initrd = {
      systemd = {
        enable = true;
      };
      verbose = false;
    };
    loader = {
      grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
        enable = true;
        configurationLimit = 10;
      };
    };
  };
}
