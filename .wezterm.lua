local wezterm = require("wezterm")

wezterm.on('update-right-status', function(window, pane)

    local cwd = tostring(pane:get_current_working_dir())
    cwd = cwd:gsub("file://archlinux", "")
    cwd = cwd:gsub("/home/"..os.getenv("USER"), "~")
    cwd = " "..cwd.." 󰝰 "

    local hostname = wezterm.hostname()
    hostname = " "..hostname.." 󰣇 "

    local packages = "???"
    local handle = io.popen("pacman -Qq | wc -l")
    if handle then
        packages = handle:read("*a")
        packages = packages:gsub("\n", "")
        packages = " "..packages.." 󰏖 "
    end

    local uptime = "??:??"
    handle = io.popen("uptime -p")
    if handle then
        uptime = handle:read("*a")
        uptime = uptime:gsub("\n", "")
        uptime = uptime:gsub("up ", "")
        uptime = uptime:gsub(" hours, ", ":")
        uptime = uptime:gsub(" hour, ", ":")
        uptime = uptime:gsub(" minutes", "")
        uptime = uptime:gsub(" minute", "")
        uptime = " "..uptime.." 󰥔 "
    end

    local elements = {
        { Foreground = { Color = "#c6a0f6" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#c6a0f6" } },
        { Text = cwd },
        { Foreground = { Color = "#8aadf4" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#8aadf4" } },
        { Text = hostname },
        { Foreground = { Color = "#c6a0f6" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#c6a0f6" } },
        { Text = packages },
        { Foreground = { Color = "#8aadf4" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#8aadf4" } },
        { Text = uptime },
    }

    window:set_right_status(wezterm.format(elements))

end)

return {
    enable_wayland = false,
    window_background_opacity = 0.9,
    font = wezterm.font_with_fallback({ "CaskaydiaCove Nerd Font" }),
    font_size = 14,
    freetype_load_flags = "NO_HINTING",
    color_scheme = "Catppuccin Macchiato",
    window_close_confirmation = "NeverPrompt",
    use_fancy_tab_bar = false,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
    },
    colors = {
        tab_bar = {
            background = "#21222c",
            active_tab = { bg_color = "#c6a0f6", fg_color = "#000000" },
            inactive_tab = { bg_color = "#25074B", fg_color = "#c6a0f6" },
            inactive_tab_hover = { bg_color = "#25074B", fg_color = "#c6a0f6"},
            new_tab = { bg_color = "#25074B", fg_color = "#c6a0f6" },
            new_tab_hover = { bg_color = "#25074B", fg_color = "#c6a0f6" },
        },
    },
}

