local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local displayName = Player.DisplayName
local antiAFKConnection
local ChocolateEatEvent = ReplicatedStorage.RemotesEvent.ChocolateEatEvent

-- ================= HELPERS =================
local function getGreeting()
    local hour = os.date("*t").hour
    if hour >= 5 and hour < 12 then return "Good Morning"
    elseif hour >= 12 and hour < 18 then return "Good Afternoon"
    elseif hour >= 18 and hour < 24 then return "Good Evening"
    else return "Good Night" end
end

local function formatNumber(n)
    n = tonumber(n) or 0
    if n >= 1e18 then return string.format("%.1fQi", n/1e18)
    elseif n >= 1e15 then return string.format("%.1fQa", n/1e15)
    elseif n >= 1e12 then return string.format("%.1fT",  n/1e12)
    elseif n >= 1e9  then return string.format("%.1fB",  n/1e9)
    elseif n >= 1e6  then return string.format("%.1fM",  n/1e6)
    elseif n >= 1e3  then return string.format("%.1fK",  n/1e3)
    else return tostring(math.floor(n)) end
end

local function AbbrevNumber(num)
    num = tonumber(num) or 0
    if num <= 0 then return "0" end
    local abbrev = {"", "K", "M", "B", "T", "Qa", "Qi"}
    local i = 1
    while num >= 1000 and i < #abbrev do
        num = num / 1000
        i = i + 1
    end
    return string.format("%.2f%s", num, abbrev[i])
end

local function exactNumber(n)
    n = math.floor(tonumber(n) or 0)
    local str = tostring(n)
    local result, offset = "", #str % 3
    for i = 1, #str do
        if i > 1 and (i - offset - 1) % 3 == 0 then result = result .. "," end
        result = result .. str:sub(i, i)
    end
    return result
end

local function addBodoniLabel(tab, text, color)
    local lbl = tab:AddLabel(text)
    lbl.Font = Enum.Font.Bodoni
    local finalColor = color or Color3.fromRGB(255, 255, 255)
    lbl.TextColor3 = finalColor
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 0.5
    stroke.Color = finalColor
    stroke.Parent = lbl
    return lbl
end

-- ================= LIBRARY =================
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GeloXOshiru/PrimeJelo-Hub/refs/heads/main/Image.png", true))()

local window, windowFrame = library:AddWindow("primejelo On Top", {
    title_bar = {
    Color3.fromRGB(0, 0, 0),
    Color3.fromRGB(180, 20, 20),
    Color3.fromRGB(100, 8, 8),
},
background = {
    Color3.fromRGB(18, 5, 5),
    Color3.fromRGB(12, 3, 3),
    Color3.fromRGB(6, 0, 0),
},
    background_transparency = 0.2,
    main_color = Color3.fromRGB(0, 0, 0),
    min_size = Vector2.new(430, 300),
    can_resize = true,
})

-- ================= TITLE BAR =================
task.spawn(function()
    task.wait(1.5)
    local titleLabel = nil
    for _, area in pairs({game.CoreGui, Player:FindFirstChild("PlayerGui")}) do
        if area then
            for _, v in pairs(area:GetDescendants()) do
                if v:IsA("TextLabel") and (string.find(v.Text,"PrimeJelo") or string.find(v.Text,"Muscle")) then
                    if not v:FindFirstAncestorOfClass("ScrollingFrame") then
                        titleLabel = v break
                    end
                end
            end
        end
        if titleLabel then break end
    end
    if titleLabel then
        titleLabel.RichText = false
        titleLabel.Font = Enum.Font.Bodoni
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextStrokeTransparency = 2
        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 0.5
        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Parent = titleLabel
        while true do
            titleLabel.Text = string.format(" NEXUS | PAID | %s - %s", getGreeting(), displayName)
            task.wait(1)
        end
    end
end)

-- ================= TABS =================
local mainTab     = window:AddTab("Farm")
local strengthTab = window:AddTab("Strength")
local rebirthTab  = window:AddTab("Rebirth")
local glitchTab   = window:AddTab("Glitch")
local petsTab     = window:AddTab("Pet Shop")
local miscTab     = window:AddTab("Misc")
local tpTab       = window:AddTab("Teleport")
local killTab     = window:AddTab("Killing")
local spyTab      = window:AddTab("Spy Stats")
local calcTab     = window:AddTab("Stats")
local invTab      = window:AddTab("Inventory")
local settingsTab = window:AddTab("Settings")
local infoTab     = window:AddTab("Info")

-- ================= REMOTES & VARS =================
local strong             = Player:WaitForChild("leaderstats"):WaitForChild("Strong")
local machineactive      = ReplicatedStorage.RemotesEvent.MachineActiveFunction
local MachineActiveEvent = ReplicatedStorage.RemotesEvent.MachineActiveEvent
local machineuse         = Player:WaitForChild("Machineuse")
local bechmemp           = workspace:WaitForChild("MachinesFolder"):WaitForChild("Bench Press Muscle Emperor")
local squatOcean         = workspace:WaitForChild("MachinesFolder"):WaitForChild("Squat Ocean")
local spinfu             = ReplicatedStorage.RemotesEvent.SpinFunction
local remoterebirths     = ReplicatedStorage.RemotesEvent.RebirthEvent
local SellPetEvent       = ReplicatedStorage.RemotesEvent.SellPetEvent
local ChestClaimEvent    = ReplicatedStorage.RemotesEvent.ChestClaimEvent
local HidePetsEvent      = ReplicatedStorage.RemotesEvent.HidePetsEvent
local PunchEvent         = ReplicatedStorage.RemotesEvent.PunchEvent
local BodyMovement       = ReplicatedStorage.RemotesEvent.BodyMovement
local SizeChanged        = ReplicatedStorage.RemotesEvent.SizeChanged
local eggsFolder         = workspace:WaitForChild("EggsFolder")
local chestsFolder       = workspace:WaitForChild("ChestsFolder")
local rewardClaim        = ReplicatedStorage.RemotesEvent:WaitForChild("rewardClaim", 10)
local rebirthValObj      = Player:FindFirstChild("leaderstats") and Player.leaderstats:FindFirstChild("Rebirths")

local endurValObj = nil
do
    for _, child in pairs(Player:GetChildren()) do
        if child.Name == "Endurance" then endurValObj = child break end
        local e = child:FindFirstChild("Endurance")
        if e then endurValObj = e break end
    end
end

local isAuto           = false
local isAutolift       = false
local isAutoGlitch     = false
local isapin           = false
local isAutoHatch      = false
local isAutoSell       = false
local isAutoChest      = false
local isAutoPunch      = false
local isSticking       = false
local isAutoKillAll    = false
local isTinyCombo      = false
local isAutoEat        = false
local isEating         = false
local isAutoRewards    = false
local isHideNameHealth = false

local lastSpinTime   = 0
local lastHatchTime  = 0
local lastChestTime  = 0
local lastEatTime    = 0
local SPIN_COOLDOWN  = 0.1
local HATCH_COOLDOWN = 0.1
local CHEST_COOLDOWN = 1.0
local EAT_COOLDOWN   = 0.1

local savedLighting     = {}
local selectedEggFolder = "Mythic"
local selectedSellPets  = {}
local selectedTarget    = nil
local selectedSpyPlayer = nil
local hands             = {"RightHand", "LeftHand"}
local handIndex         = 1
local whitelist         = {}
local totalChocoEaten   = 0
local camera            = workspace.CurrentCamera

local selectedPlayerToSpectate = nil
local spectating               = false
local currentTargetConnection  = nil

local CHESTS = {
    {name="Big Chest",     pos=Vector3.new(2,5,132)},
    {name="Chest",         pos=Vector3.new(13,6,-198)},
    {name="Legend Chest",  pos=Vector3.new(-188,2,458)},
    {name="Stone Chest",   pos=Vector3.new(-13,5,4490)},
    {name="Frost Chest",   pos=Vector3.new(-3089,5,179)},
    {name="Master Chest",  pos=Vector3.new(5839,3,73)},
    {name="Emperor Chest", pos=Vector3.new(2787,8,197)},
    {name="Ocean Chest",   pos=Vector3.new(-5792,8,49)},
}

local ISLANDS = {
    {name="Main",               pos=Vector3.new(0,5,0)},
    {name="Stone Realm",        pos=Vector3.new(68,13,4463)},
    {name="Frost",              pos=Vector3.new(-2856,14,176)},
    {name="The Muscle Emperor", pos=Vector3.new(2542,14,211)},
    {name="Folder Island",      pos=Vector3.new(5428,12,215)},
    {name="Ocean",              pos=Vector3.new(-5812,13,-93)},
}

local EGG_DATA = {
    {label="Common  (1K)",    folder="Common",    pets={"Sprout","Whisker","Fangor","Fox","RageSpike"}},
    {label="Rare  (3K)",      folder="Rare",      pets={"Bubbles","SparkPup","Hippopotamus","ShadowBun","FrostKit"}},
    {label="Epic  (20K)",     folder="Epic",      pets={"Captain","Tiger","TigEye","Dino","NerthEye"}},
    {label="Legendary (75K)", folder="Legendary", pets={"Dragon","Farmer","Military","Mighty Bull","Pyroclaw"}},
    {label="Mythic  (500K)",  folder="Mythic",    pets={"Violet Fury","Leviathos","Abyss Titan","Ragehorn","Space Dragon","RedHorn"}},
    {label="Masters (500M)",  folder="Masters",   pets={"Hedgehog","Bee","Panda","Kelpie","Dezz"}},
}

local labelToFolder = {}
for _, d in ipairs(EGG_DATA) do labelToFolder[d.label] = d.folder end

local function getEggPrompt(folderName)
    local ok, result = pcall(function()
        return eggsFolder:WaitForChild(folderName,5):WaitForChild("EggsModel",5):WaitForChild("mesh_2",5):WaitForChild("VisiblePrompt",5)
    end)
    if ok and result then return result end
end

local function getPetsMenu()
    local ok, result = pcall(function()
        return Player.PlayerGui:WaitForChild("gamegui",5):WaitForChild("petsMenu",5):WaitForChild("pets_item",5)
    end)
    if ok then return result end
end

local function teleportToEgg(folderName)
    pcall(function()
        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        local camMove = eggsFolder:FindFirstChild(folderName):FindFirstChild("EggsModel"):FindFirstChild("CameraMove")
        if root and camMove then root.CFrame = camMove.CFrame + Vector3.new(0,0,5) end
    end)
end

local function teleportTo(pos)
    pcall(function()
        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if root then root.CFrame = CFrame.new(pos + Vector3.new(0,5,0)) end
    end)
end

local function setCharSize(size)
    pcall(function() SizeChanged:FireServer(size) end)
    pcall(function()
        local char = Player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.BodyDepthScale.Value  = size
            hum.BodyHeightScale.Value = size
            hum.BodyWidthScale.Value  = size
            hum.HeadScale.Value       = size
        end
    end)
end

local function applyHideNameHealth(char)
    task.spawn(function()
        task.wait(0.5)
        pcall(function()
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
                humanoid.NameDisplayDistance = 0
                humanoid.HealthDisplayDistance = 0
            end
        end)
    end)
end

