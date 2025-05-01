# Luau#

C# in luau (kinda)

## Documentation
Still being made..

## Installation
If you are on Roblox Studio:

1. Place the module in ReplicatedStorage
2. Require it in your scripts

If you are on an exploit enviornment:

1. Loadstring the script
```lua 
local compiler = loadstring(game:HttpGet("https://raw.githubusercontent.com/pitzachef/LuauSharp/main/compiler.lua"))()
```

2. Compile your script
```lua
local compiler = loadstring(game:HttpGet("https://raw.githubusercontent.com/pitzachef/LuauSharp/main/compiler.lua"))()

local csCode = [[
using ReplicatedStorage;
import Players;

public class Program {
    public static void Main() {
        Console.WriteLine("Hello Luau#!");
        var player = Players.LocalPlayer;
        var numbers = new List<int>();
        numbers.Add(5);
        if (player != null) {
            Console.WriteLine("Player exists!");
        }
    }

	Main()
}
]]
loadstring(compiler(csCode))()
```
