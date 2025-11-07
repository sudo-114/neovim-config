-- lua/plugins/ui.lua
---@class vim
return {
	-- Theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				-- Your tokyonight settings here
				transparant = true,
				terminql_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { bold = true },
					functions = { bold = true, italic = false },
					variables = { italic = true },
					sidebars = "dark",
					floats = "dark",
				},
				sidebars = { "qf", "help" }, -- Apply the "dark" style to sidebar-like windows
				day_brightness = 0.3, -- Adjusts the brightness of the colors on day style
				hide_inactive_statusline = false,
			})
			vim.cmd([[colorscheme tokyonight-storm]])
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
					theme = "auto",
					-- icons_enabled = true,

					select_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },

					disable_filetypes = { "neotree" },
					always_divide_middle = true,
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
					return " " .. str
					-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
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
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
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
		dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" },
		config = function()
			-- your bufferline config
			require("bufferline").setup({
				options = {
					path_components = 1, -- Show only file name
					show_tab_indicators = true,
					indicator = {
						style = "underline", -- options: 'icon' | 'underline' | 'none'
						-- icon = '▎', -- this should be omitted if indicator style is not 'icon'
					},

					custom_areas = {
						right = function()
							local clients = vim.lsp.get_clients()
							local lsp_names = {}

							for _, client in ipairs(clients) do
								table.insert(lsp_names, client.name)
							end
							return { { text = " " .. table.concat(lsp_names, ", "), fg = "#FF8800" } }
						end,
					},
				},
				highlights = {
					separator = {
						fg = "#434C5E",
					},
					buffer_selected = {
						bold = true,
						italic = false,
					},
				},
			})
		end,
	},

	{ "moll/vim-bbye" },

	-- File Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		config = function()
			-- your neo-tree config
			require("neo-tree").setup({
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				use_libuv_file_watcher = true,

				name = {
					highlight_opened_files = true,
				},

				git_status = {
					symbols = {
						-- Change type
						added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			})

			-- Keymap for neo-tree
			vim.keymap.set("n", "<leader>e", ":Neotree float toggle<CR>", { desc = "Toggle file explorer float" })
			vim.keymap.set("n", "<leader>l", ":Neotree toggle left<CR>", { desc = "Toggle file explorer left" })
		end,
	},

	{ "MunifTanjim/nui.nvim" },
	{ "nvim-lua/plenary.nvim" },

	-- Indent lines
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- UI improvements (Noice, Notify, Dressing)
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		config = function()
			-- Your noice config here
			vim.notify = require("notify")
			require("noice").setup({
				presets = {
					-- lsp_doc_border = true,
					command_palette = true,
					long_message_to_split = true,
					bottom_search = true,
					lsp_doc_border = true,
				},
			})
		end,
	},

	{ "MunifTanjim/nui.nvim" },

	{ "rcarriga/nvim-notify", config = true },

	{ "stevearc/dressing.nvim", opts = {} },

	{ "kyazdani42/nvim-web-devicons", config = true },
}
