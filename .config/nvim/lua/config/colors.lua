function ColorMyPencils(color)
    vim.cmd.colorscheme(color)

    -- -- transparent background
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- -- make floating windows transparent
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils('terafox')
