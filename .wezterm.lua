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
        { Foreground = { Color = "#c084fc" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#c084fc" } },
        { Text = cwd },
        { Foreground = { Color = "#60a5fa" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#60a5fa" } },
        { Text = hostname },
        { Foreground = { Color = "#c084fc" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#c084fc" } },
        { Text = packages },
        { Foreground = { Color = "#60a5fa" } },
        { Text = utf8.char(0xe0b2) },
        { Foreground = { Color = "#000000" } },
        { Background = { Color = "#60a5fa" } },
        { Text = uptime },
    }

    window:set_right_status(wezterm.format(elements))

end)

return {
    enable_wayland = false,
    window_background_opacity = 0.9,
    font = wezterm.font_with_fallback({ "CaskaydiaCove Nerd Font" }),
    font_size = 14,
    freetype_load_target = "Light",
    color_scheme = "Dracula (Official)",
    window_close_confirmation = "NeverPrompt",
    window_padding = {
        right = 0,
        left = 0,
        top = 0,
        bottom = 0,
    },
    use_fancy_tab_bar = false,
    colors = {
        tab_bar = {
            background = "#21222c",
            active_tab = { bg_color = "#c084fc", fg_color = "#000000" },
            inactive_tab = { bg_color = "#2e1065", fg_color = "#6273a5" },
            inactive_tab_hover = { bg_color = "#2e1065", fg_color = "#6273a5"},
            new_tab = { bg_color = "#2e1065", fg_color = "#6273a5" },
            new_tab_hover = { bg_color = "#2e1065", fg_color = "#6273a5" },
        },
    },
}

