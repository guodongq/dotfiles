require('window-picker').setup({
    -- Characters used to pick windows, in order of appearance.
    chars = "abcdefghijklmnopqrstuvwxyz",

    -- Background and text highlight groups.
    background_hl = "Normal",
    text_hl = "Bold",

    -- The border style to use for the floating window.
    border_style = "single",

    -- Floating window width/height.
    float_width = 11,
    float_height = 5,

    -- Whether or not to show letters in uppercase.
    show_uppercase = false,

    -- Just switch to the other window if only two are open.
    skip_if_two = true,
})
