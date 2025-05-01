local _dluau = {
    -- Types
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
    ["class"] = "",
    ["interface"] = "",
    ["namespace"] = "",
    ["using"] = "local",
    ["new"] = ".new",
    ["this"] = "self",
    ["base"] = "super",
    ["var"] = "local",
    ["const"] = "local",
    ["null"] = "nil",

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
    ["::"] = ".",
    ["=>"] = "function(%1) return %2 end",

    -- Flow Control
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

    -- Roblox
    ["game:GetService"] = "game.GetService",
    ["Console.WriteLine"] = "print",
    ["Console.Write"] = "write",
    ["Console.ReadLine"] = "read",
    [".Kick"] = ":Kick",
    [".Health"] = ".Health",

    -- Classes/Methods
    ["function(.-)%((.-)%)"] = "function %1(%2)",
    ["class(.-){"] = "local %1 = {} %1.__index = %1 function %1.new() local self = setmetatable({}, %1) return self end",
    ["this."] = "self.",
    ["new "] = "",

    -- Syntax
    [";"] = "",
    ["{"] = "then",
    ["}"] = "end",
    ["//"] = "--",
    ["/*"] = "--[[",
    ["*/"] = "]]",

    -- Collections
    ["List<"] = "{",
    [">"] = "}",
    ["Dictionary<"] = "{",
    ["Array<"] = "{",
    ["Add("] = "table.insert(",
    ["Remove("] = "table.remove("
}

return _dluau
