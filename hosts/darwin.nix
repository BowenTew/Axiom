{ self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, home-manager, nixpkgs, disko, fenix, ... } @inputs:

let
  darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
  macosModule = ../modules/macos;

  nixHomebrewConfigModule = { config, ... }: {
    nix-homebrew = {
      user = config.axiom.identity.user;
      enable = true;
      mutableTaps = false;
      autoMigrate = true;
      taps = {
        "homebrew/homebrew-core" = homebrew-core;
        "homebrew/homebrew-cask" = homebrew-cask;
        "homebrew/homebrew-bundle" = homebrew-bundle;
      };
    };
  };

  # MacOS System Configuration
  darwinConfigModule = { config, pkgs, ... }:
    let
      user = config.axiom.identity.user;
    in {
    # User Configuration
    users.users.${user} = {
      home = "/Users/${user}";
      isHidden = false;
      name = user;
      shell = pkgs.zsh;
    };

    # Nix Configuration
    nix = {
      package = pkgs.nix;
      settings = {
        trusted-users = [ "@admin" user ];
        substituters = [
          "https://nix-community.cachix.org"
          "https://cache.nixos.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      };
      gc = {
        automatic = true;
        interval = {
          Weekday = 0;
          Hour = 2;
          Minute = 0;
        };
        options = "--delete-older-than 30d";
      };
      extraOptions = ''experimental-features = nix-command flakes'';
    };

    # System Configuration
    system = {
      checks.verifyNixPath = false;
      primaryUser = user;
      stateVersion = 5;

      defaults = {
        NSGlobalDomain = {
          AppleShowAllExtensions = true;
          ApplePressAndHoldEnabled = false;
          KeyRepeat = 2;
          InitialKeyRepeat = 15;
        };
      };
    };
  };
in

nixpkgs.lib.genAttrs darwinSystems (system:
  darwin.lib.darwinSystem {
    inherit system;
    specialArgs = inputs;
    modules = [
      home-manager.darwinModules.home-manager
      nix-homebrew.darwinModules.nix-homebrew
      nixHomebrewConfigModule
      darwinConfigModule
      macosModule
    ];
  }
)
