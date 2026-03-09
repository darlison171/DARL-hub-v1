-- Shadow Nexus Hub
-- Muscle Simulator Script

local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local run = game:GetService("RunService")

-- CONFIG
_G.AutoTrain = false
_G.AutoRebirth = false
_G.AutoPet = false
_G.AutoChest = false
_G.AutoSpin = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ShadowNexus"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,400,0,350)
frame.Position = UDim2.new(0.3,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,40)
title.Text = "SHADOW NEXUS HUB"
title.TextScaled = true
title.BackgroundColor3 = Color3.fromRGB(10,10,10)
title.TextColor3 = Color3.new(1,1,1)

-- função criar botão
local function button(text,pos,callback)
    local b = Instance.new("TextButton")
    b.Parent = frame
    b.Size = UDim2.new(0.8,0,0,35)
    b.Position = UDim2.new(0.1,0,0,pos)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)

    b.MouseButton1Click:Connect(callback)
end

-- AUTO TRAIN
button("Auto Train",60,function()
    _G.AutoTrain = not _G.AutoTrain
end)

task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoTrain then
            if rs:FindFirstChild("Train") then
                rs.Train:FireServer()
            end
        end
    end
end)

-- AUTO REBIRTH
button("Auto Rebirth",110,function()
    _G.AutoRebirth = not _G.AutoRebirth
end)

task.spawn(function()
    while task.wait(1) do
        if _G.AutoRebirth then
            if rs:FindFirstChild("Rebirth") then
                rs.Rebirth:FireServer()
            end
        end
    end
end)

-- AUTO PET
button("Auto Buy Pet",160,function()
    _G.AutoPet = not _G.AutoPet
end)

task.spawn(function()
    while task.wait(2) do
        if _G.AutoPet then
            if rs:FindFirstChild("BuyPet") then
                rs.BuyPet:FireServer()
            end
        end
    end
end)

-- AUTO CHEST
button("Auto Chest",210,function()
    _G.AutoChest = not _G.AutoChest
end)

task.spawn(function()
    while task.wait(3) do
        if _G.AutoChest then
            if rs:FindFirstChild("Chest") then
                rs.Chest:FireServer()
            end
        end
    end
end)

-- AUTO SPIN
button("Auto Spin",260,function()
    _G.AutoSpin = not _G.AutoSpin
end)

task.spawn(function()
    while task.wait(4) do
        if _G.AutoSpin then
            if rs:FindFirstChild("Spin") then
                rs.Spin:FireServer()
            end
        end
    end
end)

-- SPEED
button("Speed x2",310,function()
    local char = player.Character
    if char then
        char:WaitForChild("Humanoid").WalkSpeed = 32
    end
end)

-- JUMP
button("Super Jump",360,function()
    local char = player.Character
    if char then
        char:WaitForChild("Humanoid").JumpPower = 120
    end
end)

-- ANTI AFK
player.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
