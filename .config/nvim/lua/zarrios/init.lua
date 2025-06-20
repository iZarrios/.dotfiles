require("zarrios.globals")
require("zarrios.remap")
require("zarrios.options")
require("zarrios.dracula")

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
