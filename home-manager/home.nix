{
  config,
  pkgs,
  options,
  neovim-flake,
  ...
}: let
  #customNeovim = import ./programs/neovim/default.nix;
  #my-python-packages = python-packages: with python-packages; [
  #pandas
  #numpy other python packages you want ];
  #python-with-my-packages = python3.withPackages my-python-packages;
  #pkgsUnstable = import <nixpkgs-unstable> {};
  customPylsp = pkgs.python39Packages.python-lsp-server.override {
    withAutopep8 = true;
    withFlake8 = true;
    withMccabe = true;
    withPycodestyle = true;
    withPydocstyle = true;
    withPyflakes = true;
    withPylint = true;
    withRope = true;
    withYapf = true;
  };
  #nixpkgs-overlays = builtins.fetchTarball "https://gitlab.com/api/v4/projects/zanc%2Foverlays/repository/archive.tar.gz?sha=master";
  #test = import (nixpkgs-overlays + "/overlays.nix");

  configModule = {
    # Add any custom options (and feel free to upstream them!)
    # options = ...
    config = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
        formatOnSave = true;
        lightbulb.enable = true;
        lspsaga.enable = false;
        nvimCodeActionMenu.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;
        nix = {
          enable = true;
          formatter = "alejandra";
        };
        rust.enable = true;
        python = true;
        clang.enable = true;
        sql = true;
        ts = true;
        go = false;
        zig.enable = false;
      };
      vim.visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
        lspkind.enable = true;
        indentBlankline = {
          enable = true;
          fillChar = "";
          eolChar = "";
          showCurrContext = true;
        };
        cursorWordline = {
          enable = true;
          lineTimeout = 0;
        };
      };
      vim.statusline.lualine = {
        enable = true;
        theme = "onedark";
      };
      vim.theme = {
        enable = true;
        name = "onedark";
        style = "darker";
      };
      vim.autopairs.enable = true;
      vim.autocomplete = {
        enable = true;
        type = "nvim-cmp";
      };
      vim.filetree.nvimTreeLua.enable = true;
      vim.tabline.nvimBufferline.enable = true;
      vim.treesitter = {
        enable = true;
        context.enable = true;
      };
      vim.keys = {
        enable = true;
        whichKey.enable = true;
      };
      vim.telescope = {
        enable = true;
      };
      vim.markdown = {
        enable = true;
        glow.enable = true;
      };
      vim.git = {
        enable = true;
        gitsigns.enable = true;
      };
    };
  };

  customNeovim = neovim-flake.lib.neovimConfiguration {
    modules = [configModule];
    inherit pkgs;
  };
in {
  # Let Home Manager install and manage itself.

  #nix.nixPath = options.nix.nixPath.default ++ [ "nixpkgs-overlays=${nixpkgs-overlays}/overlays.nix" ];
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
    userName = "purepani";
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
  home.packages = with pkgs;
    [
      openssl
      ranger
      arduino
      linuxConsoleTools
      rust-analyzer
      graphviz
      bash
      gcc
      nerdfonts
      restic
      ledger
      neovide
      audacity
      kgpg
      fd
      rclone
      unzip
    ]
    ++ [customNeovim.neovim]
  #programs.neovim = customNeovim.neovim;
  #programs.neovim.enable = true;
  #services.syncthing.enable = true;
  #        programs.bash.sessionVariables = {PATH = "$HOME/.nix-profile/bin";};

  #nixpkgs.overlays = [
  #  (import (builtins.fetchTarball {
  #    url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #  }))
  #          (self: super: { discord = super.discord.overrideAttrs (_: { src = builtins.fetchTarball <link-to-tarball>; });})

  #];

  imports = [
    #./programs/xmonad/default.nix
    #./programs/neovim/default.nix
  ];
  #nixpkgs.config = {
  #  allowUnfree = true;
  #};

  #xsession.enable = true;

  #xsession.windowManager.command = "…";
}
