---@module 'lazy'
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  lazy = false,
  branch = "main",
  init = function()
    local ensureInstalled = {
      'lua', 'python', 'c', 'cpp',
      -- ... your parsers
    }
    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
    require('nvim-treesitter').install(parsersToInstall)
  end,
  config = function()
    require('nvim-treesitter').setup({
      ensure_installed = { "c", "lua", "comment", "python" },
      modules = {},
      ignore_install = {},
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_file_size = 250 * 1024 -- 250 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_file_size then
            return true
          end
        end,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    })
  end
}
