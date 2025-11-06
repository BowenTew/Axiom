let
  gitUserName = "Tetsuya";
  gitUserEmail = "1376490336@qq.com";
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

