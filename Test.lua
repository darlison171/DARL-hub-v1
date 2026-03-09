--[[
    Muscle Masters Professional Hub
    Versão: 2.0
    Autor: Desenvolvimento Profissional
    Características: UI Moderna, Sistema de Abas, Auto Farm, Configurações Salvas
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Variáveis Globais
local hubEnabled = true
local minimized = false
local currentTab = "Main"
local autoFarmConnections = {}
local settings = {}

-- Configurações padrão
local defaultSettings = {
    autoTrain = false,
    autoClickStrength = false,
    autoSell = false,
    autoEquipPets = false,
    autoFusePets = false,
    autoOpenEggs = false,
    eggsAmount = 10,
    autoFarmStrength = false,
    autoCollectDrops = false,
    autoRebirth = false,
    rebirthMinValue = 1000,
    walkSpeed = 16,
    jumpPower = 50,
    infiniteJump = false,
    hubMinimized = false
}

-- Carregar configurações salvas
local function loadSettings()
    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile("MuscleMastersSettings.json"))
    end)
    
    if success and data then
        settings = data
    else
        settings = defaultSettings
    end
end

-- Salvar configurações
local function saveSettings()
    local success = pcall(function()
        writefile("MuscleMastersSettings.json", HttpService:JSONEncode(settings))
    end)
end

-- Criar UI Principal
local function createMainUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MuscleMastersHub"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Frame principal com sombra
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 800, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    -- Sombra externa
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 30, 1, 30)
    shadow.Position = UDim2.new(0, -15, 0, -15)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = mainFrame
    
    -- Barra superior (para arrastar)
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    topBar.BackgroundTransparency = 0.2
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame
    
    -- Título do Hub
    local hubTitle = Instance.new("TextLabel")
    hubTitle.Name = "HubTitle"
    hubTitle.Size = UDim2.new(0, 200, 1, 0)
    hubTitle.Position = UDim2.new(0, 15, 0, 0)
    hubTitle.BackgroundTransparency = 1
    hubTitle.Text = "⚡ MUSCLE MASTERS HUB ⚡"
    hubTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
    hubTitle.TextScaled = true
    hubTitle.Font = Enum.Font.GothamBold
    hubTitle.TextXAlignment = Enum.TextXAlignment.Left
    hubTitle.Parent = topBar
    
    -- Botão minimizar
    local minimizeBtn = Instance.new("ImageButton")
    minimizeBtn.Name = "MinimizeBtn"
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -70, 0.5, -15)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    minimizeBtn.BackgroundTransparency = 0.3
    minimizeBtn.Image = "rbxassetid://3926305904"
    minimizeBtn.ImageRectOffset = Vector2.new(4, 244)
    minimizeBtn.ImageRectSize = Vector2.new(36, 36)
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = topBar
    
    -- Botão fechar
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
    closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    closeBtn.BackgroundTransparency = 0.3
    closeBtn.Image = "rbxassetid://3926305904"
    closeBtn.ImageRectOffset = Vector2.new(4, 4)
    closeBtn.ImageRectSize = Vector2.new(36, 36)
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = topBar
    
    -- Sidebar esquerda
    local sideBar = Instance.new("Frame")
    sideBar.Name = "SideBar"
    sideBar.Size = UDim2.new(0, 150, 1, -40)
    sideBar.Position = UDim2.new(0, 0, 0, 40)
    sideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    sideBar.BackgroundTransparency = 0.2
    sideBar.BorderSizePixel = 0
    sideBar.Parent = mainFrame
    
    -- Linha divisória
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(0, 2, 1, -20)
    divider.Position = UDim2.new(1, -2, 0, 10)
    divider.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    divider.BorderSizePixel = 0
    divider.Parent = sideBar
    
    -- Área de conteúdo
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -150, 1, -40)
    contentArea.Position = UDim2.new(0, 150, 0, 40)
    contentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    contentArea.BackgroundTransparency = 0.3
    contentArea.BorderSizePixel = 0
    contentArea.Parent = mainFrame
    
    return {
        screenGui = screenGui,
        mainFrame = mainFrame,
        sideBar = sideBar,
        contentArea = contentArea,
        minimizeBtn = minimizeBtn,
        closeBtn = closeBtn,
        topBar = topBar
    }
end

