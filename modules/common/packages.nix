{
  pkgs,
  ...
}:{
  # systemwide packages
  environment.systemPackages = with pkgs; [
    bottom
    curl
    dua
    fd
    curl
    git
    rsync
    screen
    tmux
    wget
    wireguard-tools
  ];
} 
