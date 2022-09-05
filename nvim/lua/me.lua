--vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]] 
--:vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.code_action(1)]]
--vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar =true 
vim.g.tokyonight_italic_functions = true

vim.g.tokyonight_colors = {hint = "orange", error = "#ff0000"}

vim.cmd [[colorscheme tokyonight]]

vim.api.nvim_set_keymap('n','<leader>u',':UndotreeToggle', {noremap = true})
vim.cmd [[autocmd BufWritePre * Neoformat]]

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client,bufnr)

	local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", opts)
	buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap("x","<A-j>", ":move '>+1<CR>gv-gv", opts)
    buf_set_keymap("x","<A-k>", ":move '<-2<CR>gv-gv", opts)



    vim.keymap.set("n","K",vim.lsp.buf.hover,{buffer=0})  
    vim.keymap.set("n","gd",vim.lsp.buf.definition,{buffer=0})
    vim.keymap.set("n","<leader>r",vim.lsp.buf.rename,{buffer=0})
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer=0})

--	if client.server_capabilities.document_formatting 
--	then
--		print("available")
--		vim.cmd([[
--			augroup formatting
--				autocmd! * <buffer>
--				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
--				autocmd BufWritePre <buffer> lua OrganizeImports(1000)
--			augroup END
--		]])
--	else
--		print("not available")
--	end

end


require'lspconfig'.gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach
}


require 'lspconfig'.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach
}






require'lspconfig'.pyright.setup{
    capabilities = capabilities,
}




















-- IGNORE? XD

-- set completeopt=menu,menuone,noselect
vim.opt.completeopt={"menu","menuone","noselect"}

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })
