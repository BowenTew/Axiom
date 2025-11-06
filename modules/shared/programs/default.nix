{ pkgs, lib, name, email, ... }:

{
  zsh = import ./zsh { inherit lib; };

  vim = import ./vim { inherit pkgs; };

  git = import ./git { inherit name email; };

  tmux = import ./tmux { inherit pkgs; };
}
