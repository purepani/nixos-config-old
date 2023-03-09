{pkgs, ...}:
final: prev:
{
nvim-neorg = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-neog";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-neorg";
      repo = "neorg";
      rev = "unstable";
      sha256 = "sha256-PELLnW9/b7/vDuws0+6wKyhxZjExyCSIe5dzEUKLz5M=";
    };
    meta.homepage = "https://github.com/nvim-neorg/neorg/";
  };

}
