level.lua = array:new()
level.luaret = nil

local function createfunction(func)
    return function(ent, ...)
        level.luaret = func(...)
    end
end

level.lua["so_create_hud_item"] = createfunction(createhuditem)