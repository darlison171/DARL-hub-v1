local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Grow Garden Hub 🌱",
    SubTitle = "by Darlison",
    TabWidth = 160,
    Size = UDim2.fromOffset(530, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tab = Window:AddTab({ Title = "Auto Farm", Icon = "🌾" })

Tab:AddToggle({
    Title = "Auto Plantar",
    Default = false,
    Callback = function(value)
        getgenv().autoPlant = value
        while autoPlant and task.wait() do
            -- comando de plantio
        end
    end
})

Tab:AddToggle({
    Title = "Auto Rega",
    Default = false,
    Callback = function(value)
        getgenv().autoWater = value
        while autoWater and task.wait() do
            -- comando de regar
        end
    end
})

Tab:AddToggle({
    Title = "Auto Colher",
    Default = false,
    Callback = function(value)
        getgenv().autoHarvest = value
        while autoHarvest and task.wait() do
            -- comando de colher
        end
    end
})

local Tab2 = Window:AddTab({ Title = "Extras", Icon = "⚙️" })

Tab2:AddSlider({
    Title = "Velocidade do Jogador",
    Description = "Aumente a velocidade!",
    Default = 16,
    Min = 16,
    Max = 100,
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

Tab2:AddButton({
    Title = "Desativar Gráficos (NoLag)",
    Callback = function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
    end
})
