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
  #programs.neovim.plugins = [];
  programs.neovim.extraPackages = with pkgs; [
    #deps
    wl-clipboard
    gcc
    tree-sitter
    nodejs-slim
    codeium
    gzip
    lazygit
  
    #javascript/typescript
    nodePackages_latest.typescript-language-server
    prettierd
    nodePackages.prettier
    
    #python
    pyright
    black
    isort

    #nix 
    nil
    nixfmt-rfc-style

    # lua
    lua-language-server
    stylua

    # codespell    
    codespell

    # C/C++
    clang-tools
    
    
  ];
  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };

}
