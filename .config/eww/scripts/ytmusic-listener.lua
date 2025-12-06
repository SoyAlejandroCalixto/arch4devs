local lgi = require("lgi")
local GLib = lgi.GLib
local Playerctl = lgi.require("Playerctl", "2.0")

--- Extracts title, limits it to 30 characters and outputs it on stdout
local function emit_player_title(player)
    local title = player:get_title() or ""
    if title == "" then title = "..." end

    if #title > 30 then
        title = string.sub(title, 1, 30) .. "..."
    end

    io.write(title .. "\n")
    io.flush()
end

local mgr = Playerctl.PlayerManager()

mgr.on_name_appeared = function(manager, player_name)
    if player_name.name == "chromium" then
        local player = Playerctl.Player.new_from_name(player_name)
        if not player then
            return
        end

        emit_player_title(player)

        player.on_metadata = function(_, _) -- When the Spotify song changes...
            emit_player_title(player)
        end
    end
end

mgr.on_name_vanished = function(manager, player_name)
    if player_name.name == "chromium" then
        io.write("\n")
        io.flush()
    end
end

local loop = GLib.MainLoop()
loop:run()
