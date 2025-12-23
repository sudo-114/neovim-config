-- lua/plugins/lsp.lua
return {
	-- LSP Manager
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- LSP Installer and Configurator
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- List of servers to install
			local servers = {
				"intelephense", -- for PHP
				"eslint", -- for TypeScript/JavaScript
				"ts_ls", -- for TypeScript/JavaScript
				"cssls", -- for CSS
				"html", -- for HTML
				"pyright", -- for Python
				"clangd", -- for C/C++
				"lua_ls", -- for Lua
				"tailwindcss", -- for Tailwindcss
				"somesass_ls", -- for SCSS
				"bashls", -- for Bash
			}

			require("mason-lspconfig").setup({
				ensure_installed = servers,
				handlers = {
					function(server_name) -- Default handler
						lspconfig[server_name].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
					-- You can add custom settings for specific servers here
					lua_ls = function()
						lspconfig.lua_ls.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							settings = {
								Lua = { diagnostics = { globals = { "vim" } } },
							},
						})
					end,
				},
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind-nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})
		end,
	},

	-- Syntax Highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
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
					"scss",
					"bash",
				},
				highlight = { enable = true },
				indent = { enable = true },
				autopairs = { enable = true },
			})
		end,
	},

	-- Auto-closing tags for HTML/XML
	{ "windwp/nvim-ts-autotag", config = true },
}
