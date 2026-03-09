--[[
    Muscle Masters Professional Hub--[[
    MUSCLE LEGENDS HUB - Delta Mobile Version
    Versão: 1.0 Mobile
    Autor: Desenvolvimento Profissional
    Otimizado para tela de celular
]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Variáveis
local hubVisible = true
local currentTab = "Main"
local settings = {
    autoTrain = false,
    autoCollect = false,
    autoSell = false,
    infiniteJump = false,
    walkSpeed = 16,
    jumpPower = 50,
    eggsAmount = 10
}

-- Cores
local colors = {
    bg = Color3.fromRGB(20, 20, 30),
    surface = Color3.fromRGB(30, 30, 40),
    primary = Color3.fromRGB(0, 160, 255),
    text = Color3.fromRGB(255, 255, 255),
    success = Color3.fromRGB(0, 200, 0),
    danger = Color3.fromRGB(255, 50, 50)
}

-- Criar UI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MuscleLegendsHub"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame Principal (Tamanho adaptado para mobile)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 600) -- Mais fino e comprido para mobile
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -300)
mainFrame.BackgroundColor3 = colors.bg
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Cantos arredondados
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Barra Superior (maior para mobile)
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundColor3 = colors.surface
topBar.BackgroundTransparency = 0.2
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 12)
topCorner.Parent = topBar

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "💪 MUSCLE HUB"
title.TextColor3 = colors.primary
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Botões da barra (maiores para toque)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -45, 0.5, -20)
closeBtn.BackgroundColor3 = colors.danger
closeBtn.BackgroundTransparency = 0.2
closeBtn.Text = "X"
closeBtn.TextColor3 = colors.text
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- Botão Minimizar
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 40, 0, 40)
minBtn.Position = UDim2.new(1, -90, 0.5, -20)
minBtn.BackgroundColor3 = colors.surface
minBtn.BackgroundTransparency = 0.2
minBtn.Text = "—"
minBtn.TextColor3 = colors.text
minBtn.TextScaled = true
minBtn.Font = Enum.Font.GothamBold
minBtn.BorderSizePixel = 0
minBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minBtn

-- Abas (roláveis horizontalmente para mobile)
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 0, 50)
tabContainer.Position = UDim2.new(0, 0, 0, 45)
tabContainer.BackgroundColor3 = colors.surface
tabContainer.BackgroundTransparency = 0.2
tabContainer.BorderSizePixel = 0
tabContainer.Parent = mainFrame

local tabList = Instance.new("ScrollingFrame")
tabList.Size = UDim2.new(1, 0, 1, 0)
tabList.BackgroundTransparency = 1
tabList.BorderSizePixel = 0
tabList.ScrollBarThickness = 0
tabList.CanvasSize = UDim2.new(2, 0, 0, 0)
tabList.Parent = tabContainer

local tabs = {"Main", "Player", "Pets", "Teleport", "Settings"}
local tabButtons = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 40)
    btn.Position = UDim2.new(0, 10 + (i-1) * 110, 0, 5)
    btn.BackgroundColor3 = i == 1 and colors.primary or colors.bg
    btn.BackgroundTransparency = 0.2
    btn.Text = tabName
    btn.TextColor3 = colors.text
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = tabList
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        currentTab = tabName
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = colors.bg
        end
        btn.BackgroundColor3 = colors.primary
        updateContent()
    end)
    
    table.insert(tabButtons, btn)
end

-- Área de Conteúdo (rolável para mobile)
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -10, 1, -115)
contentContainer.Position = UDim2.new(0, 5, 0, 100)
contentContainer.BackgroundColor3 = colors.surface
contentContainer.BackgroundTransparency = 0.3
contentContainer.BorderSizePixel = 0
contentContainer.ClipsDescendants = true
contentContainer.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 12)
contentCorner.Parent = contentContainer

local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, 0, 1, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 4
contentFrame.ScrollBarImageColor3 = colors.primary
contentFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
contentFrame.Parent = contentContainer

