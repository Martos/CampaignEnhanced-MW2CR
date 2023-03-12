cestats = {}

local basepath = "players2/default/"
local statsfilename = basepath .. "/ce_stats.json"

local defaultstats = {
    xp = 0,
    rank = 1,
    total_kill = 0,
    total_down = 0,
    total_assist = 0,
    total_shots = 0,
    total_game = 0
}

local function getstatsinternal()
    if (not io.fileexists(statsfilename)) then
        io.writefile(statsfilename, json.encode(defaultstats), false)
        return defaultstats
    end

    local stats = nil
    pcall(function()
        stats = json.decode(io.readfile(statsfilename))
    end, 0)

    return stats
end

local function getstats()
    local stats = getstatsinternal() or {}
    return stats
end

local function writestats(stats)
    io.writefile(statsfilename, json.encode(stats), false)
end

cestats.getstats = function(mapname)
    local stats = getstats()
    return stats
end

cestats.setstats = function(mapname, value)
    local stats = getstats()
    writestats(stats)
end

return cestats