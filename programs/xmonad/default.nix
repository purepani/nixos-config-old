{
  xsession = {
    enable = true;

    #initExtra = polybarOpts;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
        hp.xmonad-contrib
	hp.xmonad-wallpaper
	hp.xmonad-utils
      ];
      config = ./xmonad.hs;
    };
  };
}
