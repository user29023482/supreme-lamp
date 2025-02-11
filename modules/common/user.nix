{
  config,
  ...
}:{
  users.users.root = {
    ## hash: mkpasswd -m SHA-512 -s 
    hashedPasswordFile = config.age.secrets.vps-root-pwd.path;
  };

  # Normal user
  users.users.TabascoAnthill = {
    isNormalUser = true;
    group = "TabascoAnthill";
    extraGroups = ["wheel" "networkmanager" "libvirtd"];
    uid = 1000;

    hashedPasswordFile = config.age.secrets.vps-TabascoAnthill-pwd.path;
    #initialHashedPassword = "";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDV+gGKbEwiI3GXF66ZKRbqOzMH4FJp1c9frI9W2wPlPeFKsiTRlVxQbyyJTWlQc5Cd/bQx/rQlO8RcByc/fGomYZ5LyyuusTx3qPpO9HLk2vfmevBYQxl1Gscseq/7wYqJuJ6r5UJY8zyy5vWUnPUbdZjbSqbWX68VbjJ8alDoRKO3WxTmiWwEx9SJ75+oRRAbdx5yi/x498578JgC/dLxycImYTLgHdribXAOcn7Mr/OIaVGOo+L60k54ULAQOSn/pxwRNEiyr6xa5XIj+NsFYKS5C38SxyWJOZ7NP1s4oafG0aGy4DIOkxjezReV8h8B/L/r79w6PnttTn+GN0zt imported-openssh-key"
    ];
  };

  users.groups.TabascoAnthill = {
    gid = 1000;
  };
}
