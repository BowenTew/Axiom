{ ... }:

let
  packages = [];
  casks = [
    "kitty"
    "ghostty"
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
