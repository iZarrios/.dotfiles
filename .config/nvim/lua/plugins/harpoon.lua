return {
    'ThePrimeagen/harpoon',
    -- branch = "harpoon2",
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    lazy = false,
    opts = {},
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")


        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

        -- I think mapping more than 2 files is a bit extreme for now?
        vim.keymap.set("n", "<A-1>", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<A-2>", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<A-3>", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<A-4>", function() ui.nav_file(4) end)
    end
};
