local _dluau = {
    -- Core
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
    
    -- Control
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
    
    -- System
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
    
    -- Error
    ["try"] = "local success, err = pcall(function()",
    ["catch"] = "end) if not success then",
    ["finally"] = "end",
    ["throw"] = "error",
    
    -- Class 
    ["get"] = "function %1:get%2() return self._%2 end",
    ["set"] = "function %1:set%2(value) self._%2 = value end",
    ["property"] = "function %1:get%2() return self._%2 end function %1:set%2(value) self._%2 = value end",
    
    -- patterns
    ["function(.-)%((.-)%)"] = "function %1(%2)",
    ["class(.-){"] = "local %1 = {} %1.__index = %1 function %1.new() local self = setmetatable({}, %1) return self end",
    ["=>"] = "function(%1) return %2 end"
}

return _dluau
