let
  gitUserName = "%NAME%";
  gitUserEmail = "%EMAIL%";
in
{
  enable = true;
  ignores = [ "*.swp" ];
  userName = gitUserName;
  userEmail = gitUserEmail;
  lfs.enable = true;

  extraConfig = {
    init = {
      defaultBranch = "main";
    };
    core = {
      editor = "vim";
      autocrlf = "input";
    };
    pull = {
      rebase = true;
    };
    rebase = {
      autoStash = true;
    };
  };
}

