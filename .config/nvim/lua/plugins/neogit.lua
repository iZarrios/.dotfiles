---@module 'lazy'
---@type LazySpec
return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
config = function()
  require("neogit").setup({
    kind = "split",
    -- Add this block right here:
    filewatcher = {
      enabled = true,
    },
    graph_style = "unicode",
    -- This is the setting you are looking for!
    side_by_side = true,

    integrations = {
      diffview = true
    },
    commit_editor = {
      kind = "split",
      show_staged_diff = true,
      staged_diff_split_kind = "split"
    }
  })
end,

  -- config = function()
  --   require("neogit").setup({
  --     kind = "split",   -- Opens the main Neogit buffer in a split
  --     integrations = {
  --       diffview = true -- Enables integration with diffview.nvim
  --     },
  --     commit_editor = {
  --       kind = "split",                  -- Shows the staged diff below the commit message
  --       show_staged_diff = true,
  --       staged_diff_split_kind = "split" -- Can be "split", "vsplit", or "auto"
  --     }
  --   })
  -- end,

  cmd = "Neogit",
  keys = {
    { "<leader>gg", function() require("neogit").open({ kind = "replace" }) end, desc = "Show Neogit UI Split" }
  },

};
