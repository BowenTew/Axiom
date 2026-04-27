{ ... }:

let
  packages = [];
  casks = [
    "kitty"
    # "wezterm"
    # "alacritty"
  ];
in
{
  config.homebrew = {
    enable = true;
    brews = packages;
    casks = casks;
  };
}
