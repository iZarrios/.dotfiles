local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, opts)

vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("i", "kj", "<Esc>", opts)

-- highlight last highlighted block again
vim.keymap.set("n", "gV", "`[v`]")

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", opts)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "gd", "gdzz")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>x", "<cmd>:!chmod +x %<CR>")

-- go / golang err handling
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- Build utils
local build_file_path = "/tmp/build_cmd"

vim.keymap.set("n", "<leader>b", function()
  -- Read the content of the build file into a variable
  local command = vim.fn.readfile(build_file_path)
  local command_str = table.concat(command, " ")

  -- Execute the command and capture the output
  local output = vim.fn.systemlist(command_str)

  -- Create a new scratch buffer
  local bufnr = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer

  -- Set the buffer content to the command output
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)

  -- Open the buffer in a new window
  vim.cmd("silent split")
  vim.api.nvim_win_set_buf(0, bufnr) -- Set the buffer in the current window
  -- Resize the split window
  vim.cmd("resize 20")
end)


vim.keymap.set("n", "<leader>bs", function()
  -- Open a new vertical split window and edit the command file
  vim.cmd("silent split " .. build_file_path)
  -- Resize the split to make it smaller
  vim.cmd("resize 10")
end)
