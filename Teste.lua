-- carregar biblioteca
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

--aviso ao executar
Fluent:Notify({
        Title = "executed successfully",
        Content = "the script loaded successfully ",
        SubContent = "my main roblox account name miguel_indo4", -- Optional
        Duration = 10 -- Set to nil to make the notification not disappear
    })

local Window = Fluent:CreateWindow({
    Title = "nexux hub" .. Fluent.Version,
    TabWidth = 160, 
    Size = UDim2.fromOffset(580, 460),
    SubTitle = "by miguel_indo4",
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Auto win Worlds", Icon = "trophy" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- parágrafos 
Tabs.Main:AddParagraph({ Title = "Run star Simulator", Content = "you need to have the world unlocked to work " })

--botões 
Tabs.Main:AddButton({ Title = "Auto win world 1", Callback = function()
_G.loop = true while _G.loop do
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RacePrepare"):InvokeServer()
wait()
local args = {
    0.5699999999998866
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceEnd"):InvokeServer(unpack(args))
wait()
local args = {
    true,
    1,
    1
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceReward"):FireServer(unpack(args))
wait()
end
end })
Tabs.Main:AddButton({ Title = "Auto win world 2", Callback = function()
_G.loop = true while _G.loop do
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RacePrepare"):InvokeServer()
wait()
local args = {
    0.5699999999998866
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceEnd"):InvokeServer(unpack(args))
wait()
local args = {
    true,
    2,
    2
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceReward"):FireServer(unpack(args))
wait()
end
end })
Tabs.Main:AddButton({ Title = "Auto win world 3", Callback = function()
_G.loop = true while _G.loop do
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RacePrepare"):InvokeServer()
wait()
local args = {
    0.5699999999998866
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceEnd"):InvokeServer(unpack(args))
wait()
local args = {
    true,
    3,
    3
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceReward"):FireServer(unpack(args))
wait()
end
end })
Tabs.Main:AddButton({ Title = "Disable Auto win", Callback = function()
_G.loop = false while _G.loop do
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RacePrepare"):InvokeServer()
wait()
local args = {
    0.5699999999998866
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceEnd"):InvokeServer(unpack(args))
wait()
local args = {
    true,
    1,
    1
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceReward"):FireServer(unpack(args))
wait()
end
end })



-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
local Tabs = {
    Main = Window:AddTab({ Title = "Auto train Speed", Icon = "zap" }),
}
-- parágrafo
Tabs.Main:AddParagraph({ Title = "Auto train Speed", Content = "if you need to have the treadmill unlocked to work " })

-- botões
Tabs.Main:AddButton({ Title = "Auto train treadmill 1", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"1"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 2", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"2"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 3", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"3"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 4", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"4"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 5", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"5"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 6", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"6"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 7 (Need Vip)", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"7"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 8", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"8"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 9", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"9"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 10", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"10"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 11", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"11"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 12", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"12"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 13", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"13"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 14 (Need Vip)", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"14"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 15", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"15"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 16", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"16"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Disable Auto train", Callback = function()
_G.loop = false
while _G.loop do
wait()
local args = {
	"3"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end }) 
local Tabs = {
    Main = Window:AddTab({ Title = "Credits", Icon = "user-round" }),
}
-- parágrafo 
Tabs.Main:AddParagraph({ Title = "Scripts pro_tysm1", Content = "" })
Tabs.Main:AddParagraph({ Title = "Hub canal deku_player (miguel_indo4)", Content = "" })-- carregar biblioteca
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

--aviso ao executar
Fluent:Notify({
        Title = "executed successfully",
        Content = "the script loaded successfully ",
        SubContent = "my main roblox account name miguel_indo4", -- Optional
        Duration = 10 -- Set to nil to make the notification not disappear
    })

local Window = Fluent:CreateWindow({
    Title = "Script Run star Simulator" .. Fluent.Version,
    TabWidth = 160, 
    Size = UDim2.fromOffset(580, 460),
    SubTitle = "by miguel_indo4",
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Auto win Worlds", Icon = "trophy" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- parágrafos 
Tabs.Main:AddParagraph({ Title = "Run star Simulator", Content = "you need to have the world unlocked to work " })

--botões 
Tabs.Main:AddButton({ Title = "Auto win world 1", Callback = function()
_G.loop = true while _G.loop do
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RacePrepare"):InvokeServer()
wait()
local args = {
    0.5699999999998866
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceEnd"):InvokeServer(unpack(args))
wait()
local args = {
    true,
    1,
    1
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceReward"):FireServer(unpack(args))
wait()
end
end })
Tabs.Main:AddButton({ Title = "Auto win world 2", Callback = function()
_G.loop = true while _G.loop do
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RacePrepare"):InvokeServer()
wait()
local args = {
    0.5699999999998866
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceEnd"):InvokeServer(unpack(args))
wait()
local args = {
    true,
    2,
    2
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceReward"):FireServer(unpack(args))
wait()
end
end })
Tabs.Main:AddButton({ Title = "Auto win world 3", Callback = function()
_G.loop = true while _G.loop do
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RacePrepare"):InvokeServer()
wait()
local args = {
    0.5699999999998866
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceEnd"):InvokeServer(unpack(args))
wait()
local args = {
    true,
    3,
    3
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceReward"):FireServer(unpack(args))
wait()
end
end })
Tabs.Main:AddButton({ Title = "Disable Auto win", Callback = function()
_G.loop = false while _G.loop do
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RacePrepare"):InvokeServer()
wait()
local args = {
    0.5699999999998866
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceEnd"):InvokeServer(unpack(args))
wait()
local args = {
    true,
    1,
    1
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Race"):WaitForChild("RaceReward"):FireServer(unpack(args))
wait()
end
end })



-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
local Tabs = {
    Main = Window:AddTab({ Title = "Auto train Speed", Icon = "zap" }),
}
-- parágrafo
Tabs.Main:AddParagraph({ Title = "Auto train Speed", Content = "if you need to have the treadmill unlocked to work " })

-- botões
Tabs.Main:AddButton({ Title = "Auto train treadmill 1", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"1"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 2", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"2"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 3", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"3"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 4", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"4"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 5", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"5"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 6", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"6"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 7 (Need Vip)", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"7"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 8", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"8"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 9", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"9"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 10", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"10"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 11", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"11"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 12", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"12"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 13", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"13"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 14 (Need Vip)", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"14"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 15", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"15"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Auto train treadmill 16", Callback = function()
_G.loop = true
while _G.loop do
wait()
local args = {
	"16"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
Tabs.Main:AddButton({ Title = "Disable Auto train", Callback = function()
_G.loop = false
while _G.loop do
wait()
local args = {
	"3"
}
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Train"):WaitForChild("AddSpeed"):FireServer(unpack(args))
end
end })
