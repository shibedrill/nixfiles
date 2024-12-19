# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [ 
    vim 
    wget
    curl
    git
    gnupg
    pinentry-curses
    file
  ];

  programs.gnupg.agent.enable = true;
  programs.nix-ld.enable = true;

  users.users.river = {
    isNormalUser = true;
    home = "/home/river";
    description = "River";
    extraGroups = [ "wheel" ];
  };

  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "river";
  wsl.wslConf.network.generateResolvConf = false;

  networking.nameservers = [ "10.0.0.1" "1.1.1.1" "8.8.8.8" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
