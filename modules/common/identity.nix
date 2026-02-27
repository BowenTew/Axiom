{ lib, ... }:

{
  options.axiom.identity = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
      default = "%USER%";
    };

    gitName = lib.mkOption {
      type = lib.types.str;
      description = "Git user name";
      default = "%GIT_NAME%";
    };

    gitEmail = lib.mkOption {
      type = lib.types.str;
      description = "Git user email";
      default = "%GIT_EMAIL%";
    };
  };
}
