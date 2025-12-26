---@module 'lazy'
---@type LazySpec
return {
  'mbbill/undotree',
  cmd = "UndotreeToggle",
  lazy = true,
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" }
  },
};
