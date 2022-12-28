require('maximizer').setup({
    status = {
        enable = false, -- nil or false to disable
        -- text = "Maximizer is active!",
        text = "Maximizer",
        blend = 10,
        position = {
            top = true,
            left = false,
        },
    },
    -- toggle keymap
    keymap = {
        enable = true, -- nil or false to disable
        modes = { "i", "n" },
        rhs = "<leader>wm"
    }
})