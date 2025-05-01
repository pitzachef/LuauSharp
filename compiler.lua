local version = "1.2.2"
local compiler = {}
warn("LuauSharp::"..version.." Loaded")
function compiler:_f__compile_luau(cs)
    local lines = {}
    for line in cs:gmatch("([^\n]*)\n?") do
        table.insert(lines, line)
    end

    local output = {}
    local inClass = false
    local inMethod = false
    local indentLevel = 0

    local function addLine(code)
        table.insert(output, string.rep("    ", indentLevel) .. code)
    end

    for _, line in ipairs(lines) do
        local trimmed = line:match("^%s*(.-)%s*$")

        if #trimmed > 0 then

            if trimmed:match("^using") then
                local lib = trimmed:match("using%s+(%S+)%s*;?;")
                addLine("local "..lib.." = require(game:GetService('"..lib.."'))")
            elseif trimmed:match("^import") then
                local service = trimmed:match("import%s+(%w+)%s*;?")
                addLine("local "..service.." = game:GetService('"..service.."')")

            elseif trimmed:match("^public%s+class") then
                local className = trimmed:match("public%s+class%s+(%w+)")
                addLine("local "..className.." = {}")
                inClass = true
                indentLevel = indentLevel + 1

            elseif trimmed:match("public%s+static%s+void") then
                local methodName = trimmed:match("public%s+static%s+void%s+(%w+)%s*%(%s*%)")
                addLine("function "..methodName.."()")
                inMethod = true
                indentLevel = indentLevel + 1
            elseif trimmed:match("Console%.WriteLine") then
                local content = trimmed:match("Console%.WriteLine%((.-)%)%s*;?")
                addLine("print("..content..")")
			elseif trimmed:match("^[%w]+%s+[%w]+") then

    			local decl = trimmed:gsub("^(%w+)%s+(%w+)(.*)", function(type, name, rest)
       			rest = rest:gsub("new%s+List<%w*>%(%s*%)", "{}")
        		if type == "int" or type == "float" then type = "number" end
       			return string.format("local %s%s", name, rest)
            end)

    		addLine(decl:gsub(";", ""))

            elseif trimmed:match("%.Add%(") then
                local var, value = trimmed:match("(%w+)%.Add%((.-)%)%s*;?")
                addLine(var.."[#"..var.."+1] = "..value)

            elseif trimmed:match("^if%s*%(") then
                local condition = trimmed:match("if%s*%((.-)%)")
                condition = condition:gsub("!=", "~=")
                condition = condition:gsub("null", "nil")
                addLine("if "..condition.." then")
                if trimmed:match("{") then
                    indentLevel = indentLevel + 1
                end

            elseif trimmed:match("^}") then
                indentLevel = math.max(0, indentLevel - 1)
                if inMethod then
                    inMethod = false
                    addLine("end")
                elseif inClass then
                    inClass = false
                    addLine("end")
                end

            else
                addLine(trimmed)
            end
        end
    end

    return table.concat(output, "\n")
end


return compiler