-- NEXUS HUB: AUTO WINS & AUTO CLICK (com toques lentos)

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
Subtitle.Text = "AUTO WINS (lento) & CLICK"
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

local enabled = false
local winsLoop = false
local clickLoop = false

-- AUTO WINS com toques lentos
local function startAutoWins()
    winsLoop = true
    task.spawn(function()
        while enabled and winsLoop do
            local head = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head")
            if head then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("TouchTransmitter") and v.Parent then
                        firetouchinterest(head, v.Parent, 0)
                        wait(0.2) -- toque lento
                        firetouchinterest(head, v.Parent, 1)
                        wait(0.2) -- mais pausa
                    end
                end
            end
            wait(5) -- espera entre ciclos completos
        end
    end)
end

-- AUTO CLICK básico
local function startAutoClick()
    clickLoop = true
    task.spawn(function()
        while enabled and clickLoop do
            -- Pode colocar RemoteEvent aqui se quiser
            wait(0.1) -- clique rápido
        end
    end)
end

-- Toggle botão
Toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    Toggle.Text = enabled and "ATIVADO" or "DESATIVADO"
    Toggle.TextColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if enabled then
        startAutoWins()
        startAutoClick()
    else
        winsLoop = false
        clickLoop = false
    end
end)
