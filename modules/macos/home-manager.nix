# Darwin 的 Home Manager 封装
{ axiomIdentity, inputs, ... }:

let
  identity = axiomIdentity;
in
{
  config.home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit axiomIdentity inputs;
    };
    backupFileExtension = "backup";
    users.${identity.user} = { ... }: {
      imports = [
        ../common
      ];
    };
  };
}
