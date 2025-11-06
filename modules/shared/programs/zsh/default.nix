{ lib, ... }:
{
  enable = true;
    autocd = false;
    "oh-my-zsh" = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "web-search" ];
    };

    initContent = lib.mkBefore ''
      # This script initializes the environment for the Nix package manager.

      # Check if the specified file exists and is a regular file.
      # This file is part of a standard Nix multi-user installation.
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        # Source (execute) the nix-daemon.sh script in the current shell session.
        # This script sets up environment variables and paths necessary for the
        # Nix daemon, which manages builds and packages in a multi-user setup.
        # It typically adds the Nix binary directory to the PATH.
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        # Source the nix.sh script in the current shell session.
        # This script sets up essential user-specific Nix environment variables.
        # The most important one is NIX_PATH, which tells Nix where to look for
        # expressions (like nixpkgs). It may also configure other settings.
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi
      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"


      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
    envExtra = ''
      export PATH="/opt/homebrew/bin:$PATH"
      export PATH="$HOME/.local/bin:$PATH"
    '';
}