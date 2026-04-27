{ ... }:

let
  packages = [];
  casks = [
    "kitty"
    # "wezterm"
    # "alacritty"
    # "ghostty"
  ];
in
{
  config.homebrew = {
    enable = true;
    brews = packages;
    casks = casks;
  };
}
