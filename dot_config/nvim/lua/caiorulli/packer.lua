vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = function()
		  local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
		  ts_update()
	  end,
  }

  use {
	  'dracula/vim', 
	  as = 'dracula',
	  config = function()
		  vim.cmd('colorscheme dracula')
	  end
  }

  use('tpope/vim-fugitive')

  use {
	  "folke/which-key.nvim",
	  config = function()
		  vim.o.timeout = true
		  vim.o.timeoutlen = 300
		  require("which-key").setup { }
	  end
  }

  -- for neotree
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  use {
	  "nvim-neo-tree/neo-tree.nvim",
	  branch = "v2.x",
	  requires = { 
		  "nvim-lua/plenary.nvim",
		  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		  "MunifTanjim/nui.nvim",
	  }
  }

end)
