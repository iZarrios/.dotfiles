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

local mode = {
  "mode",
  fmt = function(str)
    return "--" .. str .. "--"
  end,
  padding = 1,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
  padding = 1,
}

local branch = {
  "branch",
  icons_enabled = false,
  icon = nil,
  padding = 1,
}

local location = {
  "location",
  padding = 1,
}



require('lualine').setup({
  options = {
    theme = 'catppuccin',
    icons_enabled = false,
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "|", right = "|" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch, diagnostics },
    lualine_b = { mode, "filename" },
    lualine_c = {},
    lualine_x = { "encoding", diff, filetype, location },
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
