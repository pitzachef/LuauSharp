local LuaSharp = {}

local function _f_compiler_loader(url)
    local success, result
    local attempts = 0
    local maxAttempts = 3
    
    repeat
        attempts += 1
        success, result = pcall(function()
            return game:HttpGetAsync(url, true)
        end)
        if not success then
            task.wait(1)
        end
    until success or attempts >= maxAttempts
    
    if not success then
        error("Failed to load dictionary: "..url)
    end
    
    return loadstring(result)()
end

LuaSharp._dluau = _f_compiler_loader("https://raw.githubusercontent.com/pitzachef/LuauSharp/refs/heads/main/compiler/_dluau.lua")
LuaSharp._dcluau = _f_compiler_loader("https://raw.githubusercontent.com/pitzachef/LuauSharp/refs/heads/main/compiler/_dcluau.lua")

function LuaSharp:_cluau(code)
    for pattern, replacement in pairs(self._dluau) do
        if pattern:find("%(") then
            code = code:gsub(pattern, replacement)
        else
            code = code:gsub(pattern, replacement)
        end
    end
    code = code:gsub(";", "\n")
    code = code:gsub("{", " then")
    code = code:gsub("}", " end")
    return code
end

function LuaSharp:_dcluau(code)
    for luau, cs in pairs(self._dcluau) do
        code = code:gsub(luau, cs)
    end
    code = code:gsub(" then", "{")
    code = code:gsub(" end", "}")
    return code
end

function LuaSharp:Run(csharpCode)
    local luauCode = self:_cluau(csharpCode)
    local fn, err = loadstring(luauCode)
    if not fn then return error("Compilation error: "..err) end
    return fn()
end

function LuaSharp:Import(modulePath)
    return require(game:GetService("ReplicatedStorage"):FindFirstChild(modulePath))
end

return LuaSharp
