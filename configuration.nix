# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" 
  			"mem_sleep_default=deep"];
  boot.initrd.kernelModules = [ "amdgpu" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "satwik-nixos"; # Define your hostname.
  networking.wireless = {
  	enable = true;
	userControlled.enable = true;
	networks = {
		APT205 = {
			psk="zanyoboe639";	
		};
		eduroam = {
			auth=''
				proto=RSN
				key_mgmt=WPA-EAP
				eap=PEAP
				identity="pani0028@umn.edu"
				password=hash:7e0fbd29e502cbb17b3f8c3c43ef857d
				domain_suffix_match="umn.edu"
				anonymous_identity="pani0028@umn.edu"
				phase1="peaplabel=0"
				phase2="auth=MSCHAPV2"
			'';
				#password="zp8fJ8EfyChfy23MkizujbwgyvcU6i"
		};
		"MyAltice cd2bc9" = {
			#pskRaw="c8a5cb4402bf47e28724a4bc2bdc547f8a2ddcd65e459b2f1b4bb807b26aae2a";
			psk = "bronze-443-952";

		};
		"JetBlue Hotspot" = {
			auth=''
				key_mgmt=NONE
			''; 
		};
		"Everest" = {
			psk = "msniSP_12";
		};
		"HCL_Public" ={
		};

	};
  };  # Enables wireless support via wpa_supplicant.

   #Set your time zone.
  time.timeZone = "America/Chicago";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;
  #networking.networkmanager.enable = true; 
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
 #hardware.opengl = {
 #   enable = true;
 #   package = pkgs.mesa.drivers;
 #   driSupport32Bit = true;
 #   package32 = pkgs.pkgsi686Linux.mesa.drivers;
 # }; 
 # 

 hardware.opengl = {
    enable = true;
    #package = pkgs.mesa.drivers;
    extraPackages = with pkgs; [
        	amdvlk
	   rocm-opencl-icd
	   rocm-opencl-runtime
	];
    #driSupport32Bit = true;
    #package32 = pkgs.pkgsi686Linux.mesa.drivers;
  }; 

 #hardware.opengl.package = (import (pkgs.fetchzip {
 #     name = "old-nixpkgs";
 #     url = "https://github.com/NixOS/nixpkgs/archive/0a11634a29c1c9ffe7bfa08fc234fef2ee978dbb.tar.gz";
 #    sha256 = "0vj5k3djn1wlwabzff1kiiy3vs60qzzqgzjbaiwqxacbvlrci10y";
 #  }) {}).mesa.drivers;

services.dbus = {
	enable = true;
	packages = [];	
};
  # Enable the X11 windowing system.
 services.xserver.enable = true;

 services.xserver.windowManager = {
	xmonad.enable = true;
	xmonad.enableContribAndExtras = true;
	#xmonad.extraPackages = hkgs:  [
		#hpkgs.xmonad-contrib
		#hpkgs.xmonad-extras
		#hpkgs.xmonad
	#];
};

 services.xserver.videoDrivers = ["modesetting"];
#services.xserver.videoDrivers = [ "nouveau" "amdgpu" "radeon" "cirrus" "vesa" ];
 #services.xserver.videoDrivers = [ "amdgpu" ];
 services.xserver.useGlamor = true;  


 programs.adb.enable = true;
  services.udisks2.enable = true;
  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.satwik = {
    isNormalUser = true;
    extraGroups = [ "wheel"
		    "adbusers" 
		    "dialout"]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    wget
    firefox
   ];
programs.neovim.defaultEditor = true;

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 233 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 232 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };
  services.fwupd.enable=true;
nix = {
	package = pkgs.nixFlakes;
	extraOptions = ''
		experimental-features = nix-command flakes
		    keep-outputs = true
		    keep-derivations = true
	'';

};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "21.05"; # Did you read the comment?
  #

}

