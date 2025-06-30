{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Install essential packages for LazyVim
    extraPackages = with pkgs; [
      # Essential tools
      git
      curl
      unzip
      gcc

      # Language servers
      lua-language-server
      nil # Nix language server

      # Tools
      ripgrep
      fd
    ];

    # Basic LazyVim configuration
    extraLuaConfig = ''
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = "a"
      vim.opt.clipboard = "unnamedplus"
      vim.g.mapleader = " "

      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      -- Minimal LazyVim setup
      require("lazy").setup({
        {
          "LazyVim/LazyVim",
          import = "lazyvim.plugins",
          opts = {
            colorscheme = "tokyonight",
          },
        },
      }, {
        defaults = {
          lazy = false,
          version = false,
        },
        install = { colorscheme = { "tokyonight" } },
        checker = { enabled = true },
      })
    '';
  };
}
