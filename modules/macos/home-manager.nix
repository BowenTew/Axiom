{ config, ... }:

let
  identity = config.axiom.identity;
in {
  config.home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";

    users.${identity.user} = { ... }: {
      _module.args.axiomIdentity = identity;

      imports = [
        ../common/git.nix
        ../common/zsh.nix
        ../common/tmux.nix
        ../common/vim
        ../common/kitty
        ../common/neovim
      ];

      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "23.11";
      };

      manual.manpages.enable = false;
    };
  };
}
