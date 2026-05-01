# Darwin 的 Home Manager 封装
{ axiomIdentity, ... }:

let
  identity = axiomIdentity;
in
{
  config.home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit axiomIdentity;
    };
    backupFileExtension = "backup";
    users.${identity.user} = { ... }: {
      imports = [
        ../../modules/common
      ];
    };
  };
}