local function resetNameHealth(char)
    pcall(function()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
            humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.DisplayWhenDamaged
            humanoid.NameDisplayDistance = 100
            humanoid.HealthDisplayDistance = 100
        end
    end)
end

local function AutoEquipPunch()
    local char = Player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    for _, obj in pairs(char:GetChildren()) do
        if obj:IsA("Tool") then
            local n = obj.Name:lower()
            if n:find("punch") or n:find("glove") or n:find("fist") or n:find("hand") or n:find("gauntlet") then return end
        end
    end
    local bp = Player:FindFirstChild("Backpack")
    if bp then
        for _, tool in pairs(bp:GetChildren()) do
            if tool:IsA("Tool") then
                local n = tool.Name:lower()
                if n:find("punch") or n:find("glove") or n:find("fist") or n:find("hand") or n:find("gauntlet") then
                    pcall(function() hum:EquipTool(tool) end) return
                end
            end
        end
        local ft = bp:FindFirstChildOfClass("Tool")
        if ft then pcall(function() hum:EquipTool(ft) end) end
    end
end

task.spawn(function() task.wait(2) AutoEquipPunch() end)
Player.CharacterAdded:Connect(function(char)
    task.wait(2) AutoEquipPunch()
    if isTinyCombo then task.wait(0.5) setCharSize(0.001) end
    if isHideNameHealth then task.wait(0.5) applyHideNameHealth(char) end
end)

local function getPunchCFrame(targetPlayer)
    local result = nil
    pcall(function()
        local tc = targetPlayer.Character
        if not tc then return end
        local tRoot = tc:FindFirstChild("HumanoidRootPart")
        if not tRoot then return end
        local hrpSize = tRoot.Size
        local offsetZ = hrpSize.X <= 0.5 and 0.2 or hrpSize.X >= 5 and 1.5 or 1.0
        local minY, maxY = math.huge, -math.huge
        for _, part in pairs(tc:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 1 and part.Name ~= "lookTO" then
                pcall(function()
                    minY = math.min(minY, part.Position.Y - part.Size.Y/2)
                    maxY = math.max(maxY, part.Position.Y + part.Size.Y/2)
                end)
            end
        end
        local centerY = (minY == math.huge) and tRoot.Position.Y or (maxY+minY)/2
        local vel = tRoot.AssemblyLinearVelocity
        local pp  = tRoot.Position + Vector3.new(vel.X*0.083, 0, vel.Z*0.083)
        local lookTO = tc:FindFirstChild("lookTO")
        if lookTO then
            local dir = Vector3.new(lookTO.Position.X-tRoot.Position.X, 0, lookTO.Position.Z-tRoot.Position.Z)
            if dir.Magnitude > 0.01 then
                dir = dir.Unit
                result = CFrame.new(pp.X+dir.X*offsetZ, centerY, pp.Z+dir.Z*offsetZ) * CFrame.Angles(0, math.atan2(-dir.X,-dir.Z), 0)
                return
            end
        end
        result = CFrame.new(pp.X+tRoot.CFrame.LookVector.X*-offsetZ, centerY, pp.Z+tRoot.CFrame.LookVector.Z*-offsetZ) * CFrame.Angles(0, math.atan2(-tRoot.CFrame.LookVector.X, tRoot.CFrame.LookVector.Z), 0)
    end)
    return result
end

local function updateSpectateTarget(player)
    if currentTargetConnection then currentTargetConnection:Disconnect() end
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            camera.CameraSubject = humanoid
            currentTargetConnection = player.CharacterAdded:Connect(function(newChar)
                task.wait(0.2)
                local newHum = newChar:FindFirstChildOfClass("Humanoid")
                if newHum then camera.CameraSubject = newHum end
            end)
        end
    end
end

local function claimAllRewards()
    task.spawn(function()
        pcall(function()
            if not rewardClaim then return end
            local rewardsFolder = Player:FindFirstChild("rewards")
            if not rewardsFolder then return end
            for _, rewardFolder in pairs(rewardsFolder:GetChildren()) do
                pcall(function()
                    if rewardFolder:IsA("Folder") then
                        local claimed = rewardFolder:FindFirstChild("claimed")
                            or rewardFolder:FindFirstChild("Claimed")
                            or rewardFolder:FindFirstChild("isClaimed")
                        if claimed and claimed.Value == true then return end
                        rewardClaim:FireServer(rewardFolder.Name)
                        task.wait(1.0)
                    end
                end)
            end
        end)
    end)
end

local function applyGradient(element, colorList)
    local grad = element:FindFirstChildOfClass("UIGradient")
    if not grad then grad = Instance.new("UIGradient") grad.Parent = element end
    grad.Rotation = 45
    if #colorList >= 3 then
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   colorList[1]),
            ColorSequenceKeypoint.new(0.5, colorList[3]),
            ColorSequenceKeypoint.new(1,   colorList[5] or colorList[#colorList])
        })
    elseif #colorList == 2 then
        grad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,colorList[1]),ColorSequenceKeypoint.new(1,colorList[2])})
    else
        grad.Color = ColorSequence.new(colorList[1])
    end
    if element:IsA("ImageLabel") or element:IsA("ImageButton") then
        element.ImageColor3 = Color3.new(1,1,1)
    else
        element.BackgroundColor3 = Color3.new(1,1,1)
    end
end

local function makeCalcSection(tab, icon, statValFunc)
    local timeLabel = tab:AddLabel("Time:      0d 0h 0m 0s")
    timeLabel.Font = Enum.Font.Bodoni
    local stroke0 = Instance.new("UIStroke") stroke0.Thickness=0.5 stroke0.Color=Color3.fromRGB(255,255,255) stroke0.Parent=timeLabel

    local currLabel = tab:AddLabel("Current:   -")
    currLabel.Font = Enum.Font.Bodoni
    local stroke1 = Instance.new("UIStroke") stroke1.Thickness=0.5 stroke1.Color=Color3.fromRGB(255,255,255) stroke1.Parent=currLabel

    local gainLabel = tab:AddLabel("Gained:    +0")
    gainLabel.Font = Enum.Font.Bodoni
    local stroke2 = Instance.new("UIStroke") stroke2.Thickness=0.5 stroke2.Color=Color3.fromRGB(255,255,255) stroke2.Parent=gainLabel

    addBodoniLabel(tab, "Rate", Color3.fromRGB(255, 80, 80))

    local perMinLabel = tab:AddLabel("Per Min:   Calculating...")
    perMinLabel.Font = Enum.Font.Bodoni
    perMinLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    local stroke3 = Instance.new("UIStroke") stroke3.Thickness=0.5 stroke3.Color=Color3.fromRGB(255,80,80) stroke3.Parent=perMinLabel

    local perHrLabel = tab:AddLabel("Per Hour:  Calculating...")
    perHrLabel.Font = Enum.Font.Bodoni
    perHrLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    local stroke4 = Instance.new("UIStroke") stroke4.Thickness=0.5 stroke4.Color=Color3.fromRGB(255,80,80) stroke4.Parent=perHrLabel

    local perDayLabel = tab:AddLabel("Per Day:   Calculating...")
    perDayLabel.Font = Enum.Font.Bodoni
    perDayLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    local stroke5 = Instance.new("UIStroke") stroke5.Thickness=0.5 stroke5.Color=Color3.fromRGB(255,80,80) stroke5.Parent=perDayLabel

    local perWkLabel = tab:AddLabel("Per Week:  Calculating...")
    perWkLabel.Font = Enum.Font.Bodoni
    perWkLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    local stroke6 = Instance.new("UIStroke") stroke6.Thickness=0.5 stroke6.Color=Color3.fromRGB(255,80,80) stroke6.Parent=perWkLabel

    addBodoniLabel(tab, "Hour & Day Gain:", Color3.fromRGB(255, 165, 0))

    local projHrLabel = tab:AddLabel("Per Hour:  -")
    projHrLabel.Font = Enum.Font.Bodoni
    projHrLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
    local stroke7 = Instance.new("UIStroke") stroke7.Thickness=0.5 stroke7.Color=Color3.fromRGB(255,165,0) stroke7.Parent=projHrLabel

    local projDayLabel = tab:AddLabel("Per Day:   -")
    projDayLabel.Font = Enum.Font.Bodoni
    projDayLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
    local stroke8 = Instance.new("UIStroke") stroke8.Thickness=0.5 stroke8.Color=Color3.fromRGB(255,165,0) stroke8.Parent=projDayLabel

    local startTime = tick()
    local gained    = 0
    local lastVal   = statValFunc() or 0

    tab:AddButton("Reset Tracker", function()
        startTime = tick()
        gained    = 0
        lastVal   = statValFunc() or 0
        timeLabel.Text    = "Time:      0d 0h 0m 0s"
        currLabel.Text    = "Current:   -"
        gainLabel.Text    = "Gained:    +0"
        perMinLabel.Text  = "Per Min:   Calculating..."
        perHrLabel.Text   = "Per Hour:  Calculating..."
        perDayLabel.Text  = "Per Day:   Calculating..."
        perWkLabel.Text   = "Per Week:  Calculating..."
        projHrLabel.Text  = "Per Hour:  -"
        projDayLabel.Text = "Per Day:   -"
    end)

    task.spawn(function()
        while task.wait(0.5) do
            pcall(function()
                local cur = statValFunc() or 0
                local d = cur - lastVal
                if d > 0 then gained = gained + d end
                lastVal = cur
                local e  = tick() - startTime
                local dy = math.floor(e / 86400)
                local hr = math.floor((e % 86400) / 3600)
                local mn = math.floor((e % 3600) / 60)
                local sc = math.floor(e % 60)
                timeLabel.Text = string.format("Time:      %dd %dh %dm %ds", dy, hr, mn, sc)
                currLabel.Text = "Current:   " .. AbbrevNumber(cur) .. "  (" .. exactNumber(cur) .. ")"
                gainLabel.Text = "Gained:    +" .. AbbrevNumber(gained) .. "  (" .. exactNumber(gained) .. ")"
                if e >= 5 and gained > 0 then
                    local ps = gained / e
                    perMinLabel.Text  = "Per Min:   " .. exactNumber(math.floor(ps*60))     .. "  (" .. AbbrevNumber(math.floor(ps*60))     .. ")"
                    perHrLabel.Text   = "Per Hour:  " .. exactNumber(math.floor(ps*3600))   .. "  (" .. AbbrevNumber(math.floor(ps*3600))   .. ")"
                    perDayLabel.Text  = "Per Day:   " .. exactNumber(math.floor(ps*86400))  .. "  (" .. AbbrevNumber(math.floor(ps*86400))  .. ")"
                    perWkLabel.Text   = "Per Week:  " .. exactNumber(math.floor(ps*604800)) .. "  (" .. AbbrevNumber(math.floor(ps*604800)) .. ")"
                    projHrLabel.Text  = "Per Hour:  " .. AbbrevNumber(math.floor(ps*3600))
                    projDayLabel.Text = "Per Day:   " .. AbbrevNumber(math.floor(ps*86400))
                elseif e < 5 then
                    perMinLabel.Text  = "Per Min:   Calculating..."
                    perHrLabel.Text   = "Per Hour:  Calculating..."
                    perDayLabel.Text  = "Per Day:   Calculating..."
                    perWkLabel.Text   = "Per Week:  Calculating..."
                    projHrLabel.Text  = "Per Hour:  -"
                    projDayLabel.Text = "Per Day:   -"
                end
            end)
        end
    end)
