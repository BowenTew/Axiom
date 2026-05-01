# 独立的 Home Manager 配置入口
# 使用方式: home-manager switch --flake .#username
{ axiomIdentity, pkgs, inputs, ... }:

{
  imports = [
    ./modules/common
  ];

  home = {
    username = axiomIdentity.user;
    homeDirectory =
      if pkgs.stdenv.isDarwin then
        "/Users/${axiomIdentity.user}"
      else
        "/home/${axiomIdentity.user}";
  };

  programs.home-manager.enable = true;
}
