{
  lib,
  config,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.nix-ld
    pkgs.ripgrep
  ];
  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.vimdiffAlias = true;
  programs.neovim.plugins = [
    pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  ];
  programs.neovim.extraPackages = [
    #pkgs.nodePackages_latest.vscode-json-languageserver
    pkgs.lua-language-server
    pkgs.nil
    pkgs.gopls
    pkgs.gcc

  ];
  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
  
}
