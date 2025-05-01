local LuaSharp = {}

LuaSharp._dluau = {
    -- Core types
    ["int"] = "number",
    ["float"] = "number",
    ["double"] = "number",
    ["string"] = "string",
    ["bool"] = "boolean",
    ["void"] = "nil",
    ["object"] = "any",
    
    -- Keywords
    ["public"] = "",
    ["private"] = "local",
    ["protected"] = "",
    ["static"] = "",
    ["class"] = "local %1 = {} %1.__index = %1 function %1.new() local self = setmetatable({}, %1) return self end",
    ["interface"] = "",
    ["namespace"] = "",
    ["using"] = "local %1 = require(game:GetService(\"ReplicatedStorage\").%1)",
    ["new"] = ".new",
    ["this"] = "self",
    ["base"] = "super",
    ["var"] = "local",
    ["const"] = "local",
    ["import"] = "local %1 = require",
    
    -- Operators
    ["=="] = "==",
    ["!="] = "~=",
    ["++"] = " += 1",
    ["--"] = " -= 1",
    ["+="] = "+=",
    ["-="] = "-=",
    ["*="] = "*=",
    ["/="] = "/=",
    ["%="] = "%=",
    ["&&"] = " and ",
    ["||"] = " or ",
    ["!"] = "not ",
    ["."] = ":",
    
    -- Control flow
    ["if"] = "if",
    ["else"] = "else",
    ["else if"] = "elseif",
    ["for"] = "for",
    ["while"] = "while",
    ["do"] = "do",
    ["switch"] = "if",
    ["case"] = "then",
    ["default"] = "else",
    ["break"] = "break",
    ["continue"] = "continue",
    ["return"] = "return",
    
    -- System functions
    ["Console.WriteLine"] = "print",
    ["Console.Write"] = "write",
    ["Console.ReadLine"] = "read",
    ["Math.Max"] = "math.max",
    ["Math.Min"] = "math.min",
    ["Math.Abs"] = "math.abs",
    ["Math.Round"] = "math.round",
    ["String.Format"] = "string.format",
    ["List"] = "table",
    ["Dictionary"] = "table",
    ["Array"] = "table",
    
    -- Error handling
    ["try"] = "local success, err = pcall(function()",
    ["catch"] = "end) if not success then",
    ["finally"] = "end",
    ["throw"] = "error",
    
    -- Class members
    ["get"] = "function %1:get%2() return self._%2 end",
    ["set"] = "function %1:set%2(value) self._%2 = value end",
    ["property"] = "function %1:get%2() return self._%2 end function %1:set%2(value) self._%2 = value end",
    
    -- Special patterns
    ["function(.-)%((.-)%)"] = "function %1(%2)",
    ["class(.-){"] = "local %1 = {} %1.__index = %1 function %1.new() local self = setmetatable({}, %1) return self end",
    ["=>"] = "function(%1) return %2 end"
}

LuaSharp._dcluau = {
    ["local"] = "var",
    ["function"] = "void",
    ["then"] = "{",
    ["end"] = "}",
    ["elseif"] = "else if",
    ["~="] = "!=",
    ["and"] = "&&",
    ["or"] = "||",
    ["not"] = "!",
    [":"] = ".",
    ["require"] = "using"
}

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
