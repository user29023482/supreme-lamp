{
  config,
  inputs,
  ...
}:

{
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  age.secrets.vps-root-pwd.file = ../../secrets/vps-root-pwd.age;
  age.secrets.vps-TabascoAnthill-pwd.file = ../../secrets/vps-TabascoAnthill-pwd.age;
  age.secrets.vps-wg-private-key.file = ../../secrets/vps-wg-private-key.age;
  
  age.secrets.wg-public-key.file = ../../secrets/wg-public-key.age;
}
