local function execute_command(cmd)
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return result:gsub("%s+$", "")
end

local function parse_workspace_to_number(json_str)
    local id = json_str:match('"id":%s*(%d+)')
    return tonumber(id)
end

--- Return a table with the IDs of the occupied workspaces
local function parse_workspaces(json_str)
    local occupied = {}
    for id in json_str:gmatch('"id":%s*(%d+)') do
        occupied[tonumber(id)] = true
    end
    return occupied
end

--- Get current workspaces state
local function get_workspaces()
    local active_ws_json = execute_command("hyprctl activeworkspace -j")
    local active_ws = parse_workspace_to_number(active_ws_json)
    
    local occupied_json = execute_command("hyprctl workspaces -j")
    local occupied = parse_workspaces(occupied_json)
    
    local workspaces = {}
    for i = 1, 10 do
        local is_active = (i == active_ws) and "true" or "false"
        local is_occupied = occupied[i] and "true" or "false"
        table.insert(workspaces, string.format(
            '{"id":%d,"active":%s,"occupied":%s}', 
            i, is_active, is_occupied
        ))
    end
    
    return '{"workspaces":[' .. table.concat(workspaces, ",") .. ']}'
end

local function main()
    print(get_workspaces()) -- Print initial state
    
    -- Use socat to listen to events
    local socket_path = 
        "$XDG_RUNTIME_DIR/hypr/" .. 
        os.getenv("HYPRLAND_INSTANCE_SIGNATURE") .. 
        "/.socket2.sock"
    local cmd = "socat -U - UNIX-CONNECT:" .. socket_path
    
    local handle = io.popen(cmd, "r")
    if not handle then
        print("Error: No se pudo conectar al socket de Hyprland")
        return
    end
    
    -- Events to listen
    for line in handle:lines() do
        if line:match("^workspace") or 
           line:match("^createworkspace") or 
           line:match("^destroyworkspace") or
           line:match("^focusedmon") or
           line:match("^focusedmonv2") or
           line:match("^moveworkspace") or
           line:match("^moveworkspacev2") then
            print(get_workspaces())
        end
    end

    handle:close()
end

main()
