local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set('n', keys, func, { buffer = bufnr })
	end

	bufmap('<leader>r', vim.lsp.buf.rename)
	bufmap('<leader>ca', vim.lsp.buf.code_action)

	bufmap('gd', vim.lsp.buf.definition)
	bufmap('<leader>gd', vim.lsp.buf.declaration)
	bufmap('<leader>gi', vim.lsp.buf.implementation)
	bufmap('gD', vim.lsp.buf.type_definition)

	bufmap('gr', require('telescope.builtin').lsp_references)
	bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
	bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

	bufmap('K', vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, {})

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		callback = function()
			vim.lsp.buf.format()
		end,
	})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


-- no mason
-- require('lspconfig').lua_ls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--     },
-- }

-- mason
require("mason").setup()
require("mason-lspconfig").setup_handlers({

	function(server_name)
		require("lspconfig")[server_name].setup {
			on_attach = on_attach,
			capabilities = capabilities
		}
	end,

	["lua_ls"] = function()
		require('neodev').setup()
		require('lspconfig').lua_ls.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			}
		}
	end

	-- another example
	-- ["omnisharp"] = function()
	--     require('lspconfig').omnisharp.setup {
	--         filetypes = { "cs", "vb" },
	--         root_dir = require('lspconfig').util.root_pattern("*.csproj", "*.sln"),
	--         on_attach = on_attach,
	--         capabilities = capabilities,
	--         enable_roslyn_analyzers = true,
	--         analyze_open_documents_only = true,
	--         enable_import_completion = true,
	--     }
	-- end,
})
