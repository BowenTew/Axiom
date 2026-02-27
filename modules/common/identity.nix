{ lib, ... }:

{
  options.axiom.identity = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
      default = "moonshot";
    };

    gitName = lib.mkOption {
      type = lib.types.str;
      description = "Git user name";
      default = "Tetsuya";
    };

    gitEmail = lib.mkOption {
      type = lib.types.str;
      description = "Git user email";
      default = "1376490336@qq.com";
    };
  };
}
