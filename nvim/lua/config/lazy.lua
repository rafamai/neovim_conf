require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  --colorscheme

  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
	-- Barra inferior
	{'nvim-lualine/lualine.nvim'},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{'lewis6991/gitsigns.nvim'},
	{'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
	}
	
})
