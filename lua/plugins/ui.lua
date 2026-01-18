-- lua/plugins/ui.lua
---@class vim

-- Standard UI tweaks: Diagnostics
vim.diagnostic.config({
	signs = {
		priority = 10,
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	-- Optional: make it even cleaner
	virtual_text = true, -- Shows the error message next to the code
	underline = true, -- Underlines the actual error
	severity_sort = true, -- Important: puts errors at the top of the list
})

return {
	-- Theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				-- transparent = true,
				styles = {
					keywords = { bold = true },
					functions = { bold = true, italic = false },
					variables = { italic = true },
				},
			})
			vim.cmd([[colorscheme tokyonight-night]]) -- Night, storm, day
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local colors = require("tokyonight.colors")

			local config = {
				options = {
					theme = "tokyonight",

					select_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },

					disable_filetypes = { "neotree" },
				},

				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},

				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},

				tabline = {},
				extensions = { "fugitive" },
			}

			local conditions = {
				hide_in_width = function()
					return vim.fn.winwidth(0) > 50
				end,
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
				end,
			}

			local function insert_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			local function insert_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			insert_left({
				"mode",
				fmt = function(str)
					return "  " .. str
					-- return '  ' .. str:sub(1, 1) -- displays only the first character of the mode
				end,
			})

			insert_left({
				"branch",
				icon = "",
				color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
			})

			insert_left({
				"diff",
				symbols = { added = " ", modified = " ", removed = " " },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			})

			insert_left({
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = "✘ ", warn = " ", info = " ", hint = " " },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
			})

			insert_left({
				function()
					return "%="
				end,
			})

			insert_right({
				"filetype",
			})

			insert_right({
				"encoding",
			})

			insert_right({
				"location",
				color = { fg = colors.fg_dark },
				cond = conditions.buffer_not_empty,
			})

			require("lualine").setup(config)
		end,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" },
		opts = {
			options = {
				indicator = {
					style = "underline",
				},
				themable = true,
				diagnostics = "nvim_lsp",

				diagnostics_indicator = function(count, _, diagnostics_dict, context)
					-- Hide for the current active buffer
					if context.buffer:current() then
						return ""
					end

					-- Prioritize the icon: Error first, then Warning, then Info
					local icon = " " -- Default info icon
					if diagnostics_dict.error then
						icon = "✘ "
					elseif diagnostics_dict.warning then
						icon = " "
					end

					return " " .. count .. icon
				end,

				-- Shows active LSP
				-- custom_areas = {
				-- 	right = function()
				-- 		local clients = vim.lsp.get_clients()
				-- 		local lsp_names = {}
				--
				-- 		for _, client in ipairs(clients) do
				-- 			table.insert(lsp_names, client.name)
				-- 		end
				-- 		return { { text = " " .. table.concat(lsp_names, ", "), fg = "#FF8800" } }
				-- 	end,
				-- },
			},
			highlights = {
				buffer_selected = {
					bold = true,
					italic = false,
				},
			},
		},
	},

	-- File Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"folke/snacks.nvim",
		},
		keys = {
			{
				"<leader>e",
				":Neotree float toggle<CR>",
				mode = "n",
				desc = "Toggle file explorer float",
				silent = true,
			},
			{ "<leader>l", ":Neotree toggle left<CR>", mode = "n", desc = "Toggle file explorer left", silent = true },
		},
		opts = {
			popup_border_style = "rounded",
			use_libuv_file_watcher = true,

			name = {
				highlight_opened_files = true,
			},

			default_component_configs = {
				icon = {
					default = "",
				},
				diagnostics = {
					symbols = {
						hint = "",
						info = "",
						error = "✘",
						warn = "",
					},
					highlights = {
						hint = "DiagnosticSignHint",
						info = "DiagnosticSignInfo",
						warn = "DiagnosticSignWarn",
						error = "DiagnosticSignError",
					},
				},
			},
		},
	},

	-- Indent lines
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- UI improvements (Noice, Notify, Dressing)
	{
		"folke/noice.nvim",
		lazy = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
			{ "rcarriga/nvim-notify", opts = {} },
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				lsp_doc_border = true,
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
	},

	{ "stevearc/dressing.nvim", opts = {} },

	{
		"nvimdev/lspsaga.nvim",
		keys = {
			{ "K", "<Cmd>Lspsaga hover_doc<CR>", mode = "n", silent = true },
			{ "gd", "<Cmd>Lspsaga lsp_finder<CR>", mode = "n", silent = true },
			{ "gD", "<Cmd>Lspsaga peek_definition<CR>", mode = "n", silent = true },
			{ "<leader>rn", "<Cmd>Lspsaga rename<CR>", mode = "n", silent = true },
			{ "<leader>ac", "<Cmd>Lspsaga code_action<CR>", mode = "n", desc = "Code action", silent = true },
			{ "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", mode = "n", silent = true },
			{ "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", mode = "n", silent = true },
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			ui = {
				code_action = "💡",
				rename = "✏️",
				definition = "🔍",
				hover = "📝",
			},
			symbol_in_winbar = { enable = false },
		},
	},

	-- Breadcrumbs
	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			local map = vim.keymap.set
			map("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			map("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			map("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
}
