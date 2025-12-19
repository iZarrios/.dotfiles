require("config.dracula")

function ColorMyPencils(color)
    if color == 'dracula' then
        local drac = require("config.dracula")
        drac.Dracula()
    else
        vim.cmd.colorscheme(color)
    end

    -- -- transparent background
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- -- make floating windows transparent
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils('terafox')
