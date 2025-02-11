let
  # Systems
  vps = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBxcabp/qIxeHKQhVXpytUbCphC/27HZvyiqqAM5cNHH";
  builder = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEOya2eplq2JsFcpcisZ4LlKXY04+Y4Q6ZwgLvGIDkYx";
  all_systems = [ vps builder ];
  # Users
  nixos-builder = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+uM/gmfSkC7iH8YdUW9tAfSdenTr/EhE/V6Ql9drSp";
  all_users = [ nixos-builder ];
in
{
  "vps-root-pwd.age".publicKeys = [ vps nixos-builder];
  "vps-TabascoAnthill-pwd.age".publicKeys = [ vps nixos-builder];
  "vps-wg-private-key.age".publicKeys = [ vps nixos-builder];



  "wg-public-key.age".publicKeys = all_systems ++ all_users;
}
