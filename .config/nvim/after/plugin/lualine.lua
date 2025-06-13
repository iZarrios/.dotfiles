local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = "✖  ", warn = "⚠  " },

  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = true,
  symbols = { added = "+", modified = "~", removed = "-" }, -- changes diff symbols
  cond = hide_in_width
}

local filename = {
    "filename",
    file_status = true,      -- Displays file status (readonly status, modified status)
    newfile_status = true,  -- Display new file status (new file means no write after created)
    path = 4,                -- 0: Just the filename
                             -- 1: Relative path
                             -- 2: Absolute path
                             -- 3: Absolute path, with tilde as the home directory
                             -- 4: Filename and parent dir, with tilde as the home directory

    shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
    symbols = {
      modified = '[+]',      -- Text to show when the file is modified.
      readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
      unnamed = '[No Name]', -- Text to show for unnamed buffers.
      newfile = '[New]',     -- Text to show for newly created file before first write
    }
 }

local mode = {
  "mode",
  fmt = function(str)
    return "--" .. str .. "--"
  end,
  padding = 1,
}

local filetype = {
  "filetype",
  icons_enabled = true,
  icon = nil,
  padding = 1,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = nil,
  padding = 1,
}

local location = {
  "location",
  padding = 1,
}



require('lualine').setup({
  options = {
    theme = 'dracula',
    icons_enabled = false,
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "|", right = "|" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch, diagnostics },
    lualine_b = { mode, filename },
    lualine_c = {},
    lualine_x = { "encoding", diff, filetype, location },
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { location },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
