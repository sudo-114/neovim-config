-- lua/plugins/lsp.lua
local servers = {
	"intelephense",
	"eslint",
	"ts_ls",
	"cssls",
	"html",
	"pyright",
	"lua_ls",
	"tailwindcss",
	"bashls",
	"emmet_language_server",
	"copilot",
}

local parsers = {
	"php",
	"html",
	"css",
	"javascript",
	"typescript",
	"python",
	"cpp",
	"lua",
	"markdown",
	"markdown_inline",
	"bash",
	"vimdoc",
	"vim",
	"regex",
	"diff",
}

return {
	-- LSP Installer and Configurator
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,

					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									diagnostics = { globals = { "vim" } },
									workspace = { checkThirdParty = false },
									telemetry = { enabled = false },
								},
							},
						})
					end,
				},
			})
		end,
	},

	-- Autocompletion
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = { preset = "enter" },
			completion = {
				accept = { auto_brackets = { enabled = true } },
				keyword = { range = "full" },
				ghost_text = { enabled = true },
				documentation = {
					auto_show = true,
				},
				menu = { draw = { treesitter = { "lsp" } } },
			},
			sources = {
				default = { "lsp", "snippets", "buffer", "omni" },
			},
		},
	},

	-- Syntax Highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install(parsers)
			require("nvim-treesitter").setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
				},
			})
		end,
	},
}