end

getgenv().blockRebirthEnabled = false
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if getgenv().blockRebirthEnabled and (method == "FireServer" or method == "InvokeServer") then
        if string.find(string.lower(self.Name), "rebirth") then return nil end
    end
    return oldNamecall(self, ...)
end)

-- ================= FARM TAB =================
do
    addBodoniLabel(mainTab, "FARMING TOOLS:", Color3.fromRGB(255, 215, 0))
    mainTab:AddSwitch("Auto Spin Wheel", function(state) isapin = state end)
    mainTab:AddSwitch("Anti AFK", function(state)
        if state then
            if antiAFKConnection then antiAFKConnection:Disconnect() end
            antiAFKConnection = Player.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        else
            if antiAFKConnection then antiAFKConnection:Disconnect() antiAFKConnection = nil end
        end
    end)

    local antiLagRunning = false
    local antiLagSky     = nil

    local function applyDarkLighting()
        local L = game:GetService("Lighting")
        L.GlobalShadows = false L.Brightness = 0 L.ClockTime = 0 L.TimeOfDay = "00:00:00"
        L.OutdoorAmbient = Color3.new(0,0,0) L.Ambient = Color3.new(0,0,0)
        L.FogColor = Color3.new(0,0,0) L.FogEnd = 100
        for _, v in ipairs(L:GetChildren()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect")
            or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Atmosphere") then
                v.Enabled = false
            end
        end
    end

    local function startAntiLag()
        antiLagRunning = true
        local L = game:GetService("Lighting")
        savedLighting.GlobalShadows  = L.GlobalShadows
        savedLighting.Brightness     = L.Brightness
        savedLighting.FogEnd         = L.FogEnd
        savedLighting.Ambient        = L.Ambient
        savedLighting.OutdoorAmbient = L.OutdoorAmbient
        savedLighting.TimeOfDay      = L.TimeOfDay
        for _, v in pairs(L:GetChildren()) do if v:IsA("Sky") then v:Destroy() end end
        local sky = Instance.new("Sky") sky.Name = "DarkSky"
        for _, f in pairs({"Bk","Dn","Ft","Lf","Rt","Up"}) do sky["Skybox"..f] = "rbxassetid://0" end
        sky.Parent = L antiLagSky = sky applyDarkLighting()
        for _, o in pairs(workspace:GetDescendants()) do
            if o:IsA("ParticleEmitter") or o:IsA("PointLight") or o:IsA("SpotLight") or o:IsA("SurfaceLight") then
                pcall(function() o:Destroy() end)
            end
        end
        pcall(function() settings().Rendering.QualityLevel = 1 end)
        task.spawn(function()
            while antiLagRunning do
                task.wait(5) if not antiLagRunning then break end
                pcall(function()
                    local l = game:GetService("Lighting")
                    if not l:FindFirstChild("DarkSky") then antiLagSky:Clone().Parent = l end
                    applyDarkLighting()
                end)
            end
        end)
    end

    local function stopAntiLag()
        antiLagRunning = false
        pcall(function()
            local L = game:GetService("Lighting")
            local ds = L:FindFirstChild("DarkSky") if ds then ds:Destroy() end
            L.GlobalShadows  = savedLighting.GlobalShadows or true
            L.Brightness     = savedLighting.Brightness or 2
            L.FogEnd         = savedLighting.FogEnd or 100000
            L.Ambient        = savedLighting.Ambient or Color3.fromRGB(70,70,70)
            L.OutdoorAmbient = savedLighting.OutdoorAmbient or Color3.fromRGB(70,70,70)
            L.TimeOfDay      = savedLighting.TimeOfDay or "14:00:00"
            for _, v in ipairs(L:GetChildren()) do
                if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect")
                or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Atmosphere") then
                    v.Enabled = true
                end
            end
        end)
        pcall(function() settings().Rendering.QualityLevel = 10 end)
    end

    mainTab:AddSwitch("Anti Lag", function(state) if state then startAntiLag() else stopAntiLag() end end)

    mainTab:AddSwitch("Hide Frames", function(state)
        pcall(function()
            local pg = Player:FindFirstChild("PlayerGui")
            if pg then
                for _, gui in pairs(pg:GetChildren()) do
                    pcall(function()
                        if gui.Name:lower():find("headset") or gui.Name:lower():find("vr") then return end
                        if (gui:IsA("ScreenGui") or gui:IsA("BillboardGui")) and gui.Name ~= "K13Watermark" then
                            gui.Enabled = not state
                        end
                    end)
                end
            end
        end)
    end)

    addBodoniLabel(mainTab, "OTHER:", Color3.fromRGB(100, 200, 255))

    mainTab:AddSwitch("Lock Position", function(Value)
        if Value then
            local currentPos = Player.Character.HumanoidRootPart.CFrame
            getgenv().posLock = RunService.Heartbeat:Connect(function()
                if Player.Character:FindFirstChild("HumanoidRootPart") then
                    Player.Character.HumanoidRootPart.CFrame = currentPos
                end
            end)
        else
            if getgenv().posLock then getgenv().posLock:Disconnect() getgenv().posLock = nil end
        end
    end)

    local noclipConn
    mainTab:AddSwitch("No Clip", function(Value)
        if Value then
            noclipConn = RunService.Stepped:Connect(function()
                local char = Player.Character
                if char then for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
            end)
        else
            if noclipConn then noclipConn:Disconnect() noclipConn = nil end
            local char = Player.Character
            if char then for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = true end end end
        end
    end)

    local speedValue = 16
    local speedLabel = addBodoniLabel(mainTab, "Walk Speed: 16")
    speedLabel.TextSize = 16
    mainTab:AddTextBox("Set Speed (default 16)", function(Value)
        local num = tonumber(Value)
        if num then
            speedValue = num speedLabel.Text = "Walk Speed: " .. num
            local char = Player.Character
            if char then local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = num end end
        end
    end, {clear=false})
    mainTab:AddSwitch("Set Speed", function(State)
        local char = Player.Character
        if char then local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = State and speedValue or 16 end end
    end)

    local jumpValue = 50
    local jumpLabel = addBodoniLabel(mainTab, "Jump Power: 50")
    jumpLabel.TextSize = 16
    mainTab:AddTextBox("Set Jump Power (default 50)", function(Value)
        local num = tonumber(Value)
        if num then
            jumpValue = num jumpLabel.Text = "Jump Power: " .. num
            local char = Player.Character
            if char then local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.JumpPower = num end end
        end
    end, {clear=false})
    mainTab:AddSwitch("Set Jump", function(State)
        local char = Player.Character
        if char then local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.JumpPower = State and jumpValue or 50 end end
    end)

    addBodoniLabel(mainTab, "CHANGE TIME:", Color3.fromRGB(255, 140, 0))

    local timeSettings = {
        ["Dawn Mist"]          = {time="04:45:00",brightness=0.4, ambient=Color3.fromRGB(110,130,190),outdoor=Color3.fromRGB(90,110,170), fogEnd=300,  fogStart=0,   fogColor=Color3.fromRGB(160,175,220),bloom={intensity=1.2,size=30,threshold=0.9}, sunrays={intensity=0.2,spread=0.4},cc={saturation=-0.1,contrast=0.05,brightness=0.02}},
        ["Sunrise Glow"]       = {time="06:10:00",brightness=1.3, ambient=Color3.fromRGB(255,210,160),outdoor=Color3.fromRGB(255,190,130),fogEnd=500,  fogStart=50,  fogColor=Color3.fromRGB(255,210,170),bloom={intensity=2.5,size=40,threshold=0.85},sunrays={intensity=1.0,spread=0.6},cc={saturation=0.3, contrast=0.12,brightness=0.05}},
        ["Golden Hour"]        = {time="07:15:00",brightness=2.2, ambient=Color3.fromRGB(255,175,90), outdoor=Color3.fromRGB(255,155,70), fogEnd=450,  fogStart=30,  fogColor=Color3.fromRGB(255,185,110),bloom={intensity=3,  size=56,threshold=0.8}, sunrays={intensity=1.3,spread=0.7},cc={saturation=0.5, contrast=0.18,brightness=0.08}},
        ["Soft Morning"]       = {time="09:00:00",brightness=2.3, ambient=Color3.fromRGB(210,220,240),outdoor=Color3.fromRGB(200,215,235),fogEnd=2500, fogStart=200, fogColor=Color3.fromRGB(215,225,245),bloom={intensity=0.8,size=24,threshold=0.92},sunrays={intensity=0.4,spread=0.5},cc={saturation=0.15,contrast=0.08,brightness=0.03}},
        ["Crystal Noon"]       = {time="12:00:00",brightness=3,   ambient=Color3.fromRGB(215,220,240),outdoor=Color3.fromRGB(205,215,235),fogEnd=4000, fogStart=500, fogColor=Color3.fromRGB(220,230,250),bloom={intensity=0.6,size=20,threshold=0.95},sunrays={intensity=0.15,spread=0.3},cc={saturation=0.1, contrast=0.2, brightness=0.0}},
        ["Warm Afternoon"]     = {time="14:30:00",brightness=2.7, ambient=Color3.fromRGB(235,210,175),outdoor=Color3.fromRGB(225,200,165),fogEnd=3000, fogStart=300, fogColor=Color3.fromRGB(235,215,185),bloom={intensity=0.9,size=24,threshold=0.92},sunrays={intensity=0.3,spread=0.4},cc={saturation=0.2, contrast=0.12,brightness=0.02}},
        ["Late Afternoon Haze"]= {time="16:00:00",brightness=2.0, ambient=Color3.fromRGB(245,200,130),outdoor=Color3.fromRGB(240,185,115),fogEnd=800,  fogStart=50,  fogColor=Color3.fromRGB(245,205,145),bloom={intensity=1.8,size=36,threshold=0.85},sunrays={intensity=0.9,spread=0.6},cc={saturation=0.35,contrast=0.15,brightness=0.05}},
        ["Magic Hour"]         = {time="17:00:00",brightness=1.9, ambient=Color3.fromRGB(255,165,95), outdoor=Color3.fromRGB(255,145,75), fogEnd=400,  fogStart=20,  fogColor=Color3.fromRGB(255,175,110),bloom={intensity=2.8,size=48,threshold=0.8}, sunrays={intensity=1.4,spread=0.75},cc={saturation=0.55,contrast=0.2, brightness=0.08}},
        ["Sunset Blaze"]       = {time="17:50:00",brightness=1.5, ambient=Color3.fromRGB(255,120,60), outdoor=Color3.fromRGB(255,100,40), fogEnd=350,  fogStart=10,  fogColor=Color3.fromRGB(255,130,70), bloom={intensity=3.5,size=56,threshold=0.75},sunrays={intensity=1.6,spread=0.85},cc={saturation=0.65,contrast=0.22,brightness=0.1}},
        ["Sunset Fade"]        = {time="18:20:00",brightness=1.0, ambient=Color3.fromRGB(220,130,100),outdoor=Color3.fromRGB(200,110,80), fogEnd=500,  fogStart=20,  fogColor=Color3.fromRGB(220,140,110),bloom={intensity=2.5,size=44,threshold=0.82},sunrays={intensity=0.8,spread=0.6},cc={saturation=0.45,contrast=0.18,brightness=0.06}},
        ["Dusk Purple"]        = {time="18:50:00",brightness=0.5, ambient=Color3.fromRGB(160,90,150), outdoor=Color3.fromRGB(140,70,130), fogEnd=600,  fogStart=30,  fogColor=Color3.fromRGB(170,100,160),bloom={intensity=1.8,size=36,threshold=0.85},sunrays={intensity=0.3,spread=0.4},cc={saturation=0.35,contrast=0.15,brightness=0.03}},
        ["Blue Hour"]          = {time="19:10:00",brightness=0.3, ambient=Color3.fromRGB(55,75,175),  outdoor=Color3.fromRGB(45,65,165),  fogEnd=500,  fogStart=20,  fogColor=Color3.fromRGB(65,85,185),  bloom={intensity=1.5,size=32,threshold=0.88},sunrays={intensity=0.05,spread=0.2},cc={saturation=0.25,contrast=0.12,brightness=0.02}},
        ["Twilight Dream"]     = {time="19:50:00",brightness=0.18,ambient=Color3.fromRGB(65,50,120),  outdoor=Color3.fromRGB(55,40,110),  fogEnd=700,  fogStart=50,  fogColor=Color3.fromRGB(70,55,130),  bloom={intensity=1.2,size=28,threshold=0.9}, sunrays={intensity=0,spread=0},   cc={saturation=0.15,contrast=0.1, brightness=0.01}},
        ["City Night"]         = {time="21:00:00",brightness=0.08,ambient=Color3.fromRGB(35,40,80),   outdoor=Color3.fromRGB(28,33,70),   fogEnd=1000, fogStart=100, fogColor=Color3.fromRGB(25,30,60),   bloom={intensity=2.0,size=40,threshold=0.7}, sunrays={intensity=0,spread=0},   cc={saturation=-0.1,contrast=0.08,brightness=0.0}},
        ["Starry Night"]       = {time="22:00:00",brightness=0.06,ambient=Color3.fromRGB(20,25,55),   outdoor=Color3.fromRGB(15,20,48),   fogEnd=2000, fogStart=200, fogColor=Color3.fromRGB(12,16,40),   bloom={intensity=1.5,size=36,threshold=0.65},sunrays={intensity=0,spread=0},   cc={saturation=-0.2,contrast=0.06,brightness=-0.01}},
        ["Deep Midnight"]      = {time="00:00:00",brightness=0.03,ambient=Color3.fromRGB(10,12,30),   outdoor=Color3.fromRGB(8,10,25),    fogEnd=2500, fogStart=300, fogColor=Color3.fromRGB(6,8,20),     bloom={intensity=1.0,size=28,threshold=0.6}, sunrays={intensity=0,spread=0},   cc={saturation=-0.4,contrast=0.05,brightness=-0.02}},
        ["Moonlit Night"]      = {time="01:00:00",brightness=0.07,ambient=Color3.fromRGB(70,80,130),  outdoor=Color3.fromRGB(60,70,120),  fogEnd=1500, fogStart=150, fogColor=Color3.fromRGB(55,65,110),  bloom={intensity=1.8,size=40,threshold=0.75},sunrays={intensity=0,spread=0},   cc={saturation=-0.15,contrast=0.08,brightness=0.01}},
        ["Pre Dawn Blue"]      = {time="04:10:00",brightness=0.25,ambient=Color3.fromRGB(85,100,170), outdoor=Color3.fromRGB(75,90,160),  fogEnd=800,  fogStart=50,  fogColor=Color3.fromRGB(95,110,180), bloom={intensity=0.9,size=24,threshold=0.92},sunrays={intensity=0.1,spread=0.3},cc={saturation=-0.05,contrast=0.06,brightness=0.01}},
    }

    local function applyTimeSettings(name)
        local s = timeSettings[name] if not s then return end
        pcall(function()
            local L = game:GetService("Lighting")
            L.TimeOfDay = s.time L.Brightness = s.brightness L.Ambient = s.ambient
            L.OutdoorAmbient = s.outdoor L.FogEnd = s.fogEnd L.FogStart = s.fogStart L.FogColor = s.fogColor
            local bloom = L:FindFirstChildOfClass("BloomEffect")
            if not bloom then bloom = Instance.new("BloomEffect") bloom.Parent = L end
            bloom.Intensity = s.bloom.intensity bloom.Size = s.bloom.size bloom.Threshold = s.bloom.threshold
            local sunrays = L:FindFirstChildOfClass("SunRaysEffect")
            if not sunrays then sunrays = Instance.new("SunRaysEffect") sunrays.Parent = L end
            sunrays.Intensity = s.sunrays.intensity sunrays.Spread = s.sunrays.spread
            local cc = L:FindFirstChildOfClass("ColorCorrectionEffect")
            if not cc then cc = Instance.new("ColorCorrectionEffect") cc.Parent = L end
            cc.Saturation = s.cc.saturation cc.Contrast = s.cc.contrast cc.Brightness = s.cc.brightness
            local atmo = L:FindFirstChildOfClass("Atmosphere")
            if not atmo then atmo = Instance.new("Atmosphere") atmo.Parent = L end
            if name=="Golden Hour" or name=="Magic Hour" or name=="Sunset Blaze" then
                atmo.Density=0.4 atmo.Offset=0.25 atmo.Color=Color3.fromRGB(255,180,120) atmo.Decay=Color3.fromRGB(200,120,80) atmo.Glare=0.3 atmo.Haze=2.5
            elseif name=="Sunrise Glow" then
                atmo.Density=0.35 atmo.Offset=0.2 atmo.Color=Color3.fromRGB(255,210,160) atmo.Decay=Color3.fromRGB(220,160,100) atmo.Glare=0.25 atmo.Haze=2.0
            elseif name=="Crystal Noon" or name=="Soft Morning" then
                atmo.Density=0.15 atmo.Offset=0.1 atmo.Color=Color3.fromRGB(200,215,240) atmo.Decay=Color3.fromRGB(160,180,210) atmo.Glare=0.1 atmo.Haze=1.0
            elseif name=="Blue Hour" or name=="Twilight Dream" or name=="Dusk Purple" then
                atmo.Density=0.5 atmo.Offset=0.3 atmo.Color=Color3.fromRGB(60,80,180) atmo.Decay=Color3.fromRGB(100,60,130) atmo.Glare=0.05 atmo.Haze=3.0
            elseif name=="Starry Night" or name=="Deep Midnight" or name=="Moonlit Night" then
                atmo.Density=0.2 atmo.Offset=0.1 atmo.Color=Color3.fromRGB(10,15,40) atmo.Decay=Color3.fromRGB(8,10,25) atmo.Glare=0 atmo.Haze=1.5
            elseif name=="Dawn Mist" or name=="Pre Dawn Blue" then
                atmo.Density=0.6 atmo.Offset=0.35 atmo.Color=Color3.fromRGB(120,140,200) atmo.Decay=Color3.fromRGB(80,100,160) atmo.Glare=0.15 atmo.Haze=3.5
            else
                atmo.Density=0.3 atmo.Offset=0.15 atmo.Color=Color3.fromRGB(180,190,210) atmo.Decay=Color3.fromRGB(140,150,170) atmo.Glare=0.1 atmo.Haze=1.8
            end
        end)
    end

    local timeDD = mainTab:AddDropdown("Select Time", function(s) applyTimeSettings(s) end)
    for _, n in ipairs({"Dawn Mist","Sunrise Glow","Golden Hour","Soft Morning","Crystal Noon","Warm Afternoon","Late Afternoon Haze","Magic Hour","Sunset Blaze","Sunset Fade","Dusk Purple","Blue Hour","Twilight Dream","City Night","Starry Night","Deep Midnight","Moonlit Night","Pre Dawn Blue"}) do
        timeDD:Add(n)
    end
end

-- ================= STRENGTH TAB =================
do
    addBodoniLabel(strengthTab, "FARMING TOOLS:", Color3.fromRGB(255, 80, 80))
    strengthTab:AddSwitch("Auto Strength", function(state) isAutolift = state end)
    addBodoniLabel(strengthTab, "STRENGTH CALCULATOR", Color3.fromRGB(255, 60, 60))
    makeCalcSection(strengthTab, "STR", function() return tonumber(strong.Value) or 0 end)
end

-- ================= REBIRTH TAB =================
do
    addBodoniLabel(rebirthTab, "AUTO REBIRTH:", Color3.fromRGB(180, 0, 255))
    rebirthTab:AddSwitch("Auto Rebirth", function(state)
        isAuto = state
        if isAuto then pcall(function() remoterebirths:FireServer() end) end
    end)
    rebirthTab:AddSwitch("Block Rebirth", function(Value) getgenv().blockRebirthEnabled = Value end)
    addBodoniLabel(rebirthTab, "REBIRTH CALCULATOR", Color3.fromRGB(160, 0, 220))
    makeCalcSection(rebirthTab, "REB", function() return tonumber(rebirthValObj and rebirthValObj.Value) or 0 end)
end

-- ================= GLITCH TAB =================
do
    addBodoniLabel(glitchTab, "FARMING TOOLS:", Color3.fromRGB(0, 255, 180))
    glitchTab:AddSwitch("Auto Glitch", function(state) isAutoGlitch = state end)
    addBodoniLabel(glitchTab, "ENDURANCE CALCULATOR", Color3.fromRGB(0, 220, 150))
    makeCalcSection(glitchTab, "END", function() return tonumber(endurValObj and endurValObj.Value) or 0 end)
end

-- ================= PETS TAB =================
do
    addBodoniLabel(petsTab, "AUTO HATCH:", Color3.fromRGB(255, 180, 50))
    local eggDD = petsTab:AddDropdown("Select Egg", function(selected)
        local folder = labelToFolder[selected]
        if folder then selectedEggFolder = folder teleportToEgg(folder) end
    end)
    for _, d in ipairs(EGG_DATA) do eggDD:Add(d.label) end
    petsTab:AddSwitch("Auto Hatch", function(state)
        isAutoHatch = state
        if state then teleportToEgg(selectedEggFolder) end
    end)

    addBodoniLabel(petsTab, "AUTO SELL:", Color3.fromRGB(255, 100, 180))
    local rarityGroups = {
        {label="COMMON EGG",    idx=1, color=Color3.fromRGB(180,180,180)},
        {label="RARE EGG",      idx=2, color=Color3.fromRGB(0,150,255)},
        {label="EPIC EGG",      idx=3, color=Color3.fromRGB(160,0,255)},
        {label="LEGENDARY EGG", idx=4, color=Color3.fromRGB(255,165,0)},
        {label="MYTHIC EGG",    idx=5, color=Color3.fromRGB(255,50,50)},
        {label="MASTERS EGG",   idx=6, color=Color3.fromRGB(255,215,0)},
    }
    for _, grp in ipairs(rarityGroups) do
        addBodoniLabel(petsTab, grp.label, grp.color)
        for _, petName in ipairs(EGG_DATA[grp.idx].pets) do
            local pn = petName
            petsTab:AddSwitch("SELL " .. pn, function(state) selectedSellPets[pn] = state or nil end)
        end
    end
    petsTab:AddSwitch("Auto Sell", function(state) isAutoSell = state end)
end

-- ================= MISC TAB =================
do
    addBodoniLabel(miscTab, "AUTO CLAIM CHEST:", Color3.fromRGB(255, 200, 0))
    miscTab:AddSwitch("Auto Claim All Chest", function(state) isAutoChest = state end)

    addBodoniLabel(miscTab, "AUTO CLAIM REWARDS:", Color3.fromRGB(0, 255, 100))
    miscTab:AddSwitch("Auto Claim Rewards", function(state)
        isAutoRewards = state
        if state then claimAllRewards() end
    end)

    addBodoniLabel(miscTab, "HIDE AND SHOW PETS:", Color3.fromRGB(100, 180, 255))
    miscTab:AddButton("Hide Pets", function() pcall(function() HidePetsEvent:FireServer(true) end) end)
    miscTab:AddButton("Show Pets", function() pcall(function() HidePetsEvent:FireServer(false) end) end)

    addBodoniLabel(miscTab, "HIDE NAME & HEALTH:", Color3.fromRGB(255, 100, 180))
    miscTab:AddSwitch("Hide My Name & Health", function(state)
        isHideNameHealth = state
        local char = Player.Character
        if char then
            if state then
                applyHideNameHealth(char)
                if getgenv().hideLoop then getgenv().hideLoop:Disconnect() end
                getgenv().hideLoop = RunService.Heartbeat:Connect(function()
                    if not isHideNameHealth then
                        getgenv().hideLoop:Disconnect()
                        getgenv().hideLoop = nil
                        return
                    end
                    pcall(function()
                        local c = Player.Character
                        if not c then return end
                        local hum = c:FindFirstChildOfClass("Humanoid")
                        if hum then
                            if hum.NameDisplayDistance ~= 0 then
                                hum.NameDisplayDistance = 0
                                hum.HealthDisplayDistance = 0
                                hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                                hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
                            end
                        end
                    end)
                end)
            else
                resetNameHealth(char)
            end
        end
    end)
end

do
    addBodoniLabel(tpTab, "TELEPORT ISLANDS:", Color3.fromRGB(0, 200, 255))
    for _, island in ipairs(ISLANDS) do
        local pos = island.pos
        tpTab:AddButton(island.name, function() teleportTo(pos) end)
    end

    addBodoniLabel(tpTab, "TELEPORT CHESTS:", Color3.fromRGB(255, 215, 0))
    for _, chest in ipairs(CHESTS) do
        local pos = chest.pos
        tpTab:AddButton(chest.name, function() teleportTo(pos) end)
    end
end

-- ================= KILL TAB =================
do
    killTab:AddButton("STOP TELEPORT", function() isSticking = false end)

    addBodoniLabel(killTab, "AUTO FAST PUNCH:", Color3.fromRGB(255, 50, 50))
    killTab:AddSwitch("AUTO FAST PUNCH", function(state) isAutoPunch = state end)

    addBodoniLabel(killTab, "AUTO KILL EVERYONE:", Color3.fromRGB(220, 0, 0))
    killTab:AddSwitch("AUTO KILL EVERYONE", function(state) isAutoKillAll = state end)

    addBodoniLabel(killTab, "TINY SIZE COMBO:", Color3.fromRGB(255, 100, 220))
    killTab:AddSwitch("Tiny Size Combo", function(state)
        isTinyCombo = state
        if state then setCharSize(0.001) isSticking = true isAutoPunch = true
        else setCharSize(1) isSticking = false isAutoPunch = false end
    end)

    addBodoniLabel(killTab, "FRIEND WHITELIST:", Color3.fromRGB(80, 255, 120))
    killTab:AddButton("Whitelist Friends", function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Player and Player:IsFriendsWith(plr.UserId) then
                whitelist[plr.UserId] = plr.DisplayName
            end
        end
        Players.PlayerAdded:Connect(function(plr)
            if Player:IsFriendsWith(plr.UserId) then whitelist[plr.UserId] = plr.DisplayName end
        end)
    end)
    killTab:AddButton("Remove Whitelist Friends", function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Player and Player:IsFriendsWith(plr.UserId) then whitelist[plr.UserId] = nil end
        end
    end)
    killTab:AddButton("Clear All Whitelist", function() whitelist = {} end)

    local killSpyLabels = {}
    local function clearKillSpy()
        for _, lbl in pairs(killSpyLabels) do pcall(function() lbl:Destroy() end) end
        killSpyLabels = {}
    end
    local function showKillPlayerStats(plr)
        clearKillSpy()
        local function addStat(text)
            local lbl = killTab:AddLabel(text)
            lbl.Font = Enum.Font.Bodoni
            local s = Instance.new("UIStroke") s.Thickness=0.5 s.Color=Color3.fromRGB(255,255,255) s.Parent=lbl
            table.insert(killSpyLabels, lbl)
        end
        local function getVal(name, folder)
            local src = folder and plr:FindFirstChild(folder) or plr
            local v = src and src:FindFirstChild(name)
            return v and v.Value or nil
        end
        pcall(function()
            addStat(plr.DisplayName)
            for _, s in ipairs({
                {name="Strong",    label="Strength:",  folder="leaderstats"},
                {name="Rebirths",  label="Rebirths:",  folder="leaderstats"},
                {name="Kills",     label="Kills:",     folder="leaderstats"},
                {name="Endurance", label="Endurance:", folder=nil},
                {name="Mobility",  label="Mobility:",  folder=nil},
            }) do
                local val = getVal(s.name, s.folder)
                if val ~= nil then addStat(s.label .. "  " .. formatNumber(val)) end
            end
        end)
    end

    addBodoniLabel(killTab, "SELECT PLAYER TO KILL:", Color3.fromRGB(255, 80, 80))
    local playerDD = killTab:AddDropdown("Select Player", function(selected)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.DisplayName == selected and plr ~= Player then
                selectedTarget = plr isSticking = true showKillPlayerStats(plr) break
            end
        end
    end)
    task.spawn(function()
        task.wait(2)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Player then pcall(function() playerDD:Add(plr.DisplayName) end) end
        end
    end)
    Players.PlayerAdded:Connect(function(plr) task.wait(0.5) pcall(function() playerDD:Add(plr.DisplayName) end) end)
    Players.PlayerRemoving:Connect(function(plr)
        if selectedTarget == plr then selectedTarget = nil isSticking = false clearKillSpy() end
        pcall(function() playerDD:Remove(plr.DisplayName) end)
    end)

    addBodoniLabel(killTab, "SPECTATE PLAYER:", Color3.fromRGB(100, 200, 255))
    local specDD = killTab:AddDropdown("Choose Player", function(selected)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.DisplayName == selected then
                selectedPlayerToSpectate = plr
                if spectating then updateSpectateTarget(plr) end
                break
            end
        end
    end)
    task.spawn(function()
        task.wait(2)
        for _, plr in ipairs(Players:GetPlayers()) do pcall(function() specDD:Add(plr.DisplayName) end) end
    end)
    Players.PlayerAdded:Connect(function(plr) task.wait(0.5) pcall(function() specDD:Add(plr.DisplayName) end) end)
    Players.PlayerRemoving:Connect(function(plr)
        if selectedPlayerToSpectate == plr then selectedPlayerToSpectate = nil end
        pcall(function() specDD:Remove(plr.DisplayName) end)
    end)
    killTab:AddSwitch("Spectate", function(bool)
        spectating = bool
        if spectating and selectedPlayerToSpectate then
            updateSpectateTarget(selectedPlayerToSpectate)
        else
            if currentTargetConnection then currentTargetConnection:Disconnect() currentTargetConnection = nil end
            if Player.Character then
                local hum = Player.Character:FindFirstChildOfClass("Humanoid")
                if hum then camera.CameraSubject = hum end
            end
        end
    end)
end

-- ================= SPY TAB =================
do
    local spyStatLabels = {}
    local spyConnections = {}

    local function clearSpyStats()
        for _, c in pairs(spyConnections) do c:Disconnect() end
        spyConnections = {}
        for _, lbl in pairs(spyStatLabels) do pcall(function() lbl:Remove() end) end
        spyStatLabels = {}
    end

    local function showPlayerStats(plr)
        clearSpyStats()
        local function addStat(text, size, color)
            local lbl = spyTab:AddLabel(text)
            lbl.Font = Enum.Font.Bodoni
            lbl.TextSize = size or 15
            if color then lbl.TextColor3 = color end
            local s = Instance.new("UIStroke")
            s.Thickness = 0.5
            s.Color = color or Color3.fromRGB(255,255,255)
            s.Parent = lbl
            table.insert(spyStatLabels, lbl)
            return lbl
        end
        local function getStatObj(name, folder)
            local src = folder and plr:FindFirstChild(folder) or plr
            return src and src:FindFirstChild(name)
        end

        pcall(function()
            addStat("Player:   " .. plr.DisplayName .. " (@" .. plr.Name .. ")", 16)
            addStat("Device:   " .. tostring(plr:FindFirstChild("Device") and plr.Device.Value or "Unknown"), 15)
            addStat("Premium:  " .. tostring(plr:FindFirstChild("IsPremium") and plr.IsPremium.Value or false), 15)
            addStat("STATS:", 16, Color3.fromRGB(200,150,255))

            pcall(function()
                local tc = plr.Character
                if tc then
                    local hum = tc:FindFirstChildOfClass("Humanoid")
                    if hum then
                        local maxHP = hum.MaxHealth
                        local function formatHP(cur, max)
                            return string.format("Health:  %s / %s", formatNumber(cur), formatNumber(max))
                        end
                        local function getHealthColor(cur, max)
                            local pct = math.clamp(cur/math.max(max,1), 0, 1)
                            if pct > 0.6 then return Color3.fromRGB(80,255,80)
                            elseif pct > 0.3 then return Color3.fromRGB(255,200,0)
                            else return Color3.fromRGB(255,60,60) end
                        end
                        local healthLbl = addStat(formatHP(hum.Health, maxHP), 15)
                        healthLbl.TextColor3 = getHealthColor(hum.Health, maxHP)
                        local conn = hum:GetPropertyChangedSignal("Health"):Connect(function()
                            pcall(function()
                                local curHP = hum.Health
                                healthLbl.Text = formatHP(curHP, maxHP)
                                healthLbl.TextColor3 = getHealthColor(curHP, maxHP)
                            end)
                        end)
                        table.insert(spyConnections, conn)
                    end
                end
            end)

            for _, s in ipairs({
                {name="Strong",            label="Strength:",     folder="leaderstats"},
                {name="Endurance",         label="Endurance:",    folder=nil},
                {name="Mobility",          label="Mobility:",     folder=nil},
                {name="Rebirths",          label="Rebirths:",     folder="leaderstats"},
                {name="Kills",             label="Kills:",        folder="leaderstats"},
                {name="Coins",             label="Coins:",        folder=nil},
                {name="Spins",             label="Spins:",        folder=nil},
                {name="MuscleEmperorReps", label="Emperor Reps:", folder=nil},
            }) do
                local statObj = getStatObj(s.name, s.folder)
                if statObj then
                    local lbl = addStat(s.label .. "  " .. formatNumber(statObj.Value), 15)
                    local conn = statObj.Changed:Connect(function(v) lbl.Text = s.label .. "  " .. formatNumber(v) end)
                    table.insert(spyConnections, conn)
                end
            end

            local petsFolder = plr:FindFirstChild("PetsFolder")
            if petsFolder then
                local petCount = {}
                for _, pet in ipairs(petsFolder:GetChildren()) do petCount[pet.Name] = (petCount[pet.Name] or 0) + 1 end
                local total = 0
                for _, c in pairs(petCount) do total = total + c end
                if total > 0 then
                    addStat("PETS: (" .. total .. ")", 16, Color3.fromRGB(200,150,255))
                    for name, count in pairs(petCount) do
                        addStat(name .. (count > 1 and "  x" .. count or ""), 15)
                    end
                end
            end
        end)
    end

    addBodoniLabel(spyTab, "SELECT PLAYER:", Color3.fromRGB(200, 150, 255))
    local spyDD = spyTab:AddDropdown("SELECT PLAYER", function(selected)
        task.spawn(function()
            task.wait(0.1)
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.DisplayName == selected then selectedSpyPlayer = plr showPlayerStats(plr) break end
            end
        end)
    end)
    task.spawn(function()
        task.wait(2)
        for _, plr in ipairs(Players:GetPlayers()) do pcall(function() spyDD:Add(plr.DisplayName) end) end
    end)
    Players.PlayerAdded:Connect(function(plr) task.wait(0.5) pcall(function() spyDD:Add(plr.DisplayName) end) end)
    Players.PlayerRemoving:Connect(function(plr)
        if selectedSpyPlayer == plr then
            clearSpyStats()
            local lbl = spyTab:AddLabel(plr.DisplayName .. " left the game!")
            lbl.Font = Enum.Font.Bodoni
            local s = Instance.new("UIStroke") s.Thickness=0.5 s.Color=Color3.fromRGB(255,255,255) s.Parent=lbl
            table.insert(spyStatLabels, lbl)
            selectedSpyPlayer = nil
        end
        pcall(function() spyDD:Remove(plr.DisplayName) end)
    end)
end

-- ================= STATS TAB =================
do
    addBodoniLabel(calcTab, "OVERALL SESSION STATS:", Color3.fromRGB(255, 215, 0))
    addBodoniLabel(calcTab, "SESSION:", Color3.fromRGB(100, 220, 255))

    local stopwatchLabel = calcTab:AddLabel("Time:      0d 0h 0m 0s")
    stopwatchLabel.Font = Enum.Font.Bodoni
    local s0 = Instance.new("UIStroke") s0.Thickness=0.5 s0.Color=Color3.fromRGB(255,255,255) s0.Parent=stopwatchLabel

    addBodoniLabel(calcTab, "CURRENT + GAINED:", Color3.fromRGB(0, 255, 150))

    local strengthLabel = calcTab:AddLabel("Strength:  -")
    strengthLabel.Font = Enum.Font.Bodoni
    local s1 = Instance.new("UIStroke") s1.Thickness=0.5 s1.Color=Color3.fromRGB(255,255,255) s1.Parent=strengthLabel

    local rebirthsLabel = calcTab:AddLabel("Rebirths:  -")
    rebirthsLabel.Font = Enum.Font.Bodoni
    local s2 = Instance.new("UIStroke") s2.Thickness=0.5 s2.Color=Color3.fromRGB(255,255,255) s2.Parent=rebirthsLabel

    local enduranceLabel = calcTab:AddLabel("Endurance: -")
    enduranceLabel.Font = Enum.Font.Bodoni
    local s3 = Instance.new("UIStroke") s3.Thickness=0.5 s3.Color=Color3.fromRGB(255,255,255) s3.Parent=enduranceLabel

    addBodoniLabel(calcTab, "PROJECTED PER HR AND DAY", Color3.fromRGB(255, 165, 0))

    local projStrLabel = calcTab:AddLabel("Strength:  -")
    projStrLabel.Font = Enum.Font.Bodoni projStrLabel.TextColor3 = Color3.fromRGB(255,165,0)
    local s4 = Instance.new("UIStroke") s4.Thickness=0.5 s4.Color=Color3.fromRGB(255,165,0) s4.Parent=projStrLabel

    local projRebLabel = calcTab:AddLabel("Rebirths:  -")
    projRebLabel.Font = Enum.Font.Bodoni projRebLabel.TextColor3 = Color3.fromRGB(255,165,0)
    local s5 = Instance.new("UIStroke") s5.Thickness=0.5 s5.Color=Color3.fromRGB(255,165,0) s5.Parent=projRebLabel

    local projEndLabel = calcTab:AddLabel("Endurance: -")
    projEndLabel.Font = Enum.Font.Bodoni projEndLabel.TextColor3 = Color3.fromRGB(255,165,0)
    local s6 = Instance.new("UIStroke") s6.Thickness=0.5 s6.Color=Color3.fromRGB(255,165,0) s6.Parent=projEndLabel

    local statsStart = tick()
    local totalStrG, totalRebG, totalEndG = 0, 0, 0
    local lastStr = tonumber(strong.Value) or 0
    local lastReb = rebirthValObj and (tonumber(rebirthValObj.Value) or 0) or 0
    local lastEnd = endurValObj and (tonumber(endurValObj.Value) or 0) or 0

    calcTab:AddButton("Reset Session", function()
        statsStart = tick() totalStrG = 0 totalRebG = 0 totalEndG = 0
        lastStr = tonumber(strong.Value) or 0
        lastReb = rebirthValObj and (tonumber(rebirthValObj.Value) or 0) or 0
        lastEnd = endurValObj and (tonumber(endurValObj.Value) or 0) or 0
        stopwatchLabel.Text = "Time:      0d 0h 0m 0s"
        strengthLabel.Text  = "Strength:  -"
        rebirthsLabel.Text  = "Rebirths:  -"
        enduranceLabel.Text = "Endurance: -"
        projStrLabel.Text   = "Strength:  -"
        projRebLabel.Text   = "Rebirths:  -"
        projEndLabel.Text   = "Endurance: -"
    end)

    task.spawn(function()
        local lastProj = 0
        while task.wait(0.2) do pcall(function()
            local e = tick() - statsStart
            if e >= 1 then
                local dy,hr,mn,sc = math.floor(e/86400),math.floor((e%86400)/3600),math.floor((e%3600)/60),math.floor(e%60)
                stopwatchLabel.Text = string.format("Time:      %dd %dh %dm %ds", dy, hr, mn, sc)
                local cS = tonumber(strong.Value) or 0
                local cR = rebirthValObj and (tonumber(rebirthValObj.Value) or 0) or 0
                local cE = endurValObj and (tonumber(endurValObj.Value) or 0) or 0
                local dS,dR,dE = cS-lastStr, cR-lastReb, cE-lastEnd
                if dS > 0 then totalStrG = totalStrG + dS end
                if dR > 0 then totalRebG = totalRebG + dR end
                if dE > 0 then totalEndG = totalEndG + dE end
                lastStr = cS lastReb = cR lastEnd = cE
                strengthLabel.Text  = "Strength:  " .. AbbrevNumber(cS) .. "  |  +" .. AbbrevNumber(totalStrG)
                rebirthsLabel.Text  = "Rebirths:  " .. AbbrevNumber(cR) .. "  |  +" .. AbbrevNumber(totalRebG)
                enduranceLabel.Text = "Endurance: " .. AbbrevNumber(cE) .. "  |  +" .. AbbrevNumber(totalEndG)
                if tick()-lastProj >= 3 and e >= 5 then
                    lastProj = tick()
                    local ss,rs,es = totalStrG/e, totalRebG/e, totalEndG/e
                    projStrLabel.Text = "Strength:  " .. AbbrevNumber(math.floor(ss*3600)) .. "/h  |  " .. AbbrevNumber(math.floor(ss*86400)) .. "/d"
                    projRebLabel.Text = "Rebirths:  " .. AbbrevNumber(math.floor(rs*3600)) .. "/h  |  " .. AbbrevNumber(math.floor(rs*86400)) .. "/d"
                    projEndLabel.Text = "Endurance: " .. AbbrevNumber(math.floor(es*3600)) .. "/h  |  " .. AbbrevNumber(math.floor(es*86400)) .. "/d"
                end
            end
        end) end
    end)
end

-- ================= INVENTORY TAB =================
do
    addBodoniLabel(invTab, "AUTO EAT CHOCOLATE:", Color3.fromRGB(210, 140, 80))

    local chocoCountLabel = invTab:AddLabel("Chocolates: 0 pcs")
    chocoCountLabel.Font = Enum.Font.Bodoni
    chocoCountLabel.TextSize = 18
    local sc = Instance.new("UIStroke") sc.Thickness=0.5 sc.Color=Color3.fromRGB(210,140,80) sc.Parent=chocoCountLabel
    chocoCountLabel.TextColor3 = Color3.fromRGB(210,140,80)

    invTab:AddSwitch("Auto Eat Chocolate", function(state) isAutoEat = state end)

    task.spawn(function()
        while task.wait(0.5) do pcall(function()
            local count = 0
            local chocoFolder = Player:FindFirstChild("ChocolatesFolder")
            if chocoFolder then
                for _ in pairs(chocoFolder:GetChildren()) do count += 1 end
            end
            chocoCountLabel.Text = "Chocolates:  " .. exactNumber(count) .. " pcs"
        end) end
    end)
end

-- ================= SETTINGS TAB =================
do
    addBodoniLabel(settingsTab, "UI SETTINGS:", Color3.fromRGB(180, 180, 255))
    addBodoniLabel(settingsTab, "BACKGROUND TRANSPARENCY:", Color3.fromRGB(150, 150, 255))

    local transOptions = {"0.0 (Solid)","0.1 (Default)","0.2","0.3","0.5 (Half)","0.8","0.95 (Clear)"}
    local transValues  = {0.0, 0.1, 0.2, 0.3, 0.5, 0.8, 0.95}
    local transDD = settingsTab:AddDropdown("Transparency", function(selected)
        for i, lbl in ipairs(transOptions) do
            if lbl == selected then
                pcall(function()
                    windowFrame.ImageTransparency = transValues[i]
                    local bar = windowFrame:FindFirstChild("Bar")
                    if bar then bar.BackgroundTransparency = transValues[i] end
                    local tabSel = windowFrame:FindFirstChild("TabSelection")
                    if tabSel then tabSel.ImageTransparency = math.min(0.4 + transValues[i], 0.95) end
                    for _, v in pairs(windowFrame:GetDescendants()) do
                        pcall(function()
                            if v:IsA("ImageLabel") and v.Name=="TextButton_Roundify_4px" then
                                if v.Parent and v.Parent.Name ~= "TabButton" then v.ImageTransparency = transValues[i] end
                            end
                            if v:IsA("ImageButton") and v.Name=="Box" then v.ImageTransparency = transValues[i] end
                        end)
                    end
                end)
                break
            end
        end
    end)
    for _, lbl in ipairs(transOptions) do transDD:Add(lbl) end

    addBodoniLabel(settingsTab, "MAIN COLOR THEME:", Color3.fromRGB(255, 100, 220))

    local colorOptions = {
        {name="Purple (Default)", colors={Color3.fromRGB(10,0,40),  Color3.fromRGB(60,0,120),  Color3.fromRGB(120,0,180),  Color3.fromRGB(180,0,255),  Color3.fromRGB(255,50,180)}},
        {name="Red",              colors={Color3.fromRGB(40,0,0),   Color3.fromRGB(120,0,0),   Color3.fromRGB(200,0,0),    Color3.fromRGB(255,50,50),  Color3.fromRGB(255,100,100)}},
        {name="Blue",             colors={Color3.fromRGB(0,0,40),   Color3.fromRGB(0,20,120),  Color3.fromRGB(0,60,200),   Color3.fromRGB(0,100,255),  Color3.fromRGB(50,150,255)}},
        {name="Green",            colors={Color3.fromRGB(0,20,0),   Color3.fromRGB(0,60,0),    Color3.fromRGB(0,120,40),   Color3.fromRGB(0,200,80),   Color3.fromRGB(50,255,120)}},
        {name="Orange",           colors={Color3.fromRGB(40,10,0),  Color3.fromRGB(120,40,0),  Color3.fromRGB(200,80,0),   Color3.fromRGB(255,120,0),  Color3.fromRGB(255,180,50)}},
        {name="Pink",             colors={Color3.fromRGB(40,0,20),  Color3.fromRGB(120,0,60),  Color3.fromRGB(200,0,100),  Color3.fromRGB(255,50,150), Color3.fromRGB(255,100,200)}},
        {name="Gold",             colors={Color3.fromRGB(30,20,0),  Color3.fromRGB(100,70,0),  Color3.fromRGB(180,130,0),  Color3.fromRGB(220,180,0),  Color3.fromRGB(255,215,0)}},
        {name="Cyan",             colors={Color3.fromRGB(0,20,30),  Color3.fromRGB(0,80,100),  Color3.fromRGB(0,150,180),  Color3.fromRGB(0,210,240),  Color3.fromRGB(50,240,255)}},
    }
    local colorDD = settingsTab:AddDropdown("Main Color", function(selected)
        for _, opt in ipairs(colorOptions) do
            if opt.name == selected then
                pcall(function()
                    for _, v in pairs(windowFrame:GetDescendants()) do
                        pcall(function()
                            if v:IsA("Frame") and v.Name=="Bar" then applyGradient(v,opt.colors) end
                            if v:IsA("ImageLabel") and v.Name=="Window" then applyGradient(v,{opt.colors[1],opt.colors[3],opt.colors[5] or opt.colors[#opt.colors]}) end
                            if v:IsA("ImageLabel") and v.Name=="TabSelection" then applyGradient(v,opt.colors) end
                            if v:IsA("ImageLabel") and v.Name=="TextButton_Roundify_4px" then
                                if v.Parent and v.Parent.Name ~= "TabButton" then applyGradient(v,{opt.colors[1],opt.colors[3]}) end
                            end
                            if v:IsA("ImageButton") and v.Name=="Box" then applyGradient(v,{opt.colors[1],opt.colors[2]}) end
                        end)
                    end
                end)
                break
            end
        end
    end)
    for _, opt in ipairs(colorOptions) do colorDD:Add(opt.name) end

    addBodoniLabel(settingsTab, "WATERMARK:", Color3.fromRGB(180, 0, 255))

    local watermark = nil
    settingsTab:AddSwitch("Show Watermark", function(state)
        if state then
            if watermark then return end
            pcall(function()
                local gui = Instance.new("ScreenGui")
                gui.Name = "K13Watermark" gui.ResetOnSpawn = false gui.DisplayOrder = 999 gui.Parent = Player.PlayerGui
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0,220,0,28) frame.Position = UDim2.new(0,8,0,8)
                frame.BackgroundColor3 = Color3.fromRGB(10,0,20) frame.BackgroundTransparency = 0.3
                frame.BorderSizePixel = 0 frame.Parent = gui
                Instance.new("UICorner",frame).CornerRadius = UDim.new(0,6)
                local stroke = Instance.new("UIStroke") stroke.Color = Color3.fromRGB(180,0,255) stroke.Thickness = 1.2 stroke.Parent = frame
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1,0,1,0) label.BackgroundTransparency = 1
                label.Text = "K13 | Muscle Masters" label.Font = Enum.Font.PermanentMarker
                label.TextSize = 13 label.TextColor3 = Color3.fromRGB(200,100,255) label.Parent = frame
                watermark = gui
                task.spawn(function()
                    local hue = 0
                    while watermark and watermark.Parent do
                        hue = (hue + 0.004) % 1
                        pcall(function() label.TextColor3 = Color3.fromHSV(hue,1,1) stroke.Color = Color3.fromHSV(hue,1,1) end)
                        task.wait(0.05)
                    end
                end)
            end)
        else
            if watermark then pcall(function() watermark:Destroy() end) watermark = nil end
        end
    end)

    addBodoniLabel(settingsTab, "RESET:", Color3.fromRGB(255, 80, 80))
    settingsTab:AddButton("Reset All Settings", function()
        pcall(function()
            windowFrame.ImageTransparency = 0.1
            local bar = windowFrame:FindFirstChild("Bar") if bar then bar.BackgroundTransparency = 0 end
            local tabSel = windowFrame:FindFirstChild("TabSelection") if tabSel then tabSel.ImageTransparency = 0.4 end
            for _, v in pairs(windowFrame:GetDescendants()) do
                pcall(function()
                    if v:IsA("ImageLabel") and v.Name=="TextButton_Roundify_4px" then
                        if v.Parent and v.Parent.Name ~= "TabButton" then v.ImageTransparency = 0 end
                    end
                    if v:IsA("ImageButton") and v.Name=="Box" then v.ImageTransparency = 0.1 end
                end)
            end
            local defColors = {Color3.fromRGB(10,0,40),Color3.fromRGB(60,0,120),Color3.fromRGB(120,0,180),Color3.fromRGB(180,0,255),Color3.fromRGB(255,50,180)}
            for _, v in pairs(windowFrame:GetDescendants()) do
                pcall(function()
                    if v:IsA("Frame") and v.Name=="Bar" then applyGradient(v,defColors) end
                    if v:IsA("ImageLabel") and v.Name=="TextButton_Roundify_4px" then
                        if v.Parent and v.Parent.Name ~= "TabButton" then applyGradient(v,{defColors[1],defColors[3]}) end
                    end
                    if v:IsA("ImageButton") and v.Name=="Box" then applyGradient(v,{defColors[1],defColors[2]}) end
                end)
            end
            if watermark then watermark:Destroy() watermark = nil end
        end)
    end)

    addBodoniLabel(settingsTab, "RAINBOW MODE:", Color3.fromRGB(255, 50, 150))

    local isRainbow    = false
    local rainbowSpeed = 0.003
    settingsTab:AddSwitch("Rainbow Gui", function(state)
        isRainbow = state
        if not state then return end
        task.spawn(function()
            local hue, pulseT = 0, 0
            while isRainbow do
                hue = (hue + rainbowSpeed) % 1 pulseT = pulseT + 0.04
                local c1=Color3.fromHSV(hue,1,1) local c2=Color3.fromHSV((hue+0.16)%1,1,1)
                local c3=Color3.fromHSV((hue+0.33)%1,1,1) local c4=Color3.fromHSV((hue+0.50)%1,1,1)
                local c5=Color3.fromHSV((hue+0.66)%1,1,1) local c6=Color3.fromHSV((hue+0.83)%1,1,1)
                local pulse = 0.75 + math.abs(math.sin(pulseT)) * 0.25
                local d1=Color3.fromHSV(hue,1,0.15*pulse) local d2=Color3.fromHSV((hue+0.33)%1,1,0.25*pulse) local d3=Color3.fromHSV((hue+0.66)%1,1,0.35*pulse)
                local m1=Color3.fromHSV(hue,1,0.35*pulse) local m2=Color3.fromHSV((hue+0.25)%1,1,0.5*pulse)  local m3=Color3.fromHSV((hue+0.5)%1,1,0.6*pulse)
                pcall(function()
                    for _, v in pairs(windowFrame:GetDescendants()) do pcall(function()
                        if v:IsA("Frame") and v.Name=="Bar" then
                            local g = v:FindFirstChildOfClass("UIGradient") if not g then g=Instance.new("UIGradient") g.Parent=v end
                            g.Rotation = (pulseT*20)%360
                            g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,c1),ColorSequenceKeypoint.new(0.2,c2),ColorSequenceKeypoint.new(0.4,c3),ColorSequenceKeypoint.new(0.6,c4),ColorSequenceKeypoint.new(0.8,c5),ColorSequenceKeypoint.new(1,c6)})
                            v.BackgroundColor3 = Color3.new(1,1,1)
                        end
                        if v:IsA("ImageLabel") and v.Name=="TabSelection" then
                            local g = v:FindFirstChildOfClass("UIGradient") if not g then g=Instance.new("UIGradient") g.Parent=v end
                            g.Rotation = (pulseT*15)%360
                            g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,c1),ColorSequenceKeypoint.new(0.2,c2),ColorSequenceKeypoint.new(0.4,c3),ColorSequenceKeypoint.new(0.6,c4),ColorSequenceKeypoint.new(0.8,c5),ColorSequenceKeypoint.new(1,c6)})
                            v.ImageColor3 = Color3.new(1,1,1)
                        end
                        if v:IsA("ImageLabel") and v.Name=="Window" then
                            local g = v:FindFirstChildOfClass("UIGradient") if not g then g=Instance.new("UIGradient") g.Parent=v end
                            g.Rotation = (pulseT*10)%360
                            g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,d1),ColorSequenceKeypoint.new(0.5,d2),ColorSequenceKeypoint.new(1,d3)})
                            v.ImageColor3 = Color3.new(1,1,1)
                        end
                        if v:IsA("ImageLabel") and v.Name=="TextButton_Roundify_4px" then
                            if v.Parent and v.Parent.Name ~= "TabButton" then
                                local g = v:FindFirstChildOfClass("UIGradient") if not g then g=Instance.new("UIGradient") g.Parent=v end
                                g.Rotation = 45
                                g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,m1),ColorSequenceKeypoint.new(0.5,m2),ColorSequenceKeypoint.new(1,m3)})
                                v.ImageColor3 = Color3.new(1,1,1)
                            end
                        end
                        if v:IsA("ImageButton") and v.Name=="Box" then
                            local g = v:FindFirstChildOfClass("UIGradient") if not g then g=Instance.new("UIGradient") g.Parent=v end
                            g.Rotation = 45
                            g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,d1),ColorSequenceKeypoint.new(0.5,d2),ColorSequenceKeypoint.new(1,d3)})
                            v.ImageColor3 = Color3.new(1,1,1)
                        end
                    end) end
                end)
                task.wait(0.03)
            end
        end)
    end)

    addBodoniLabel(settingsTab, "RAINBOW SPEED:", Color3.fromRGB(255, 180, 0))
    local speedOpts = {"Slow","Normal","Fast","Very Fast","Ultra Fast"}
    local speedVals  = {0.001, 0.003, 0.006, 0.012, 0.025}
    local speedDD = settingsTab:AddDropdown("Rainbow Speed", function(selected)
        for i, lbl in ipairs(speedOpts) do if lbl == selected then rainbowSpeed = speedVals[i] break end end
    end)
    for _, lbl in ipairs(speedOpts) do speedDD:Add(lbl) end

    addBodoniLabel(settingsTab, "WINDOW SIZE:", Color3.fromRGB(100, 200, 255))
    local sizeOpts = {"Small (400x280)","Medium (500x380)","Large (600x480)","Extra Large (700x550)"}
    local sizeVals  = {Vector2.new(400,280),Vector2.new(500,380),Vector2.new(600,480),Vector2.new(700,550)}
    local sizeDD = settingsTab:AddDropdown("Window Size", function(selected)
        for i, lbl in ipairs(sizeOpts) do
            if lbl == selected then
                pcall(function() windowFrame.Size = UDim2.new(0,sizeVals[i].X,0,sizeVals[i].Y) end)
                break
            end
        end
    end)
    for _, lbl in ipairs(sizeOpts) do sizeDD:Add(lbl) end
