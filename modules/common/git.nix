{ axiomIdentity, ... }:

let
  identity = axiomIdentity;
in {
  programs.git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = identity.gitName;
    userEmail = identity.gitEmail;
    lfs.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };
}