-- Funções auxiliares (adaptadas para mobile)
function createToggle(parent, text, yPos, setting)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 55) -- Mais alto para toque
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = colors.bg
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = colors.text
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 80, 0, 40) -- Botão maior
    toggleBtn.Position = UDim2.new(1, -90, 0.5, -20)
    toggleBtn.BackgroundColor3 = settings[setting] and colors.success or colors.danger
    toggleBtn.BackgroundTransparency = 0.2
    toggleBtn.Text = settings[setting] and "ON" or "OFF"
    toggleBtn.TextColor3 = colors.text
    toggleBtn.TextScaled = true
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleBtn
    
    toggleBtn.MouseButton1Click:Connect(function()
        settings[setting] = not settings[setting]
        toggleBtn.BackgroundColor3 = settings[setting] and colors.success or colors.danger
        toggleBtn.Text = settings[setting] and "ON" or "OFF"
    end)
end

function createButton(parent, text, yPos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 55) -- Botão maior
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.2
    btn.Text = text
    btn.TextColor3 = colors.text
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
end

function createTextBox(parent, text, yPos, setting)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 70)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = colors.bg
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = colors.text
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -20, 0, 35)
    textBox.Position = UDim2.new(0, 10, 0, 30)
    textBox.BackgroundColor3 = colors.surface
    textBox.BackgroundTransparency = 0.2
    textBox.Text = tostring(settings[setting])
    textBox.TextColor3 = colors.text
    textBox.TextScaled = true
    textBox.Font = Enum.Font.Gotham
    textBox.PlaceholderText = "Digite um valor"
    textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    textBox.BorderSizePixel = 0
    textBox.Parent = frame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = textBox
    
    textBox.FocusLost:Connect(function()
        local amount = tonumber(textBox.Text)
        if amount and amount > 0 then
            settings[setting] = math.floor(amount)
        else
            textBox.Text = tostring(settings[setting])
        end
    end)
end