end

-- ================= INFO TAB =================
do
    local myLabel = infoTab:AddLabel("Muscle Masters")
    myLabel.Font = Enum.Font.Antique
    myLabel.TextSize = 25
    myLabel.TextXAlignment = Enum.TextXAlignment.Center
    myLabel.Size = UDim2.new(1,0,0,25)
    local g1 = Instance.new("UIGradient")
    g1.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(255, 0,   0)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 165, 0)),
        ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(0,   255, 100)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0,   100, 255)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(180, 0,   255)),
    })
    g1.Parent = myLabel

    local devLabel = infoTab:AddLabel("Jelo Warfreak")
    devLabel.Font = Enum.Font.PermanentMarker
    devLabel.TextSize = 22
    devLabel.TextXAlignment = Enum.TextXAlignment.Center
    devLabel.Size = UDim2.new(1,0,0,25)
    local g2 = Instance.new("UIGradient")
    g2.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(255, 50,  150)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 0)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(255, 50,  150)),
    })
    g2.Parent = devLabel

    local madeLabel = infoTab:AddLabel("THIS SCRIPT MADE BY JELO WITH HARDWORK & DEDICATION")
    madeLabel.Font = Enum.Font.Bodoni
    madeLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    local ms = Instance.new("UIStroke")
    ms.Thickness = 0.5
    ms.Color = Color3.fromRGB(255, 215, 0)
    ms.Parent = madeLabel

    local devLbl = infoTab:AddLabel("Developer: Jelo Warfreak")
    devLbl.Font = Enum.Font.PermanentMarker
    devLbl.TextColor3 = Color3.fromRGB(200, 150, 255)
    local ds = Instance.new("UIStroke")
    ds.Thickness = 0.5
    ds.Color = Color3.fromRGB(200, 150, 255)
    ds.Parent = devLbl

    local tiktokLabel = infoTab:AddLabel("Follow me on TikTok!")
    tiktokLabel.Font = Enum.Font.PermanentMarker
    tiktokLabel.TextSize = 18
    tiktokLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    local ts = Instance.new("UIStroke")
    ts.Thickness = 0.5
    ts.Color = Color3.fromRGB(0, 200, 255)
    ts.Parent = tiktokLabel

    infoTab:AddButton("Copy TikTok Link", function()
        pcall(function()
            setclipboard("https://www.tiktok.com/@notavailable...8?_r=1&_t=ZS-95SobuhstnO")
        end)
    end)
