return {
	"nvim-lua/plenary.nvim",

	{
		"nvchad/base46",
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	{
		"nvchad/ui",
		lazy = false,
		config = function()
			require("nvchad")
		end,
	},

	"nvzone/volt",
	"nvzone/menu",

	{ "nvzone/minty", cmd = { "Huefy", "Shades" } },

	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")
			return { override = require("nvchad.icons.devicons") }
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "blankline")

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)

			dofile(vim.g.base46_cache .. "blankline")
		end,
	},

	-- file managing , picker etc
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			return require("configs.nvimtree")
		end,
	},

	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		opts = function()
			dofile(vim.g.base46_cache .. "whichkey")
			return {}
		end,
	},

	-- formatting!
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				python = { "isort", "black" },
				nix = { "nixfmt" },
				lua = { "stylua" },
				c = { "clang-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				["*"] = { "codespell" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},

	-- git stuff
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = function()
			return require("configs.gitsigns")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Telescope",
		opts = function()
			return require("configs.telescope")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					require("configs.luasnip")
				end,
			},

			-- autopairing of (){}[] etc
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					-- setup cmp for autopairs
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},

			-- cmp sources plugins
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},
		opts = function()
			return require("configs.cmp")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.pyright.setup({})
			lspconfig.nil_ls.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.clangd.setup({})
			lspconfig.ts_ls.setup({})
		end,
	},

	"yetone/avante.nvim",
	  event = "VeryLazy",
	  lazy = false,
	  version = false, -- set this if you want to always pull the latest change
	  opts = function()
			return require("configs.avante")
	  end,
	  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	  build = "make",
	  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	  dependencies = {
	    "stevearc/dressing.nvim",
	    "nvim-lua/plenary.nvim",
	    "MunifTanjim/nui.nvim",
	    --- The below dependencies are optional,
	    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
	    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	    "zbirenbaum/copilot.lua", -- for providers='copilot'
	    {
	      -- support for image pasting
	      "HakonHarnes/img-clip.nvim",
	      event = "VeryLazy",
	      opts = {
		-- recommended settings
		default = {
		  embed_image_as_base64 = false,
		  prompt_for_file_name = false,
		  drag_and_drop = {
		    insert_mode = true,
		  },
		  -- required for Windows users
		  use_absolute_path = true,
		},
	      },
	    },
	    {
	      -- Make sure to set this up properly if you have lazy=true
	      'MeanderingProgrammer/render-markdown.nvim',
	      opts = {
		file_types = { "markdown", "Avante" },
	      },
	      ft = { "markdown", "Avante" },
	    },
	  },
}
