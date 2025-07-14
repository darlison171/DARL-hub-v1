-- NEXUS HUB: AUTO WINS + AUTO CLICK com TOGGLES reais separadas

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local ToggleWins = Instance.new("TextButton")
local ToggleClick = Instance.new("TextButton")
local UICorner1 = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")
local UICorner3 = Instance.new("UICorner")
local UICorner4 = Instance.new("UICorner")

ScreenGui.Name = "NexusHubUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Name = "Main"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.Size = UDim2.new(0, 200, 0, 160)
Frame.Active = true
Frame.Draggable = true
UICorner1.Parent = Frame

Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Font = Enum.Font.GothamBlack
Title.Text = "NEXUS HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

Subtitle.Parent = Frame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 25)
Subtitle.Size = UDim2.new(1, 0, 0, 15)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "AUTO WINS & AUTO CLICK"
Subtitle.TextColor3 = Color3.fromRGB(0, 255, 127)
Subtitle.TextSize = 12

-- Toggle Auto Wins
ToggleWins.Name = "ToggleWins"
ToggleWins.Parent = Frame
ToggleWins.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleWins.Position = UDim2.new(0.5, -75, 0, 55)
ToggleWins.Size = UDim2.new(0, 150, 0, 35)
ToggleWins.Font = Enum.Font.GothamBold
ToggleWins.Text = "AUTO WINS: DESATIVADO"
ToggleWins.TextColor3 = Color3.fromRGB(255, 0, 0)
ToggleWins.TextSize = 13
ToggleWins.BorderSizePixel = 0
UICorner2.Parent = ToggleWins

-- Toggle Auto Click
ToggleClick.Name = "ToggleClick"
ToggleClick.Parent = Frame
ToggleClick.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleClick.Position = UDim2.new(0.5, -75, 0, 100)
ToggleClick.Size = UDim2.new(0, 150, 0, 35)
ToggleClick.Font = Enum.Font.GothamBold
ToggleClick.Text = "AUTO CLICK: DESATIVADO"
ToggleClick.TextColor3 = Color3.fromRGB(255, 0, 0)
ToggleClick.TextSize = 13
ToggleClick.BorderSizePixel = 0
UICorner3.Parent = ToggleClick

-- Variáveis de controle
local autoWinsAtivo = false
local autoClickAtivo = false

-- Função Auto Wins (com toques lentos)
local function autoWins()
    task.spawn(function()
        while autoWinsAtivo do
            local head = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head")
            if head then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("TouchTransmitter") and v.Parent then
                        firetouchinterest(head, v.Parent, 0)
                        wait(0.2)
                        firetouchinterest(head, v.Parent, 1)
                        wait(0.2)
                    end
                end
            end
            wait(0.5)
        end
    end)
end

-- Função Auto Click (loop vazio)
local function autoClick()
    task.spawn(function()
        while autoClickAtivo do
            wait(0.1)
        end
    end)
end

-- Evento da Toggle de Auto Wins
ToggleWins.MouseButton1Click:Connect(function()
    autoWinsAtivo = not autoWinsAtivo
    ToggleWins.Text = autoWinsAtivo and "AUTO WINS: ATIVADO" or "AUTO WINS: DESATIVADO"
    ToggleWins.TextColor3 = autoWinsAtivo and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    
    if autoWinsAtivo then
        autoWins()
    end
end)

-- Evento da Toggle de Auto Click
ToggleClick.MouseButton1Click:Connect(function()
    autoClickAtivo = not autoClickAtivo
    ToggleClick.Text = autoClickAtivo and "AUTO CLICK: ATIVADO" or "AUTO CLICK: DESATIVADO"
    ToggleClick.TextColor3 = autoClickAtivo and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoClickAtivo then
        autoClick()
    end
end)
