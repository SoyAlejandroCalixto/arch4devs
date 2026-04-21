local wezterm = require("wezterm")
return {
  enable_wayland = false,
  window_background_opacity = 0.9,
  font = wezterm.font_with_fallback({ "CaskaydiaCove Nerd Font" }),
  font_size = 14,
  freetype_load_flags = "NO_HINTING",
  color_scheme = "Catppuccin Macchiato",
  window_close_confirmation = "NeverPrompt",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
}

