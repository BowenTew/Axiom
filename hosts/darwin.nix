{ self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, home-manager, nixpkgs, disko, fenix } @inputs:

let
  user = "moonshot";
  darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
  darwinConfigModule = ../modules/darwin;
  nixHomebrewConfigModule = {
    nix-homebrew = {
      inherit user;
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
in

nixpkgs.lib.genAttrs darwinSystems (system:
  darwin.lib.darwinSystem {
    inherit system;
    specialArgs = inputs // { inherit user; };
    modules = [
      home-manager.darwinModules.home-manager
      nix-homebrew.darwinModules.nix-homebrew
      nixHomebrewConfigModule
      darwinConfigModule
    ];
  }
)