# Home Manager 用户级配置（git / zsh / tmux）
{ ... }:

{
  imports = [
    ./git.nix
    ./zsh.nix
    ./tmux.nix
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    stateVersion = "23.11";
  };

  manual.manpages.enable = false;
}
