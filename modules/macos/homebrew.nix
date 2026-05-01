{ ... }:

let
  packages = [];
  casks = [
    "kitty"
    "ghostty"
    # "visual-studio-code"
    # "postman"
    # "google-chrome"
    
    # # Work Tool
    # "fork"
    # "charles"
    # "android-studio"
    # "utm"
    # "orbstack"

    # # Agent 
    # "codex",
    # "chatgpt-atlas",
    # "chatgpt",
    # "thebrowsercompany-dia",

    # # Terminal
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
