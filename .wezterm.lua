local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({ "CaskaydiaCove Nerd Font" }),
	font_size = 12.0,
	color_scheme = "OneDark (base16)",
	hide_tab_bar_if_only_one_tab = true,
	window_close_confirmation = "NeverPrompt",
	enable_wayland = false
}
