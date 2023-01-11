{ config, pkgs, options, ... }:
let 
	customNeovim = import ./programs/neovim/default.nix;
    #my-python-packages = python-packages: with python-packages; [
        #pandas
        #numpy other python packages you want ]; 
      #python-with-my-packages = python3.withPackages my-python-packages;
      pkgsUnstable = import <nixpkgs-unstable> {};
      customPylsp =    pkgs.python39Packages.python-lsp-server.override {
                                  withAutopep8 = true; 
                                  withFlake8 = true; 
                                  withMccabe = true; 
                                  withPycodestyle =true;
                                  withPydocstyle = true;
                                  withPyflakes = true;
                                  withPylint = true;
                                  withRope = true; 
                                  withYapf = true;
                                };
   #nixpkgs-overlays = builtins.fetchTarball "https://gitlab.com/api/v4/projects/zanc%2Foverlays/repository/archive.tar.gz?sha=master";
   #test = import (nixpkgs-overlays + "/overlays.nix");
    
    

   
in {
  # Let Home Manager install and manage itself.

  #nix.nixPath = options.nix.nixPath.default ++ [ "nixpkgs-overlays=${nixpkgs-overlays}/overlays.nx" ];
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "satwik";
  home.homeDirectory = "/home/satwik";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwyards
  # incompatible changes.

  home.stateVersion = "22.05";

  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.sessionVariables.EDITOR = "nvim";
  programs.git = {
      enable = true;
      userName  = "purepani";
      userEmail = "pani0028@umn.edu";
    };
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    #programs.kdeconnect.enable = true;
    programs.bash = { 
        enable = true;
        bashrcExtra = ''
          eval "$(direnv hook bash)"
      '';
    };
	home.packages = with pkgs; [
          jre8
          gnome.zenity
          openssl
          wineWowPackages.stable
          #wine
          inkscape
          bluez
          libreoffice
          lutris
          openjdk8
          minecraft
          anki
          zotero
          ranger
          arduino
          blender
          #kdeconnect
          dunst
          spectacle
          imagemagick
          taskwarrior
          lmms
          lilypond
          vlc
          mpv
          reaper
          frescobaldi
          musescore
          xclip
          #cura
          #prusa-slicer
          slic3r
          pavucontrol
          okular
          godot
          linuxConsoleTools
          #python3
          rust-analyzer
          graphviz
          bash
	  discord
          gcc
          nerdfonts
          zoom
          #freecad
          #librecad
          mupen64plus
          zoom
          #dotnet-runtime
          virt-manager
          emacs
          restic
          ledger
          neovide
          audacity
          kicad
          kgpg
          fd
          rclone
          chromium
          appimage-run
          unzip
 	] ++ [customPylsp pkgsUnstable.prismlauncher];
        programs.neovim = customNeovim pkgs;
        #programs.neovim.enable = true;
        services.syncthing.enable = true;
#        programs.bash.sessionVariables = {PATH = "$HOME/.nix-profile/bin";};

  nixpkgs.overlays = [
          (import (builtins.fetchTarball {
            url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
          }))
#          (self: super: { discord = super.discord.overrideAttrs (_: { src = builtins.fetchTarball <link-to-tarball>; });})

        ];

	imports = [
        #./programs/xmonad/default.nix
	#./programs/neovim/default.nix
	];    
	nixpkgs.config = {
	  allowUnfree = true;
	};
	
	#xsession.enable = true;

	#xsession.windowManager.command = "…";
}
