# Home Manager 用户级配置（git / zsh / tmux）
{ pkgs, inputs, ... }:

{
  imports = [
    ./git.nix
    ./zsh.nix
    ./tmux.nix
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    stateVersion = "23.11";
    packages = import ./packages.nix { inherit pkgs inputs; };
  };

  manual.manpages.enable = false;
}
