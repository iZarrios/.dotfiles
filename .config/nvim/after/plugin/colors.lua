require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day",    -- The theme is used when the background is set to light
    transparent = false,    -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true, bold = false },
        keywords = { italic = false },
        functions = { italic = false },
        strings = { italic = false },
        variables = { italic = false },
        -- functions = {},
        -- variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",           -- style for sidebars, see below
        floats = "dark",             -- style for floating windows
    },
    sidebars = { "qf", "help" },     -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.8,            -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false,            -- dims inactive windows
    lualine_bold = false,            -- When `true`, section headers in the lualine theme will be bold
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    on_colors = function(colors)
    end,
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    on_highlights = function(highlights, colors)
    end,
})

require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    background = {         -- :h background
        light = "latte",
        dark = "macchiato",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = true,      -- shows the '~' characters after the end of buffers
    term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false,            -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15,          -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,              -- Force no italic
    no_bold = false,                -- Force no bold
    no_underline = false,           -- Force no underline
    styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" },    -- Change the style of comments
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        telescope = {
            enabled = true,
        },
        fidget = true,
        harpoon = true,
        treesitter_context = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

require("gruvbox").setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = false,
    italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,    -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
})



function ColorMyPencils(color)
    if color == 'dracula' then
        local drac = require("zarrios.dracula")
        drac.Dracula()
    else
        vim.cmd.colorscheme(color)
    end

    -- -- transparent background
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- -- make floating windows transparent
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils('dracula')
