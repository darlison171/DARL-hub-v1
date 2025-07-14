-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Configurar GUI
ScreenGui.Name = "NexusAutoWinUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.Size = UDim2.new(0, 180, 0, 100)
Frame.Active = true
Frame.Draggable = true

UICorner.Parent = Frame

-- TÍTULO: NEXUS HUB
Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Font = Enum.Font.GothamBlack
Title.Text = "NEXUS HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextStrokeTransparency = 0.8
Title.TextYAlignment = Enum.TextYAlignment.Top

-- SUBTÍTULO: AUTO WINS
Subtitle.Name = "Subtitle"
Subtitle.Parent = Frame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 25)
Subtitle.Size = UDim2.new(1, 0, 0, 15)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "AUTO WINS"
Subtitle.TextColor3 = Color3.fromRGB(0, 255, 127)
Subtitle.TextSize = 12

-- Botão de Toggle
Toggle.Name = "Toggle"
Toggle.Parent = Frame
Toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Toggle.Position = UDim2.new(0.5, -60, 0, 50)
Toggle.Size = UDim2.new(0, 120, 0, 30)
Toggle.Font = Enum.Font.GothamBold
Toggle.Text = "AUTO WIN [OFF]"
Toggle.TextColor3 = Color3.fromRGB(255, 0, 0)
Toggle.TextSize = 14
Toggle.BorderSizePixel = 0

-- Lógica do Toggle
local enabled = false
local running = false

Toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    Toggle.Text = enabled and "AUTO WIN [ON]" or "AUTO WIN [OFF]"
    Toggle.TextColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if enabled and not running then
        running = true
        task.spawn(function()
            while enabled do
                local head = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head")
                if head then
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v.Name == "TouchInterest" and v.Parent then
                            firetouchinterest(head, v.Parent, 0)
                            wait()
                            firetouchinterest(head, v.Parent, 1)
                        end
                    end
                end
                wait(5) -- intervalo entre execuções
            end
            running = false
        end)
    end
end)
