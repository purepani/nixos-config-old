{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  nixos-wsl = import ./nixos-wsl;
in
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"

    nixos-wsl.nixosModules.wsl
    ./cachix.nix
  ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "nixos";
    startMenuLaunchers = true;

    # Enable native Docker support
    docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;

   };

  system.stateVersion = "22.05";
  environment.systemPackages = with pkgs; [
	vim
	neovim
	wget
	];
  programs.neovim.defaultEditor = true;
  nix = {
    settings = {
	auto-optimise-store = true;	
	};
    package = pkgs.nixFlakes;
    extraOptions = ''
	experimental-features = nix-command flakes
	keep-outputs = true
	keep-derivations = true
	allow-import-from-derivation = true
	'';
  };

  nix.settings.trusted-public-keys = [
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];
  nix.settings.substituters = [
    "https://cache.iog.io"
  ];

}
