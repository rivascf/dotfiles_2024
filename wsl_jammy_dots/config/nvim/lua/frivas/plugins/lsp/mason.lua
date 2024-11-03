return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				-- LSPs
				-- "tsserver",
				"bashls",
				"cmake",
				"html",
				"cssls",
				"tailwindcss",
				-- "svelte",
				"lua_ls",
				-- "hls", -- Haskell
				-- "julials" -- Julia
				-- "gopls"  -- GO
				-- "graphql",
				-- "emmet_ls",
				-- "prismals",
				"clangd",
				"yamlls",
				"jsonls",
				"pyright",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- Formatters
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				-- Linter
				"pylint",
				"eslint_d",
				-- "ruff_format",
			},
		})
	end,
}
