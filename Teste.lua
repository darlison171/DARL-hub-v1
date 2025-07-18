local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "DARLhub | Grow A Garden",
    SubTitle = "Auto Farming integrado",
    TabWidth = 160,
    Size = UDim2.fromOffset(520, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl,
    Logo = "rbxassetid://138540238455802"
})

local GrowTab = Window:AddTab({ Title = "Garden", Icon = "🌱" })

-- Toggle Auto Plant & Harvest
GrowTab:AddToggle("Auto Plant & Harvest", { Default = false }, function(v)
    _G.AutoGH = v
    if v then
        spawn(function()
            while _G.AutoGH do
                task.wait(0.5)
                pcall(function()
                    -- Script de auto farm básico (nootmaus)
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/nootmaus/GrowAAGarden/refs/heads/main/mauscripts"))()
                end)
            end
        end)
    end
end)

-- Toggle Auto Plant, Harvest e Vender
GrowTab:AddToggle("Auto Farm + Sell", { Default = false }, function(v)
    _G.AutoGHSell = v
    if v then
        spawn(function()
            while _G.AutoGHSell do
                task.wait(0.5)
                pcall(function()
                    -- Script depthso autofarm
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/depthso/Grow-a-Garden/refs/heads/main/autofarm.lua"))()
                end)
            end
        end)
    end
end)

-- Toggle Semente Infinita
GrowTab:AddToggle("Inf Seeds", { Default = false }, function(v)
    _G.InfSeeds = v
    if v then
        game:GetService("Players").LocalPlayer.PlayerGui:ClearAllChildren()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/checkurasshole/Script/refs/heads/main/IQ"))()
    end
end)

-- Botão Teleporte Pro Garden
GrowTab:AddButton("Teleport to Garden", function()
    local plr = game.Players.LocalPlayer
    plr.Character:MoveTo(Vector3.new(0, 5, 0))  -- ajuste posição conforme o mapa
    Fluent:Notify({ Title="DARLhub", Content="Teleport realizado!" })
end)

Fluent:Notify({
    Title="DARLhub",
    Content="Grow A Garden integrado!",
    SubContent="Ative as funções na aba 'Garden'",
    Duration=6
})
