-- NEXUS HUB: AUTO WINS e AUTO CLICK com toggles separados (Mobile Friendly)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local ToggleWins = Instance.new("TextButton")
local ToggleClick = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "NexusAutoWinUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Active = true
Frame.Draggable = true

UICorner.Parent = Frame

-- Título
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Font = Enum.Font.GothamBlack
Title.Text = "NEXUS HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

-- Subtítulo
Subtitle.Parent = Frame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 25)
Subtitle.Size = UDim2.new(1, 0, 0, 15)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "AUTO WINS & CLICK"
Subtitle.TextColor3 = Color3.fromRGB(0, 255, 127)
Subtitle.TextSize = 12

-- Toggle Auto Wins
ToggleWins.Name = "ToggleWins"
ToggleWins.Parent = Frame
ToggleWins.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleWins.Position = UDim2.new(0.5, -75, 0, 55)
ToggleWins.Size = UDim2.new(0, 150, 0, 35)
ToggleWins.Font = Enum.Font.GothamBold
ToggleWins.Text = "AUTO WINS: OFF"
ToggleWins.TextColor3 = Color3.fromRGB(255, 0, 0)
ToggleWins.TextSize = 14
ToggleWins.BorderSizePixel = 0

-- Toggle Auto Click
ToggleClick.Name = "ToggleClick"
ToggleClick.Parent = Frame
ToggleClick.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleClick.Position = UDim2.new(0.5, -75, 0, 100)
ToggleClick.Size = UDim2.new(0, 150, 0, 35)
ToggleClick.Font = Enum.Font.GothamBold
ToggleClick.Text = "AUTO CLICK: OFF"
ToggleClick.TextColor3 = Color3.fromRGB(255, 0, 0)
ToggleClick.TextSize = 14
ToggleClick.BorderSizePixel = 0

-- Variáveis
local autoWinsOn = false
local autoClickOn = false

-- Função Auto Wins
local function autoWins()
    task.spawn(function()
        while autoWinsOn do
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

-- Função Auto Click (vazio)
local function autoClick()
    task.spawn(function()
        while autoClickOn do
            wait(0.1)
        end
    end)
end

-- Evento Toggle Wins
ToggleWins.MouseButton1Click:Connect(function()
    autoWinsOn = not autoWinsOn
    ToggleWins.Text = autoWinsOn and "AUTO WINS: ON" or "AUTO WINS: OFF"
    ToggleWins.TextColor3 = autoWinsOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoWinsOn then
        autoWins()
    end
end)

-- Evento Toggle Click
ToggleClick.MouseButton1Click:Connect(function()
    autoClickOn = not autoClickOn
    ToggleClick.Text = autoClickOn and "AUTO CLICK: ON" or "AUTO CLICK: OFF"
    ToggleClick.TextColor3 = autoClickOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoClickOn then
        autoClick()
    end
end)
