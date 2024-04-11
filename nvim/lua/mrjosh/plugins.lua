local vim = vim

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Github copilot plugin
  use 'github/copilot.vim'

  -- ColorSchemes
  use {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  }

  --use {
    --'romgrk/doom-one.vim',
    --config = function ()
      --vim.cmd('colorscheme doom-one')
    --end
  --}

  use 'sainnhe/edge'

  use 'shinchu/lightline-gruvbox.vim'
  use 'ryanoasis/vim-devicons'

  -- Colors
  use 'tjdevries/colorbuddy.nvim'
  use 'norcalli/nvim-colorizer.lua'

  use 'stephpy/vim-yaml'

  use {
    'kaicataldo/material.vim',
    branch = 'main',
  }

  use {
    'marko-cerovac/material.nvim',
    branch = 'main',
    run = ':colorscheme material',
  }

  use 'rhysd/git-messenger.vim'

  use 'preservim/nerdcommenter'

  -- telescopic johnson
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- nerdtree
  use 'scrooloose/nerdtree'

  -- use 'mkitt/tabline.vim'
  use 'tweekmonster/gofmt.vim'

  -- Tree-Shitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'nvim-treesitter/playground'

  use 'folke/persistence.nvim'

  use {
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
  }

  -- Auto completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- For vsnip users.
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- For luasnip users.
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  -- For ultisnips users.
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  -- For snippy users.
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'

  --use 'phaazon/hop.nvim'

  --use 'ThePrimeagen/harpoon'

  -- hcl (Hashicorp Config Language) syntax hightliting
  use 'b4b4r07/vim-hcl'

  use 'tpope/vim-fugitive'
  use 'TimUntersberger/neogit'

  -- Helm charts syntax hightliting
  use 'towolf/vim-helm'

  use 'itchyny/lightline.vim'

end)

