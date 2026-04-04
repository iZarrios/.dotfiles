vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", function()
  return require("undotree").open({
    command = "topleft 30vnew",
  })
end)
