{ pkgs, ... }:

{
  imports = [
    ./home-manager.nix
    ./homebrew.nix
  ];
  # System Packages
  environment.systemPackages = with pkgs; [
    zsh
  ];
}
