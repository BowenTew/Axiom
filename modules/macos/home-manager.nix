{ config, inputs, ... }:

let
  identity = config.axiom.identity;
in {
  config.home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };

    users.${identity.user} = { ... }: {
      _module.args.axiomIdentity = identity;

      imports = [
        ../common/git.nix
        ../common/zsh.nix
        ../common/tmux.nix
        ../common/vim
      ];

      home = {
        enableNixpkgsReleaseCheck = false;
        stateVersion = "23.11";
      };

      manual.manpages.enable = false;
    };
  };
}
