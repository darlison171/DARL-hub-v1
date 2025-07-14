-- NEXUS HUB: AUTO WINS (lento) + AUTO CLICK (vazio) - Mobile Friendly

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "NexusAutoWinUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.Size = UDim2.new(0, 180, 0, 120)
Frame.Active = true
Frame.Draggable = true

UICorner.Parent = Frame

Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Font = Enum.Font.GothamBlack
Title.Text = "NEXUS HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

Subtitle.Name = "Subtitle"
Subtitle.Parent = Frame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 25)
Subtitle.Size = UDim2.new(1, 0, 0, 15)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "AUTO WINS & AUTO CLICK"
Subtitle.TextColor3 = Color3.fromRGB(0, 255, 127)
Subtitle.TextSize = 12

Toggle.Name = "Toggle"
Toggle.Parent = Frame
Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Toggle.Position = UDim2.new(0.5, -60, 0, 60)
Toggle.Size = UDim2.new(0, 120, 0, 40)
Toggle.Font = Enum.Font.GothamBold
Toggle.Text = "DESATIVADO"
Toggle.TextColor3 = Color3.fromRGB(255, 0, 0)
Toggle.TextSize = 16
Toggle.BorderSizePixel = 0

-- Variáveis de controle
local enabled = false
local autoWinsRunning = false
local autoClickRunning = false

-- AUTO WINS com toques lentos
local function autoWins()
    autoWinsRunning = true
    task.spawn(function()
        while enabled and autoWinsRunning do
            local head = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head")
            if head then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("TouchTransmitter") and v.Parent then
                        firetouchinterest(head, v.Parent, 0)
                        wait(0.2) -- toque suave
                        firetouchinterest(head, v.Parent, 1)
                        wait(0.2)
                    end
                end
            end
            wait(0.5)
        end
    end)
end

-- AUTO CLICK (vazio, simulação)
local function autoClick()
    autoClickRunning = true
    task.spawn(function()
        while enabled and autoClickRunning do
            wait(0.1) -- simulação de clique (sem ação)
        end
    end)
end

-- BOTÃO TOGGLE
Toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    Toggle.Text = enabled and "ATIVADO" or "DESATIVADO"
    Toggle.TextColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if enabled then
        autoWins()
        autoClick()
    else
        autoWinsRunning = false
        autoClickRunning = false
    end
end)
