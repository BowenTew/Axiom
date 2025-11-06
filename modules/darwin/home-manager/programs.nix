{ config, pkgs, lib, name, email, ... }:

let 
  sharedPrograms = import ../../shared/programs.nix { inherit config pkgs lib name email; };
  
  # Darwin 特定的程序配置
  darwinPrograms = {};
in

# 合并共享程序和 Darwin 特定程序
sharedPrograms // darwinPrograms