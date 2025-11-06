{ pkgs, lib, ... }:

{
  git = import ./git;

  zsh = import ./zsh { inherit lib; };

  vim = import ./vim { inherit pkgs; };

  tmux = import ./tmux { inherit pkgs; };
}
