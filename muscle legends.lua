--==================================================
-- TLD HUB | Muscle Legends
-- Fluent UI | Universal Executor
-- Auto Farm Seguro (sem bug pet)
-- Com verificação por UserId
--==================================================

-- ===== WHITELIST POR USERID =====
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Whitelist = {
    player.UserId, -- você (não remove)
    -- 123456789, -- exemplo
    -- 987654321  -- exemplo
}

local function IsWhitelisted(id)
    for _,v in pairs(Whitelist) do
        if v == id then
            return true
        end
    end
    return false
end

if not IsWhitelisted(player.UserId) then
    player:Kick("⛔ Acesso negado | TLD HUB")
    return
end

-- ===== LOAD FLUENT UI =====
local Fluent = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/dawid-scripts/Fluent/master/main.lua"
))()

-- ===== SERVICES =====
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")

-- ===== PLAYER =====
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

-- ===== WINDOW =====
local Window = Fluent:CreateWindow({
    Title = "💪 TLD HUB | Muscle Legends",
    SubTitle = "Auto Farm Seguro • Fluent UI",
    TabWidth = 160,
    Size = UDim2.fromOffset(520, 420),
    Theme = "Dark"
})

local FarmTab = Window:AddTab({ Title = "Farm", Icon = "swords" })
local MiscTab = Window:AddTab({ Title = "Info", Icon = "info" })

-- ===== TOGGLES =====
FarmTab:AddToggle("AutoStrength", {
    Title = "Auto Strength",
    Callback = function(v)
        Flags.Strength = v
    end
})

FarmTab:AddToggle("AutoAgility", {
    Title = "Auto Agility",
    Callback = function(v)
        Flags.Agility = v
    end
})

FarmTab:AddToggle("AutoDurability", {
    Title = "Auto Durability",
    Callback = function(v)
        Flags.Durability = v
    end
})

FarmTab:AddToggle("AutoRock", {
    Title = "Auto Rock",
    Callback = function(v)
        Flags.Rock = v
    end
})

FarmTab:AddToggle("AutoRebirth", {
    Title = "Auto Rebirth (Normal)",
    Callback = function(v)
        Flags.Rebirth = v
    end
})

-- ===== AUTO STRENGTH =====
task.spawn(function()
    while task.wait(0.15) do
        if Flags.Strength then
            pcall(function()
                RS.Remotes.Train:FireServer("Strength")
            end)
        end
    end
end)

-- ===== AUTO AGILITY =====
task.spawn(function()
    while task.wait(0.2) do
        if Flags.Agility then
            pcall(function()
                RS.Remotes.Train:FireServer("Agility")
            end)
        end
    end
end)

-- ===== AUTO DURABILITY =====
task.spawn(function()
    while task.wait(0.2) do
        if Flags.Durability then
            pcall(function()
                RS.Remotes.Train:FireServer("Durability")
            end)
        end
    end
end)

-- ===== AUTO ROCK =====
local function GetRock()
    for _,v in pairs(WS:GetDescendants()) do
        if v:IsA("BasePart") and v.Name:lower():find("rock") then
            return v
        end
    end
end

task.spawn(function()
    while task.wait(0.2) do
        if Flags.Rock then
            local rock = GetRock()
            if rock then
                hrp.CFrame = rock.CFrame * CFrame.new(0,0,-3)
                pcall(function()
                    RS.Remotes.Train:FireServer("Strength")
                end)
            end
        end
    end
end)

-- ===== AUTO REBIRTH (SEGURO) =====
task.spawn(function()
    while task.wait(3) do
        if Flags.Rebirth then
            pcall(function()
                RS.Remotes.Rebirth:FireServer()
            end)
        end
    end
end)

-- ===== INFO =====
MiscTab:AddParagraph({
    Title = "TLD HUB",
    Content =
        "✔ Script baseado no funcionamento real do Muscle Legends\n" ..
})

Window:SelectTab(1)