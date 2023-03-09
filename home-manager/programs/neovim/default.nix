pkgs:
let
  customPkgs = {
    opener = pkgs.vimUtils.buildVimPlugin {
      name = "Opener";
      src = pkgs.fetchFromGitHub {
        owner = "willthbill";
        repo = "opener.nvim";
        rev = "c2ec7ba6e6380a7837ab2d4dd3c6ec9b7fadbfd0";
        sha256 = "66R5vXZoEgJowqXpn/FAGFsj0XUvsZXzavThGaLz2OU=";
      };
      buildPhase = ''
      export PATH="/run/wrappers/bin:/home/satwik/.nix-profile/bin:/etc/profiles/per-user/satwik/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH"
      '';
    };


    neorg = pkgs.vimUtils.buildVimPlugin {
      name = "neorg";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-neorg";
        repo = "neorg";
        rev = "36bffcb37e0d9ae5bec069e13bea22840f1a5aa3";
        sha256 = "DwhgRYttUxTFSLoqSVIH/R6J/HqM3PGAiZNVhmxnTzA=";
      };
      buildPhase = ''
      export PATH="/run/wrappers/bin:/home/satwik/.nix-profile/bin:/etc/profiles/per-user/satwik/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH"
      '';
    };

    neorg-telescope = pkgs.vimUtils.buildVimPlugin  {
      name = "neorg-telescope";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-neorg";
        repo = "neorg-telescope";
        rev = "2d885550740f43c103678a68e93b80ff4e92c5cd";
        sha256 = "1kfiqkh3ibhcv3ibkmjpvkn88jsvmyh5wb5sbcifpsf4gnr5h6xb";
      };
      buildPhase = ''
      export PATH="/run/wrappers/bin:/home/satwik/.nix-profile/bin:/etc/profiles/per-user/satwik/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH"
      '';
    };

    null-ls = pkgs.vimUtils.buildVimPlugin {
      name = "null-ls";
      src = pkgs.fetchFromGitHub {
        owner = "jose-elias-alvarez";
        repo = "null-ls.nvim";
        rev = "868632e5839c876e99e8ba763261042131e073a7";
        sha256 = "oEUYRTY8C6nFuFnfxyBD0FrxpUh1jnQagZ77JK4jZkM=";
      };
      buildPhase = ''
      export PATH="/run/wrappers/bin:/home/satwik/.nix-profile/bin:/etc/profiles/per-user/satwik/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH"
      '';
    };

    nvim-dap-python = pkgs.vimUtils.buildVimPlugin {
      name = "nvim-dap-python";
      src = pkgs.fetchFromGitHub {
       owner = "mfussenegger";
        repo = "nvim-dap-python";
        rev = "d28ae6def103b5471384c48e2bc644a9db809827";
        sha256 = "ZFRklKo7AesSEfcwFRn265h+gVD1U4OhPd+///fv6m4=";
      };
      buildPhase = ''
      export PATH="/run/wrappers/bin:/home/satwik/.nix-profile/bin:/etc/profiles/per-user/satwik/bin:/nix/var/nix/profiles/default/bin:/#run/current-system/sw/bin:$PATH"
      '';
    };
  };
  customTS = {
     #tree-sitter-norg = (builtins.fromJSON (builtins.readFile ./tree-sitter-norg.json)); 
        tree-sitter-norga = {
          name="tree-sitter-norg";
          url = "https://github.com/nvim-neorg/tree-sitter-norg";
          rev = "665736e400cfd52ae92ead244ca9f5d44db98151";
          #date = "2021-10-14T12:18:22+02:00";
          #path = "/nix/store/4142dr4yy1jnbs7lf5kqmsn0rwyr1q7y-tree-sitter-norg";
          sha256 = "000J8q+p0IMKzBfKwDrcrN0jYqS/t1dMwUJmQNBSaKI=";
          #fetchLFS = false;
          #fetchSubmodules = false;
          #deepClone = false;
          #leaveDotGit = false;
      };
    };
  allpkgs = pkgs.vimPlugins // customPkgs;
  
  plugs =  plugins: with (plugins // customTS); [
          tree-sitter-nix
          tree-sitter-python
          tree-sitter-haskell
          tree-sitter-c
          tree-sitter-lua
          #tree-sitter-norg
         #({rev = "665736e400cfd52ae92ead244ca9f5d44db98151"; sha256 =  "0000kX77+C24OyiS9dLld7JBCLvnk1+1WtLGrUE7LfM=";} // tree-sitter-norg)
   ];
in {
	enable = true;
	extraConfig = builtins.readFile ./init.vim;
        withNodeJs = true;
	plugins = with allpkgs; [
                opener
                vim-ledger
                pear-tree
                nvim-dap
                nvim-dap-python
                plenary-nvim
                packer-nvim
                vim-nix
                onedark-vim
                neorg-telescope
                nvim-dap
                rust-tools-nvim
                nvim-treesitter
                #(nvim-treesitter.withPlugins plugs)
                #(nvim-treesitter.withPlugins(
                #    plugins: with (plugins); [
                #     tree-sitter-nix
                #      tree-sitter-python
                #     tree-sitter-haskell
                #      tree-sitter-c
                #     tree-sitter-lua
                #     #({rev = "995d7e0be4dc2a9655d2285405c0ef3fededf63c"; sha256 =  "0000000000000000000000000000000000000000000000000000000000000000";} // tree-sitter-norg)
                #   ]
                #  ))


                ultisnips
                neorg


                haskell-vim vim-hoogle

                nvim-lspconfig
                null-ls
                telescope-nvim


              nvim-cmp
                cmp-nvim-lsp
                cmp-nvim-lsp
                cmp_luasnip
              
              nvim-metals

              flutter-tools-nvim
	];
}
