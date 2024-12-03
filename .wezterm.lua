local wezterm = require("wezterm")

return {
    enable_wayland = false,
    font = wezterm.font_with_fallback({ "CaskaydiaCove Nerd Font" }),
    font_size = 13.0,
    color_scheme = "OneDark (base16)",
    hide_tab_bar_if_only_one_tab = true,
    window_close_confirmation = "NeverPrompt",
    use_fancy_tab_bar = false,

    colors = {
        tab_bar = {
            background = "#282c34",
            active_tab = { bg_color = "#c679dc", fg_color = "#000000" },
            inactive_tab = { bg_color = "#301d36", fg_color = "#abb3be" },
            inactive_tab_hover = { bg_color = "#301d36", fg_color = "#abb3be"},
            new_tab = { bg_color = "#301d36", fg_color = "#808080" },
            new_tab_hover = { bg_color = "#301d36", fg_color = "#808080" },
        },
    }
}
