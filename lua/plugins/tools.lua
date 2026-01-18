-- lua/plugins/tools.lua
return {
	-- Fuzzy Finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				mode = "n",
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				mode = "n",
				desc = "Live Grep",
			},
			{
				"<leader>fw",
				function()
					require("telescope.builtin").grep_string()
				end,
				mode = "n",
				desc = "Grep Word Under Cursor",
			},
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
			},
		},
	},

	-- Git integration
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>g", ":Neogit<CR>", mode = "n", desc = "Open Git window", silent = true },
		},
		opts = {
			-- kind = "split",
			integrations = {
				diffview = true,
				telescope = true,
			},
			signs = {
				section = { "󰅂", "󰅀" },
				item = { "󰅂", "󰅀" },
				hunk = { "󰪥", "󰪦" }, -- Keep hunks clean or use "󰪥", "󰪦"
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		keys = {
			{ "<leader>w", ":Gitsigns<CR>", mode = "n", desc = "Git minimal", silent = true },
		},
		config = function()
			require("gitsigns").setup({
				-- Custom git gutter signs
				-- signs = {
				-- 	add = { text = "▒" },
				-- 	change = { text = "█" },
				-- 	delete = { text = "▄" },
				-- 	topdelete = { text = "▀" },
				-- 	changedelete = { text = "█" }, -- ▒
				-- },
				sign_priority = 500,
			})

			vim.cmd([[
				highlight GitSignsAdd    guifg=#00ff00
			  highlight GitSignsChange guifg=#ffff00
			  highlight GitSignsDelete guifg=#ff0000
			]])
		end,
	},

	-- Auto-formatting (REPLACES ale and prettier autocmd)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				["_"] = { "trim_whitespace", "trim_newlines" },
				lua = { "stylua" },
				php = { "pint" },
				python = { "black" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				sh = { "shfmt" },
			},
			format_on_save = {
				timeout_ms = 5000,
				lsp_format = "fallback",
			},
		},
	},

	-- AI / Copilot

	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		build = "make",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"hrsh7th/nvim-cmp",
			"HakonHarnes/img-clip.nvim",
			{ "zbirenbaum/copilot.lua", opts = {} },
		},
		opts = {
			provider = "copilot",
			providers = {
				copilot = {
					endpoint = "https://api.githubcopilot.com",
					model = "gpt-4o-2024-11-20",
					timeout = 30000,
					context_window = 64000,
					use_response_api = function(opts)
						local model = opts and opts.model
						return type(model) == "string" and model:match("gpt%-5%-codex") ~= nil
					end,
					support_previous_response_id = false,
					extra_request_body = {
						max_tokens = 20480,
					},
				},
			},
		},
	},

	--Image
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			default = {
				embed_image_as_base64 = false,
				prompt_for_file_name = false,
				drag_and_drop = {
					insert_mode = true,
				},
				-- use_absolute_path = true, -- Required for Windows
			},
		},
	},

	-- Comments
	{ "numToStr/Comment.nvim", opts = {} },

	-- Auto Pairs
	{
		"saghen/blink.pairs",
		event = "InsertEnter",
		version = "*",
		dependencies = { "saghen/blink.download" },
		opts = {},
	},

	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},

	-- Color
	{
		"uga-rosa/ccc.nvim",
		event = "VeryLazy",
		keys = {
			{ "]c", ":CccPick<CR>", mode = "n", desc = "Color picker", silent = true },
		},
		opts = {
			bar_len = 40,
			preserve = true,
			lsp = true,
			recognize = {
				input = true,
				output = true,
			},
		},
	},

	-- Color highlighter
	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufReadPre",
		opts = {
			render = "background", -- Options: "background", "foreground", "virtual"
		},
	},

	{ "tpope/vim-sleuth" },

	{
		"olrtg/nvim-emmet",
		event = "InsertEnter",
		config = function()
			vim.keymap.set(
				{ "n", "v" },
				"<leader>xe",
				require("nvim-emmet").wrap_with_abbreviation,
				{ desc = "Emmet wrap with abbreviation" }
			)
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		opts = {
			file_types = { "markdown", "Avante" },
			completions = { lsp = { enabled = true } },
		},
		ft = { "markdown", "Avante" },
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern", -- classic, modern, helix
		},
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
