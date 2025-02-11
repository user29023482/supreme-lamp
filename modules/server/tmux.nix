{
  ### Tmux
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    historyLimit = 5000;
    keyMode = "emacs";
    newSession = true;
    shortcut = "a";
    terminal = "tmux-256color";
  };
}