-- Função para atualizar conteúdo
function updateContent()
    for _, child in ipairs(contentFrame:GetChildren()) do
        child:Destroy()
    end
    
    local yPos = 10
    
    if currentTab == "Main" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -20, 0, 35)
        title.Position = UDim2.new(0, 10, 0, yPos)
        title.BackgroundTransparency = 1
        title.Text = "⚡ MAIN CONTROLS"
        title.TextColor3 = colors.primary
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = contentFrame
        yPos = yPos + 40
        
        createToggle(contentFrame, "Auto Train", yPos, "autoTrain")
        yPos = yPos + 60
        createToggle(contentFrame, "Auto Collect", yPos, "autoCollect")
        yPos = yPos + 60
        createToggle(contentFrame, "Auto Sell", yPos, "autoSell")
        yPos = yPos + 70
        
        local strengthLabel = Instance.new("TextLabel")
        strengthLabel.Size = UDim2.new(1, -20, 0, 35)
        strengthLabel.Position = UDim2.new(0, 10, 0, yPos)
        strengthLabel.BackgroundTransparency = 1
        strengthLabel.Text = "💪 STRENGTH: 0"
        strengthLabel.TextColor3 = colors.text
        strengthLabel.TextScaled = true
        strengthLabel.Font = Enum.Font.GothamBold
        strengthLabel.TextXAlignment = Enum.TextXAlignment.Left
        strengthLabel.Parent = contentFrame
        yPos = yPos + 40
        
        local coinsLabel = Instance.new("TextLabel")
        coinsLabel.Size = UDim2.new(1, -20, 0, 35)
        coinsLabel.Position = UDim2.new(0, 10, 0, yPos)
        coinsLabel.BackgroundTransparency = 1
        coinsLabel.Text = "🪙 COINS: 0"
        coinsLabel.TextColor3 = colors.primary
        coinsLabel.TextScaled = true
        coinsLabel.Font = Enum.Font.GothamBold
        coinsLabel.TextXAlignment = Enum.TextXAlignment.Left
        coinsLabel.Parent = contentFrame
        
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)
        
    elseif currentTab == "Player" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -20, 0, 35)
        title.Position = UDim2.new(0, 10, 0, yPos)
        title.BackgroundTransparency = 1
        title.Text = "⚡ PLAYER SETTINGS"
        title.TextColor3 = colors.primary
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = contentFrame
        yPos = yPos + 40
        
        -- Sliders simplificados para mobile
        local wsLabel = Instance.new("TextLabel")
        wsLabel.Size = UDim2.new(1, -20, 0, 30)
        wsLabel.Position = UDim2.new(0, 10, 0, yPos)
        wsLabel.BackgroundTransparency = 1
        wsLabel.Text = "WalkSpeed: " .. settings.walkSpeed
        wsLabel.TextColor3 = colors.text
        wsLabel.TextScaled = true
        wsLabel.Font = Enum.Font.Gotham
        wsLabel.TextXAlignment = Enum.TextXAlignment.Left
        wsLabel.Parent = contentFrame
        yPos = yPos + 35
        
        createToggle(contentFrame, "Infinite Jump", yPos, "infiniteJump")
        yPos = yPos + 60
        
        createButton(contentFrame, "RESET CHARACTER", yPos, colors.danger, function()
            if player.Character then
                player.Character:BreakJoints()
            end
        end)
        
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 60)
        
    elseif currentTab == "Pets" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -20, 0, 35)
        title.Position = UDim2.new(0, 10, 0, yPos)
        title.BackgroundTransparency = 1
        title.Text = "⚡ PET MANAGER"
        title.TextColor3 = colors.primary
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = contentFrame
        yPos = yPos + 40
        
        createButton(contentFrame, "EQUIP BEST PETS", yPos, colors.success, function()
            print("Equipando melhores pets...")
        end)
        yPos = yPos + 60
        
        createButton(contentFrame, "OPEN EGGS", yPos, colors.primary, function()
            print("Abrindo " .. settings.eggsAmount .. " ovos...")
        end)
        yPos = yPos + 60
        
        createTextBox(contentFrame, "Eggs Amount", yPos, "eggsAmount")
        
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 80)
        
    elseif currentTab == "Teleport" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -20, 0, 35)
        title.Position = UDim2.new(0, 10, 0, yPos)
        title.BackgroundTransparency = 1
        title.Text = "⚡ TELEPORT"
        title.TextColor3 = colors.primary
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = contentFrame
        yPos = yPos + 40
        
        createButton(contentFrame, "SPAWN", yPos, colors.surface, function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
            end
        end)
        yPos = yPos + 60
        
        createButton(contentFrame, "TRAINING AREA", yPos, colors.primary, function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(100, 10, 0)
            end
        end)
        yPos = yPos + 60
        
        createButton(contentFrame, "SHOP", yPos, colors.success, function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(200, 10, 0)
            end
        end)
        yPos = yPos + 60
        
        createButton(contentFrame, "REBIRTH AREA", yPos, colors.danger, function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(300, 10, 0)
            end
        end)
        
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 70)
        
    elseif currentTab == "Settings" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -20, 0, 35)
        title.Position = UDim2.new(0, 10, 0, yPos)
        title.BackgroundTransparency = 1
        title.Text = "⚡ SETTINGS"
        title.TextColor3 = colors.primary
        title.TextScaled = true
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = contentFrame
        yPos = yPos + 40
        
        createButton(contentFrame, "TOGGLE UI (F)", yPos, colors.primary, function()
            hubVisible = not hubVisible
            mainFrame.Visible = hubVisible
        end)
        yPos = yPos + 60
        
        createButton(contentFrame, "DESTROY HUB", yPos, colors.danger, function()
            screenGui:Destroy()
        end)
        
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, yPos + 70)
    end
end

-- Eventos
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    wait(0.1)
    mainFrame.Visible = true
    -- No mobile, minimizar pode esconder completamente
end)

-- Tecla F (se houver teclado no mobile)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        hubVisible = not hubVisible
        mainFrame.Visible = hubVisible
    end
end)

-- Iniciar
updateContent()

-- Aviso
print("✅ Muscle Hub Mobile carregado!")
print("📱 Arraste a barra superior para mover")
print("👆 Toque nos botões para ativar funções")
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