-- Criar botões de aba
local function createTabButtons(ui)
    local tabs = {
        {name = "MAIN", icon = "rbxassetid://3926305904", rect = Vector2.new(364, 84)},
        {name = "PLAYER", icon = "rbxassetid://3926305904", rect = Vector2.new(244, 4)},
        {name = "PETS", icon = "rbxassetid://3926305904", rect = Vector2.new(364, 164)},
        {name = "FARM", icon = "rbxassetid://3926305904", rect = Vector2.new(324, 44)},
        {name = "TELEPORT", icon = "rbxassetid://3926305904", rect = Vector2.new(44, 164)},
        {name = "SETTINGS", icon = "rbxassetid://3926305904", rect = Vector2.new(284, 244)}
    }
    
    local tabButtons = {}
    
    for i, tabData in ipairs(tabs) do
        local yPos = 10 + (i - 1) * 55
        
        local tabBtn = Instance.new("ImageButton")
        tabBtn.Name = tabData.name .. "Tab"
        tabBtn.Size = UDim2.new(1, -20, 0, 45)
        tabBtn.Position = UDim2.new(0, 10, 0, yPos)
        tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        tabBtn.BackgroundTransparency = 0.5
        tabBtn.Image = tabData.icon
        tabBtn.ImageRectOffset = tabData.rect
        tabBtn.ImageRectSize = Vector2.new(36, 36)
        tabBtn.BorderSizePixel = 0
        tabBtn.Parent = ui.sideBar
        
        -- Label da aba
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Name = "TabLabel"
        tabLabel.Size = UDim2.new(1, -45, 1, 0)
        tabLabel.Position = UDim2.new(0, 40, 0, 0)
        tabLabel.BackgroundTransparency = 1
        tabLabel.Text = tabData.name
        tabLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        tabLabel.TextScaled = true
        tabLabel.Font = Enum.Font.GothamBold
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        tabLabel.Parent = tabBtn
        
        -- Efeitos hover
        tabBtn.MouseEnter:Connect(function()
            if currentTab ~= tabData.name then
                TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
            end
        end)
        
        tabBtn.MouseLeave:Connect(function()
            if currentTab ~= tabData.name then
                TweenService:Create(tabBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
            end
        end)
        
        tabBtn.MouseButton1Click:Connect(function()
            currentTab = tabData.name
            updateContent(ui, currentTab)
            
            -- Atualizar aparência dos botões
            for _, btn in pairs(tabButtons) do
                TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
            end
            TweenService:Create(tabBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        end)
        
        table.insert(tabButtons, tabBtn)
    end
    
    return tabButtons
end

-- Criar conteúdo da aba Main
local function createMainTab(contentArea)
    -- Limpar área
    for _, child in ipairs(contentArea:GetChildren()) do
        child:Destroy()
    end
    
    -- Título da aba
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -40, 0, 50)
    title.Position = UDim2.new(0, 20, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "MAIN CONTROLS"
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = contentArea
    
    -- Indicadores
    local statsFrame = Instance.new("Frame")
    statsFrame.Name = "StatsFrame"
    statsFrame.Size = UDim2.new(1, -40, 0, 80)
    statsFrame.Position = UDim2.new(0, 20, 0, 80)
    statsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    statsFrame.BackgroundTransparency = 0.3
    statsFrame.BorderSizePixel = 0
    statsFrame.Parent = contentArea
    
    -- Strength atual
    local strengthLabel = Instance.new("TextLabel")
    strengthLabel.Name = "StrengthLabel"
    strengthLabel.Size = UDim2.new(0.5, -10, 0.5, -5)
    strengthLabel.Position = UDim2.new(0, 10, 0, 10)
    strengthLabel.BackgroundTransparency = 1
    strengthLabel.Text = "Strength: 0"
    strengthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    strengthLabel.TextScaled = true
    strengthLabel.Font = Enum.Font.Gotham
    strengthLabel.TextXAlignment = Enum.TextXAlignment.Left
    strengthLabel.Parent = statsFrame
    
    -- Coins atuais
    local coinsLabel = Instance.new("TextLabel")
    coinsLabel.Name = "CoinsLabel"
    coinsLabel.Size = UDim2.new(0.5, -10, 0.5, -5)
    coinsLabel.Position = UDim2.new(0.5, 0, 0, 10)
    coinsLabel.BackgroundTransparency = 1
    coinsLabel.Text = "Coins: 0"
    coinsLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    coinsLabel.TextScaled = true
    coinsLabel.Font = Enum.Font.Gotham
    coinsLabel.TextXAlignment = Enum.TextXAlignment.Left
    coinsLabel.Parent = statsFrame
    
    -- Auto Train
    local autoTrainBtn = createToggleButton(contentArea, "Auto Train", UDim2.new(0, 20, 0, 180), "autoTrain")
    
    -- Auto Click Strength
    local autoClickBtn = createToggleButton(contentArea, "Auto Click Strength", UDim2.new(0, 20, 0, 240), "autoClickStrength")
    
    -- Auto Sell
    local autoSellBtn = createToggleButton(contentArea, "Auto Sell", UDim2.new(0, 20, 0, 300), "autoSell")
    
    -- Atualizar stats periodicamente
    local function updateStats()
        -- Aqui você conecta com os valores reais do jogo
        strengthLabel.Text = "Strength: " .. tostring(settings.strength or 0)
        coinsLabel.Text = "Coins: " .. tostring(settings.coins or 0)
    end
    
    RunService.Heartbeat:Connect(updateStats)
end

-- Criar conteúdo da aba Player
local function createPlayerTab(contentArea)
    for _, child in ipairs(contentArea:GetChildren()) do
        child:Destroy()
    end
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -40, 0, 50)
    title.Position = UDim2.new(0, 20, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "PLAYER SETTINGS"
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = contentArea
    
    -- WalkSpeed Slider
    local wsLabel = Instance.new("TextLabel")
    wsLabel.Size = UDim2.new(1, -40, 0, 30)
    wsLabel.Position = UDim2.new(0, 20, 0, 80)
    wsLabel.BackgroundTransparency = 1
    wsLabel.Text = "WalkSpeed: " .. settings.walkSpeed
    wsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    wsLabel.TextScaled = true
    wsLabel.Font = Enum.Font.Gotham
    wsLabel.TextXAlignment = Enum.TextXAlignment.Left
    wsLabel.Parent = contentArea
    
    local wsSlider = createSlider(contentArea, UDim2.new(0, 20, 0, 120), 16, 100, settings.walkSpeed, function(value)
        settings.walkSpeed = value
        wsLabel.Text = "WalkSpeed: " .. value
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end)
    
    -- JumpPower Slider
    local jpLabel = Instance.new("TextLabel")
    jpLabel.Size = UDim2.new(1, -40, 0, 30)
    jpLabel.Position = UDim2.new(0, 20, 0, 170)
    jpLabel.BackgroundTransparency = 1
    jpLabel.Text = "JumpPower: " .. settings.jumpPower
    jpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    jpLabel.TextScaled = true
    jpLabel.Font = Enum.Font.Gotham
    jpLabel.TextXAlignment = Enum.TextXAlignment.Left
    jpLabel.Parent = contentArea
    
    local jpSlider = createSlider(contentArea, UDim2.new(0, 20, 0, 210), 50, 200, settings.jumpPower, function(value)
        settings.jumpPower = value
        jpLabel.Text = "JumpPower: " .. value
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end)
    
    -- Infinite Jump
    local infiniteJumpBtn = createToggleButton(contentArea, "Infinite Jump", UDim2.new(0, 20, 0, 260), "infiniteJump")
    
    infiniteJumpBtn.MouseButton1Click:Connect(function()
        settings.infiniteJump = not settings.infiniteJump
        updateToggleButton(infiniteJumpBtn, settings.infiniteJump)
        
        if settings.infiniteJump then
            local connection
            connection = UserInputService.JumpRequest:Connect(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
            autoFarmConnections.infiniteJump = connection
        else
            if autoFarmConnections.infiniteJump then
                autoFarmConnections.infiniteJump:Disconnect()
                autoFarmConnections.infiniteJump = nil
            end
        end
    end)
    
    -- Reset Character
    local resetBtn = Instance.new("TextButton")
    resetBtn.Name = "ResetBtn"
    resetBtn.Size = UDim2.new(1, -40, 0, 40)
    resetBtn.Position = UDim2.new(0, 20, 0, 320)
    resetBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    resetBtn.BackgroundTransparency = 0.2
    resetBtn.Text = "RESET CHARACTER"
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.TextScaled = true
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.BorderSizePixel = 0
    resetBtn.Parent = contentArea
    
    resetBtn.MouseButton1Click:Connect(function()
        if player.Character then
            player.Character:BreakJoints()
        end
    end)
end

-- Criar conteúdo da aba Pets
local function createPetsTab(contentArea)
    for _, child in ipairs(contentArea:GetChildren()) do
        child:Destroy()
    end
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 50)
    title.Position = UDim2.new(0, 20, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "PET MANAGER"
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = contentArea
    
    -- Auto Equip Best Pets
    local autoEquipBtn = createToggleButton(contentArea, "Auto Equip Best Pets", UDim2.new(0, 20, 0, 80), "autoEquipPets")
    
    -- Auto Fuse Pets
    local autoFuseBtn = createToggleButton(contentArea, "Auto Fuse Pets", UDim2.new(0, 20, 0, 140), "autoFusePets")
    
    -- Auto Open Eggs
    local autoOpenBtn = createToggleButton(contentArea, "Auto Open Eggs", UDim2.new(0, 20, 0, 200), "autoOpenEggs")
    
    -- TextBox para quantidade
    local eggsFrame = Instance.new("Frame")
    eggsFrame.Size = UDim2.new(1, -40, 0, 80)
    eggsFrame.Position = UDim2.new(0, 20, 0, 260)
    eggsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    eggsFrame.BackgroundTransparency = 0.3
    eggsFrame.BorderSizePixel = 0
    eggsFrame.Parent = contentArea
    
    local eggsLabel = Instance.new("TextLabel")
    eggsLabel.Size = UDim2.new(1, -20, 0, 30)
    eggsLabel.Position = UDim2.new(0, 10, 0, 10)
    eggsLabel.BackgroundTransparency = 1
    eggsLabel.Text = "Eggs Amount:"
    eggsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    eggsLabel.TextScaled = true
    eggsLabel.Font = Enum.Font.Gotham
    eggsLabel.TextXAlignment = Enum.TextXAlignment.Left
    eggsLabel.Parent = eggsFrame
    
    local eggsInput = Instance.new("TextBox")
    eggsInput.Size = UDim2.new(1, -20, 0, 30)
    eggsInput.Position = UDim2.new(0, 10, 0, 40)
    eggsInput.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    eggsInput.BackgroundTransparency = 0.1
    eggsInput.Text = tostring(settings.eggsAmount or 10)
    eggsInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    eggsInput.TextScaled = true
    eggsInput.Font = Enum.Font.Gotham
    eggsInput.BorderSizePixel = 0
    eggsInput.Parent = eggsFrame
    
    eggsInput.FocusLost:Connect(function()
        local amount = tonumber(eggsInput.Text)
        if amount and amount > 0 then
            settings.eggsAmount = math.floor(amount)
        else
            eggsInput.Text = tostring(settings.eggsAmount)
        end
    end)
end

-- Criar conteúdo da aba Farm
local function createFarmTab(contentArea)
    for _, child in ipairs(contentArea:GetChildren()) do
        child:Destroy()
    end
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 50)
    title.Position = UDim2.new(0, 20, 0, 20)
    title.BackgroundTransparency = 1
    title.Text = "AUTO FARM"
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = contentArea
    
    -- Auto Farm Strength
    local autoFarmBtn = createToggleButton(contentArea, "Auto Farm Strength", UDim2.new(0, 20, 0, 80), "autoFarmStrength")
    
    -- Auto Collect Drops
    local autoCollectBtn = createToggleButton(contentArea, "Auto Collect Drops", UDim2.new(0, 20, 0, 140), "autoCollectDrops")
    
    -- Auto Rebirth
    local autoRebirthBtn = createToggleButton(contentArea, "Auto Rebirth", UDim2.new(0, 20, 0, 200), "autoRebirth")
    
    -- TextBox rebirth mínimo
    local rebirthFrame = Instance.new("Frame")
    rebirthFrame.Size = UDim2.new(1, -40, 0, 80)
    rebirthFrame.Position = UDim2.new(0, 20, 0, 260)
    rebirthFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    rebirthFrame.BackgroundTransparency = 0.3
    rebirthFrame.BorderSizePixel = 0
    rebirthFrame.Parent = contentArea
    
    local rebirthLabel = Instance.new("TextLabel")
    rebirthLabel.Size = UDim2.new(1, -20, 0, 30)
    rebirthLabel.Position = UDim2.new(0, 10, 0, 10)
    rebirthLabel.BackgroundTransparency = 1
    rebirthLabel.Text = "Min Value for Rebirth:"
    rebirthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    rebirthLabel.TextScaled = true
    rebirthLabel.Font = Enum.Font.Gotham
    rebirthLabel.TextXAlignment = Enum.TextXAlignment.Left
    rebirthLabel.Pare