end

-- ================= MAIN LOOPS =================
task.spawn(function()
    while true do
        task.wait(0.008)
        if selectedTarget and not isAutoKillAll then
            local myRoot = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local tc = selectedTarget.Character
                local tRoot = tc and tc:FindFirstChild("HumanoidRootPart")
                if tRoot then
                    if isSticking then
                        local cf = getPunchCFrame(selectedTarget)
                        if cf then myRoot.CFrame = cf end
                    end
                    if isAutoPunch then
                        AutoEquipPunch()
                        pcall(function() BodyMovement:FireServer(-0.9848077297210693) end)
                        handIndex = (handIndex % #hands) + 1
                        pcall(function() PunchEvent:FireServer(tc, hands[handIndex]) end)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.008)
        if isAutoKillAll then
            local myRoot = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local targets = {}
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= Player and not whitelist[plr.UserId] then
                        local tc = plr.Character
                        if tc then
                            local hum = tc:FindFirstChild("Humanoid")
                            local tRoot = tc:FindFirstChild("HumanoidRootPart")
                            if hum and hum.Health > 0 and tRoot then table.insert(targets, plr) end
                        end
                    end
                end
                if #targets == 0 then task.wait(0.5) else
                    for _, plr in ipairs(targets) do
                        if not isAutoKillAll then break end
                        if whitelist[plr.UserId] then continue end
                        local tc = plr.Character
                        if tc then
                            local hum = tc:FindFirstChild("Humanoid")
                            local tRoot = tc:FindFirstChild("HumanoidRootPart")
                            if hum and tRoot then
                                while isAutoKillAll and hum and hum.Health > 0 and tRoot and tRoot.Parent do
                                    task.wait(0.008)
                                    if whitelist[plr.UserId] then break end
                                    local myR = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                                    if not myR then break end
                                    local cf = getPunchCFrame(plr)
                                    if cf then myR.CFrame = cf end
                                    AutoEquipPunch()
                                    pcall(function() BodyMovement:FireServer(-0.9848077297210693) end)
                                    handIndex = (handIndex % #hands) + 1
                                    pcall(function() PunchEvent:FireServer(tc, hands[handIndex]) end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.008)
        if isTinyCombo and selectedTarget then
            local myRoot = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local tc = selectedTarget.Character
                local tRoot = tc and tc:FindFirstChild("HumanoidRootPart")
                if tRoot then
                    myRoot.CFrame = CFrame.new(tRoot.Position)
                    AutoEquipPunch()
                    pcall(function() BodyMovement:FireServer(-0.9848077297210693) end)
                    handIndex = (handIndex % #hands) + 1
                    pcall(function() PunchEvent:FireServer(tc, hands[handIndex]) end)
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if isapin then
            local now = tick()
            if now - lastSpinTime >= SPIN_COOLDOWN then
                lastSpinTime = now
                pcall(function() spinfu:InvokeServer() end)
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if isAutolift then
            if machineuse.Value == nil then
                pcall(function() machineactive:InvokeServer(bechmemp, true) end)
            else
                pcall(function() MachineActiveEvent:FireServer() end)
            end
        end
        if isAutoGlitch then
            if machineuse.Value == nil then
                pcall(function() machineactive:InvokeServer(squatOcean, true) end)
            else
                pcall(function() MachineActiveEvent:FireServer() end)
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if isAutoHatch then
            local now = tick()
            if now - lastHatchTime >= HATCH_COOLDOWN then
                lastHatchTime = now
                pcall(function()
                    local prompt = getEggPrompt(selectedEggFolder)
                    if prompt then fireproximityprompt(prompt) end
                end)
            end
        end
        if isAutoSell then
            local petsItem = getPetsMenu()
            if petsItem then
                for _, petFolder in ipairs(petsItem:GetChildren()) do
                    local petName = petFolder.Name
                    if selectedSellPets[petName] then
                        local statFolder = petFolder:FindFirstChild("PetStatFolder")
                        local sellVal = statFolder and statFolder:FindFirstChild("SellEnable")
                        if not sellVal or sellVal.Value == true then
                            pcall(function() SellPetEvent:FireServer(petFolder) end)
                            task.wait(0.2)
                        end
                    end
                end
            end
        end
        if isAutoChest then
            local now = tick()
            if now - lastChestTime >= CHEST_COOLDOWN then
                lastChestTime = now
                for _, chest in ipairs(chestsFolder:GetChildren()) do
                    pcall(function()
                        local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                        if root and chest:IsA("BasePart") then
                            root.CFrame = CFrame.new(chest.Position + Vector3.new(0,5,0))
                            task.wait(0.3)
                            ChestClaimEvent:FireServer(chest)
                        end
                    end)
                    task.wait(0.3)
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(10)
        if isAutoRewards then claimAllRewards() end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.1)
        if isAutoEat and not isEating then
            local now = tick()
            if now - lastEatTime >= EAT_COOLDOWN then
                lastEatTime = now
                task.spawn(function()
                    isEating = true
                    pcall(function()
                        local char = Player.Character
                        if not char then isEating = false return end
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if not hum then isEating = false return end
                        local bp = Player:FindFirstChild("Backpack")
                        if not bp then isEating = false return end
                        local choco = nil
                        for _, tool in pairs(bp:GetChildren()) do
                            if string.lower(tool.Name):find("chocolate") then choco = tool break end
                        end
                        if not choco then
                            local chocoFolder = Player:FindFirstChild("ChocolatesFolder")
                            if not chocoFolder then isEating = false return end
                            local c = chocoFolder:FindFirstChildOfClass("Tool")
                            if not c then isEating = false return end
                            c.Parent = bp task.wait(0.2) choco = bp:FindFirstChild(c.Name)
                        end
                        if not choco then isEating = false return end
                        hum:EquipTool(choco) task.wait(0.1)
                        local equipped = char:FindFirstChild(choco.Name)
                        if equipped then
                            equipped:Activate()
                            pcall(function() ChocolateEatEvent:FireServer(equipped) end)
                            task.wait(0.1) totalChocoEaten = totalChocoEaten + 1
                        end
                    end)
                    isEating = false
                end)
            end
        end
    end
end)

task.spawn(function()
    task.wait(3)
    local imgui = game.CoreGui:FindFirstChild("imgui")
    if not imgui then return end
    while true do
        task.wait(0.1)
        pcall(function()
            for _, v in ipairs(imgui:GetDescendants()) do
                if v:IsA("TextButton") then
                    local txt = v.Text or ""
                    if string.find(txt,"HIDE") or string.find(txt,"SHOW")
                    or string.find(txt,"ISLANDS") or string.find(txt,"TELEPORT TO CHEST")
                    or string.find(txt,"Main") or string.find(txt,"Stone Realm")
                    or string.find(txt,"Frost") or string.find(txt,"Muscle Emperor")
                    or string.find(txt,"Folder Island") or string.find(txt,"Ocean")
                    or string.find(txt,"Big Chest") or string.find(txt,"Legend Chest")
                    or string.find(txt,"Stone Chest") or string.find(txt,"Frost Chest")
                    or string.find(txt,"Master Chest") or string.find(txt,"Emperor Chest")
                    or string.find(txt,"Ocean Chest") then
                        v.TextColor3 = Color3.fromRGB(255,255,255)
                    end
                end
            end
        end)
    end
end)

strong.Changed:Connect(function()
    if isAuto then pcall(function() remoterebirths:FireServer() end) end
end)
nd)
