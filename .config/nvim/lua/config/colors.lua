function ColorMyPencils(color)
    local success, err = pcall(function()
        vim.cmd.colorscheme(color)
    end)

    if not success then
        print(string.format("Color scheme '%s' not found: %s", color, err))
        print("Falling back to default")
        vim.cmd.colorscheme('default')
    end

    -- transparent background
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils('gruvbox')
