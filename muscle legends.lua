--==================================================
-- TLD HUB | Muscle Legends
-- UI Própria | Delta Safe | Sem Whitelist
--==================================================

-- ===== SERVICES =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local player = Players.LocalPlayer

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- ===== FLAGS =====
local Flags = {
    Strength = false,
    Agility = false,
    Durability = false,
    Rock = false,
    Rebirth = false
}

-- ===== UI =====
local gui = Instance.new("ScreenGui")
gui.Name = "TLDHub"
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.45, 0.55)
main.Position = UDim2.fromScale(0.275, 0.22)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1, 0.12)
title.BackgroundTransparency = 1
title.Text = "💪 TLD HUB | Muscle Legends"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)

local function Toggle(text, posY, flagName)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.fromScale(0.9, 0.11)
    btn.Position = UDim2.fromScale(0.05, posY)
    btn.Text = text .. " : OFF"
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

    btn.MouseButton1Click:Connect(function()
        Flags[flagName] = not Flags[flagName]
        btn.Text = text .. (Flags[flagName] and " : ON" or " : OFF")
        btn.BackgroundColor3 = Flags[flagName]
            and Color3.fromRGB(50,120,60)
            or Color3.fromRGB(35,35,35)
    end)
end

Toggle("Auto Strength", 0.15, "Strength")
Toggle("Auto Agility", 0.28, "Agility")
Toggle("Auto Durability", 0.41, "Durability")
Toggle("Auto Rock", 0.54, "Rock")
Toggle("Auto Rebirth", 0.67, "Rebirth")

-- ===== AUTO TRAIN =====
task.spawn(function()
    while task.wait(0.18) do
        if Flags.Strength then
            pcall(function()
                RS.Remotes.Train:FireServer("Strength")
            end)
        end
        if Flags.Agility then
            pcall(function()
                RS.Remotes.Train:FireServer("Agility")
            end)
        end
        if Flags.Durability then
            pcall(function()
                RS.Remotes.Train:FireServer("Durability")
            end)
        end
    end
end)

-- ===== AUTO ROCK =====
task.spawn(function()
    while task.wait(0.25) do
        if Flags.Rock then
            for _,v in pairs(WS:GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("rock") then
                    hrp.CFrame = v.CFrame * CFrame.new(0,0,-3)
                    pcall(function()
                        RS.Remotes.Train:FireServer("Strength")
                    end)
                    break
                end
            end
        end
    end
end)

-- ===== AUTO REBIRTH (NORMAL) =====
task.spawn(function()
    while task.wait(3) do
        if Flags.Rebirth then
            pcall(function()
                RS.Remotes.Rebirth:FireServer()
            end)
        end
    end
end)