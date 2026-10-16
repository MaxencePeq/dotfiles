-- Personal additions, loaded by plugins/init.lua when present (not part of craftzdog's repo).

vim.pack.add({
	{ src = gh("windwp/nvim-ts-autotag") },
	{ src = gh("kylechui/nvim-surround") },
})

-- Wrap/change/delete surrounding pairs: S in visual, ys/cs/ds in normal.
-- Aliases need no Alt on AZERTY: b = (), r = [], B = {}
require("nvim-surround").setup()

-- Auto close/rename JSX, HTML and Twig tags
require("nvim-ts-autotag").setup()

require("nvim-treesitter").install({ "twig", "dockerfile" })

-- PHP/Symfony, Twig, Python, YAML, HTML, JSON (cssls is already enabled in lsp.lua)
vim.lsp.enable({
	"phpactor",
	"twiggy_language_server",
	"pyright",
	"yamlls",
	"html",
	"jsonls",
})

-- Without a project config, php-cs-fixer writes .php-cs-fixer.dist.php and edits .gitignore
-- on its own; pass explicit rules then (same default as the VS Code/Cursor extension).
local conform = require("conform")
conform.formatters_by_ft.php = { "php_cs_fixer" }
conform.formatters.php_cs_fixer = {
	args = function(_, ctx)
		local config = vim.fs.find({ ".php-cs-fixer.dist.php", ".php-cs-fixer.php" }, { upward = true, path = ctx.dirname })
		if #config > 0 then
			return { "fix", "$FILENAME" }
		end
		return { "fix", "--rules=@PSR12", "--using-cache=no", "$FILENAME" }
	end,
}

-- conform also counts vite.config.* as an oxfmt config, so every Vite project got formatted by
-- oxfmt (line width 100) instead of its own Prettier. Only use oxfmt with a real oxfmt config.
-- Done on VimEnter because conform.setup() in editor.lua replaces formatters.oxfmt.
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		conform.formatters.oxfmt = {
			require_cwd = true,
			cwd = require("conform.util").root_file({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }),
		}
		-- No underlines under diagnostics, keep the message and the gutter sign (ui.lua turns them on)
		vim.diagnostic.config({ underline = false })
	end,
})

-- Install missing Mason tools on startup, like mason-tool-installer does for the base list
local mason_tools = {
	"phpactor",
	"twiggy-language-server",
	"pyright",
	"yaml-language-server",
	"html-lsp",
	"json-lsp",
	"css-lsp",
	"php-cs-fixer",
}
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		local registry = require("mason-registry")
		registry.refresh(function()
			for _, name in ipairs(mason_tools) do
				local ok, pkg = pcall(registry.get_package, name)
				if ok and not pkg:is_installed() and not pkg:is_installing() then
					pkg:install()
				end
			end
		end)
	end,
})

-- No macro recording: a stray q silently starts one, and blink.cmp turns completion off meanwhile.
-- Buffer-local q (Oil, pickers) still closes those windows.
vim.keymap.set({ "n", "x" }, "q", "<Nop>")

-- Prisma (.prisma schema files); LSP binary: :MasonInstall prisma-language-server
require("nvim-treesitter").install({ "prisma" })
vim.lsp.enable({ "prismals" })
