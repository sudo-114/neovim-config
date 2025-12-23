-- lua/plugins/tools.lua
return {
	-- Fuzzy Finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep", "sharkdp/fd" },
		config = function()
			require("telescope").setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					path_display = { "smart" },
				},
			})
			-- Keymaps for Telescope
			local map = vim.keymap.set
			local builtin = require("telescope.builtin")
			map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		end,
	},

	{ "BurntSushi/ripgrep" },

	{ "sharkdp/fd" },

	-- Git integration
	{ "tpope/vim-fugitive",
		config = function()
			-- Optional configuration can go here
			vim.api.nvim_set_keymap("n", "<leader>gs", ":Gstatus<CR>", { noremap = true, silent = true })
		end
	},

	{ "lewis6991/gitsigns.nvim", opts = {} },

	-- Auto-formatting (REPLACES ale and prettier autocmd)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				php = { "pint", "phpcbf" }, -- Will try pint first, then phpcbf
				python = { "isort", "black" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				bash = { "shfmt" }
			},
			format_on_save = {
				timeout_ms = 5000,
				lsp_fallback = true,
			},
		},
	},

	-- AI / Copilot
	{ "github/copilot.vim" },

	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		build = "make tiktoken",
		opts = {
			-- See Configuration section for options
			window = {
				layout = "float",
				width = 80, -- Fixed width in columns
				height = 20, -- Fixed height in rows
				border = "rounded", -- 'single', 'double', 'rounded', 'solid'
				title = "🤖 Github Copilot | AI Assistant",
				zindex = 100, -- Ensure window stays on top
			},

			headers = {
				user = "👤 You ",
				assistant = "🤖 Copilot",
				tool = "🔧 Tool",
			},

			separator = "━━",
			auto_fold = true, -- Automatically folds non-assistant messages
		},
	},

	-- Comments
	{ "numToStr/Comment.nvim", opts = {} },

	-- Auto Pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
				},
			})
			-- If you want to integrate with nvim-cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Color
	{
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup({
				user_default_options = {
					border = "rounded", -- Border style for the color picker
					format = "hex", -- Color format (hex, rgb, hsl)
					show_color_name = true, -- Show color name
				},
				window = {
					win_opts = {
						winblend = 0, -- Transparency level for the color picker window
						height = 20, -- Height of the color picker window
						width = 40, -- Width of the color picker window
					},
				},
			})
		end,
	},

	-- Color highlighter
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				render = "virtual", -- Options: "background", "foreground", "virtual"
			})
		end,
	},

	{ "tpope/vim-sleuth" },

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("lspsaga").setup({
				ui = {
					theme = "round",
					border = "rounded",
					title = true,
					code_action = "💡",
					rename = "✏️",
					definition = "🔍",
					hover = "📝",
				},
				symbol_in_winbar = {
					enable = true,
					separator = " > ",
					show_file = true,
				},
			})
		-- Helper function to map keys

		local opts = { noremap = true, silent = true }
		local map = vim.keymap.set

		-- Keymaps for lspsaga features
		map('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
		map('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
		map('n', 'gD', '<Cmd>Lspsaga peek_definition<CR>', opts)
		map('n', '<leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
		map('n', '<leader>a', '<Cmd>Lspsaga code_action<CR>', opts)
		map('n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
		map('n', ']d', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
		-- For jumping inside a floating window (if it is focused)
		-- Note: These are often built-in to the lspsaga windows
		-- but can be explicitly mapped if needed.
		map('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
		map('n', '<C-k>', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
		
		end,
	},

	{ "mattn/emmet-vim", ft = { "html", "css", "javascript", "typescript", "php" } },

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},

	{
		"folke/which-key.nvim", event='VeryLazy', opts = {}
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
